;;
; Copyright Jacques Deschênes 2023  
; This file is part of stm8_ssd1306 
;
;     stm8_ssd1306 is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8_ssd1306 is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
;;

;-------------------------------
;  OLED diplay functions 
;
;  display buffer is 1024 bytes 
;  below stack 
;-------------------------------

;--------------------------
; set text cursor line
; input:
;    A  line {0..7}
;--------------------------
set_line:
    _clrz col
    _straz line
    _straz scroll_line 
    add a,#0xB0 
    call oled_cmd 
    _send_cmd COL_WND 
    _send_cmd 0 
    _send_cmd (DISP_WIDTH-1)
    ret 

;---------------------------
; set display start line 
;----------------------------
scroll_up:
    sll a 
    sll a 
    sll a 
    push a 
    _send_cmd DISP_OFFSET
    pop a  
    jp oled_cmd
;    ret 

;---------------------------
;  clear line 
;  expect disp_buffer cleared 
;  input:
;     A    line #
;---------------------------
line_clear:
    call set_line 
    clr disp_buffer 
    ldw x,#DISPLAY_BUFFER_SIZE 
    jp oled_data

;----------------------
; zero's display buffer 
; input: 
;   none 
;----------------------
clear_disp_buffer:
    pushw x 
    push a 
    ldw x,#disp_buffer 
    ld a,#DISPLAY_BUFFER_SIZE
1$: clr(x)
    incw x 
    dec a 
    jrne 1$
    pop a 
    popw x 
    ret 

;--------------------------
;  zero's SSD1306 RAM 
;--------------------------
display_clear:
    push a 
    call clear_disp_buffer
    push #7
2$: ld a,(1,sp)
    call line_clear 
    dec (1,sp)
    jrpl 2$ 
    _drop 1 
    clr a 
    _straz col
    _straz line
    _straz scroll_line  
    call set_line
    clr a 
    call scroll_up 
    pop a 
    ret 

;-----------------------
; send text cursor 
; at next line 
;------------------------
crlf:
    _clrz col 
    _ldaz line
    inc a 
    and a,#7 
    _straz line 
    call clear_disp_buffer 
    _ldaz line 
    call line_clear
    _ldaz line 
    call set_line
    _ldaz scroll_line 
    inc a  
    cp a,#8
    jrmi 6$ 
    _ldaz line
    inc a   
    call scroll_up 
    ret 
6$: _straz scroll_line  
    ret 

;-----------------------
; move cursor right 
; 1 character position
; scroll up if needed 
;-----------------------
cursor_right:
    _ldaz col 
    add a,#1  
    _straz col 
    cp a,#21 
    jrmi 9$
    call crlf 
9$: ret 

;----------------------------
; put char using rotated font 
; input:
;    A    character 
;-----------------------------
put_char:
    pushw x
    pushw y 
	sub a,#32
	ldw x,#OLED_FONT_WIDTH
	mul x,a 
	addw x,#oled_font_6x8
    ldw y,x 
    ldw x,#disp_buffer
    push #OLED_FONT_WIDTH
1$:
    ld a,(y)
    ld (x),a 
    incw x 
    incw y 
    dec (1,sp)
    jrne 1$ 
    _drop 1
    ldw x,#OLED_FONT_WIDTH
    call oled_data 
    call cursor_right 
    popw y
    popw x 
    ret 


;----------------------
; put string in display 
; buffer 
; input:
;    y  .asciz  
;----------------------
put_string:
1$: ld a,(y)
    jreq 9$
    cp a,#'\n'
    jrne 2$
    call crlf 
    jra 4$
2$:
    call put_char 
4$:
    incw y 
    jra 1$

9$:  
    ret 

;-------------------
; put byte in hex 
; input:
;   A 
;------------------
put_byte:
    push a 
    swap a 
    call put_hex 
    pop a 
put_hex:    
    and a,#0xf 
    add a,#'0 
    cp a,#'9+1 
    jrmi 2$ 
    add a,#7 
2$: call put_char 
    ret 

;----------------------------
; put hexadecimal integer 
; in display 
; buffer 
; input:
;    X    integer to display 
;---------------------------
put_hex_int:
    ld a,xh 
    call put_byte 
    ld a,xl 
    call put_byte 
    ret 


;----------------------------
; copy bytes from (y) to (x)
; input:
;   a    count 
;   x    destination 
;   y    source 
;---------------------------
cmove:
    tnz a  
    jreq 9$ 
    push a 
1$: ld a,(y)
    ld (x),a 
    incw y 
    incw x 
    dec(1,sp)
    jrne 1$
    _drop 1 
9$:    
    ret 


;--------------------------
; put zoomed character 
; at current line,col position 
; input:
;     Y    24 bytes font data 
;---------------------------
    XSAVE=1
    LSAVE=3
    CSAVE=4
    BYTE_CNT=5
    VAR_SIZE=5
put_zoom_char:
    _vars VAR_SIZE 
    ldw (XSAVE,sp),x  
    _ldxz line 
    ldw (LSAVE,sp),x 
    ldw x, #disp_buffer
    ld a,#2*OLED_FONT_WIDTH
    call cmove 
    ldw x,#2*OLED_FONT_WIDTH
    call oled_data
    ld a,(LSAVE,sp)
    inc a 
    call set_line
    ld a,(CSAVE,sp)
    tnz a 
    jreq 4$ 
; put <col> spaces to display     
    ld (BYTE_CNT,sp),a 
2$: ld a,#SPACE 
    call put_char 
    dec (BYTE_CNT,sp)
    jrne 2$ 
4$: ldw x,#disp_buffer 
    ld a,#2*OLED_FONT_WIDTH 
    call cmove 
    ldw x,#2*OLED_FONT_WIDTH
    call oled_data 
    ldw x,(XSAVE,sp)
    _drop VAR_SIZE 
    ret 


;---------------------
; zoom 6x8 character 
; to 12x16 pixel 
; input:
;    A    character 
;    Y    output_buffer
; output:
;    Y    *zoom data  
;----------------------
    BIT_CNT=1 
    BYTE_CNT=2
    BUFFER=3
    VAR_SIZE=4
zoom_char:
    _vars VAR_SIZE 
    ldw (BUFFER,sp),y 
    sub a,#32 
    ldw x,#OLED_FONT_WIDTH 
    mul x,y 
    addw x,#oled_font_6x8
    ld a,#OLED_FONT_WIDTH
    ld (BYTE_CNT,sp),a
1$: ; byte loop 
    ld a,#8 
    ld (BIT_CNT,sp),a 
    ld a,(x)
    incw x
2$:    
    srl acc16 
    rrc acc8 
    srl acc16
    rrc acc8 
    srl a 
    bccm acc16,#7 
    bccm acc16,#6 
    dec (BIT_CNT,sp)
    jrne 2$ 
    _ldaz acc8 
    ld (y),a
    ld (1,y),a  
    _ldaz acc16 
    ld (2*OLED_FONT_WIDTH,y),a
    ld (2*OLED_FONT_WIDTH+1,y),a 
    addw y,#2 
    dec (BYTE_CNT,sp)
    jrne 1$
    ldw y,(BUFFER,sp) 
    _drop VAR_SIZE 
    ret 
