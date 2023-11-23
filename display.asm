;;
; Copyright Jacques Deschênes 2023  
; This file is part of stm8_chipcon 
;
;     stm8_chipcon is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     stm8_chipcon is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with stm8_chipcon.  If not, see <http://www.gnu.org/licenses/>.
;;

;-------------------------------
;  OLED diplay functions 
;
;  display buffer is 1024 bytes 
;  below stack 
;-------------------------------

;--------------------------
; select display page 
; input:
;    A  page {0..7}
;--------------------------
set_page:
    add a,#0xB0 
    call oled_cmd 
    _send_cmd COL_WND 
    _send_cmd 0 
    _send_cmd 127 
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
;  clear page 
;  expect disp_buffer cleared 
;  input:
;     A    page #
;---------------------------
page_clear:
    call set_page 
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
    call page_clear 
    dec (1,sp)
    jrpl 2$ 
    _drop 1 
    clr a 
    _straz cur_x
    _straz cur_y
    _straz start_page  
    call set_page
    clr a 
    call scroll_up 
    pop a 
    ret 

;-----------------------
; send text cursor 
; at next line 
;------------------------
crlf:
    _clrz cur_x 
    _ldaz cur_y
    inc a 
    and a,#7 
    _straz cur_y 
    call clear_disp_buffer 
    _ldaz cur_y 
    call page_clear
    _ldaz cur_y 
    call set_page
    _ldaz start_page 
    inc a  
    cp a,#8
    jrmi 6$ 
    _ldaz cur_y
    inc a   
    call scroll_up 
    ret 
6$: _straz start_page  
    ret 

;----------------------------
; set text cursor position 
; input:
;    XL   coloumn {0..20}
;    XH   line {0..7}
;----------------------------
curpos:
    _strxz cur_y 
    ld a,xh 
    call set_page 
    ret 

;-----------------------
; move cursor right 
; 1 character position
; scroll up if needed 
;-----------------------
cursor_right:
    _ldaz cur_x 
    add a,#1  
    _straz cur_x 
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
; put integer in display 
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

