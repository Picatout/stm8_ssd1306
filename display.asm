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

; boolean flags  in 'disp_flags' 
F_SCROLL=0 ; display scroll active 
F_BIG=1 ; big font selected 

; small font display specifications
SMALL_CPL=21  ; character per line
SMALL_LINES=8 ; display lines 
SMALL_FONT_HEIGHT=OLED_FONT_HEIGHT  
SMALL_FONT_WIDTH=OLED_FONT_WIDTH 
SMALL_FONT_SIZE=6 ; character font bytes  

; big font display specifications 
BIG_CPL=10   ; character per line 
BIG_LINES=4  ; display lines 
BIG_FONT_HEIGHT=2*OLED_FONT_HEIGHT 
BIG_FONT_WIDTH=2*OLED_FONT_WIDTH 
BIG_FONT_SIZE=4*SMALL_FONT_SIZE ; character font bytes

; mega font specifications 
MEGA_CPL=5 
MEGA_LINES=2 
MEGA_FONT_HEIGHT=4*OLED_FONT_HEIGHT 
MEGA_FONT_WIDTH=4*OLED_FONT_WIDTH 
MEGA_FONT_SIZE=16*SMALL_FONT_SIZE 

; zoom modes 
SMALL=0 ; select small font 
BIG=1 ; select big font  


;--------------------------
; select font 
; input:
;    A   {SMALL,BIG}
;--------------------------
select_font:
    tnz a 
    jrne 2$ 
; small font 
    ld a,#SMALL_CPL 
    _straz cpl 
    ld a,#SMALL_LINES 
    _straz disp_lines 
    ld a,#SMALL_FONT_HEIGHT
    _straz font_height
    ld a,#SMALL_FONT_WIDTH
    _straz font_width
    ld a,#SMALL_FONT_SIZE
    _straz to_send
    sll line 
    sll col
    bres disp_flags,#F_BIG    
    ret 
2$: ; big font
    _ldaz col 
    cp a,#19
    jrpl 9$  ; request rejected 
    _ldaz line 
    cp a,#7
    jreq 9$  ; request rejected
    ld a,#BIG_CPL 
    _straz cpl 
    ld a,#BIG_LINES 
    _straz disp_lines 
    ld a,#BIG_FONT_HEIGHT
    _straz font_height
    ld a,#BIG_FONT_WIDTH
    _straz font_width
    ld a,#BIG_FONT_SIZE
    _straz to_send
    btjf line,#0,4$
    _incz line ; big font is lock step to even line  
4$:
    srl line 
    btjf col,#0,6$ 
    _incz col  ; big font is lock step to even column
6$:
    srl col
9$:
    bset disp_flags,#F_BIG    
    ret 


;------------------------
; set RAM window for 
; current line 
;-----------------------
line_window:
    pushw x 
    pushw y 
    ldw x,#0x7f ; columms: 0..127
    _ldaz line 
    btjf disp_flags,#F_BIG,1$ 
    sll a 
    ld yh,a 
    inc a 
    ld yl,a 
1$: call set_window 
    popw y 
    popw x
    ret 


;---------------------------
;  clear current line 
;---------------------------
line_clear:
    call line_window 
    call clear_disp_buffer
    ldw x,#DISPLAY_BUFFER_SIZE 
    call oled_data
    btjf disp_flags,#F_BIG,9$
    ldw x,#DISPLAY_BUFFER_SIZE
    call oled_data 
9$: ret 

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
    pushw x 
    call all_display 
    call clear_disp_buffer
    push #8
1$: ldw x,#DISPLAY_BUFFER_SIZE
    call oled_data
    dec (1,sp)
    jrne 1$ 
    _drop 1 
    _clrz line 
    _clrz col
    bres disp_flags,#F_SCROLL  
    popw x
    pop a 
    ret 

;---------------------------
; set display start line 
;----------------------------
scroll_up:
    call line_clear 
    _ldaz line 
    ld xl,a 
    ld a,font_height 
    mul x,a 
    ld a,xl 
    push a 
    _send_cmd DISP_OFFSET
    pop a  
    call oled_cmd
    ret 

;-----------------------
; send text cursor 
; at next line 
;------------------------
crlf:
    _clrz col 
    btjt disp_flags,#F_SCROLL,2$
    _ldaz line
    inc a
    cp a,disp_lines 
    jrpl 1$
    _straz line
    ret
1$: bset disp_flags,#F_SCROLL
    _clrz line       
2$:
    jp scroll_up     
 


;-----------------------
; move cursor right 
; 1 character position
; scroll up if needed 
;-----------------------
cursor_right:
    _ldaz col 
    add a,#1  
    _straz col 
    cp a,cpl  
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
    push a 
    _ldaz line
    btjf disp_flags,#F_BIG,0$ 
    sll a
    ld yh,a 
    inc a 
    ld yl,a
    jra 1$  
0$: 
    ld yl,a 
    ld yh,a 
1$:
    _ldaz col 
    ld xl,a 
    _ldaz font_width
    mul x,a 
    ld a,xl 
    ld xh,a 
    add a,font_width 
    dec a 
    ld xl,a 
    call set_window
    pop a 
 	sub a,#SPACE 
	ld yl,a  
    ld a,#OLED_FONT_WIDTH  
	mul y,a 
	addw y,#oled_font_6x8
    btjf disp_flags,#F_BIG,2$ 
    call zoom_char
    jra 3$  
2$:
    ldw x,#disp_buffer
    _ldaz to_send  
    call cmove 
3$: clrw x 
    _ldaz to_send  
    ld xl,a 
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

;-----------------------
; convert integer to 
; ASCII string 
; input:
;   X    integer 
; output:
;   Y     *string 
;------------------------
    SIGN=1
itoa:
    push #0 
    tnzw x 
    jrpl 1$ 
    cpl (SIGN,SP)
    negw x 
1$: ldw y,#free_ram+8
    clr(y)
2$:
    decw y 
    ld a,#10 
    div x,a 
    add a,#'0 
    ld (y),a 
    tnzw x 
    jrne 2$
    tnz (SIGN,sp)
    jrpl 4$
    decw y 
    ld a,#'-
    ld (y),a 
4$: _drop 1 
    ret 

;--------------------------
; put integer to display
; input:
;    X   integer 
;------------------------
put_int:
    pushw y 
    call itoa 
    call put_string 
    popw y 
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

;---------------------
; zoom 6x8 character 
; to 12x16 pixel 
; put data in disp_buffer 
; input:
;    Y   character font address  
;----------------------
    BIT_CNT=1 
    BYTE_CNT=2
    VAR_SIZE=2
zoom_char:
    _vars VAR_SIZE 
    ld a,#OLED_FONT_WIDTH
    ld (BYTE_CNT,sp),a
    ldw x,#disp_buffer 
1$: ; byte loop 
    ld a,#8 
    ld (BIT_CNT,sp),a 
    ld a,(y)
    incw y
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
    ld (x),a
    ld (1,x),a  
    _ldaz acc16 
    ld (2*OLED_FONT_WIDTH,x),a
    ld (2*OLED_FONT_WIDTH+1,x),a 
    addw x,#2 
    dec (BYTE_CNT,sp)
    jrne 1$
    _drop VAR_SIZE 
    ret 

;------------------------------
; magnify character 4X 
; resulting in 24x32 pixels font  
; font size 96 bytes 
; input:
;    A   character 
;    XH  page 
;    XL  column 
;------------------------------
    BIT_CNT=1 
    BYTE_CNT=2
    SHIFT_CNT=3 
    CHAR=4
    BYTE=5
    YSAVE=6
    VAR_SIZE=7
put_mega_char:
    _vars VAR_SIZE
    ldw (YSAVE,sp),y
    ld (CHAR,sp),a  
; set character window 
    ld a,xh 
    ld yh,a 
    add a,#MEGA_FONT_HEIGHT/8-1
    ld yl,a 
    swapw x 
    ld a,xh 
    add a,#MEGA_FONT_WIDTH-1
    ld xl,a 
    call set_window 
    ld a,(CHAR,sp)
    sub a,#SPACE 
    ld yl,a 
    ld a,#OLED_FONT_WIDTH
    ld (BYTE_CNT,sp),a 
    mul y,a 
    addw y,#oled_font_6x8
    ldw x,#disp_buffer 
1$: ; byte loop 
    ld a,#8 
    ld (BIT_CNT,sp),a 
    ld a,(y)
    ld (BYTE,sp),a 
    incw y
2$: ; bit loop 
    ld a,#3 
    ld (SHIFT_CNT,sp),a
    srl (BYTE,sp)
    rrc (72,x)  
    rrc (48,x)
    rrc (24,x)
    rrc (x)
3$: ; shift loop     
    sra (72,x) 
    rrc (48,x)
    rrc (24,x)
    rrc (x)
    dec (SHIFT_CNT,sp)
    jrne 3$ 
    dec (BIT_CNT,sp)
    jrne 2$ 
    ld a,#3
    ld (SHIFT_CNT,sp),a 
4$: ; copy bytes in width 
    ld a,(x)
    ld (1,x),a 
    ld a,(24,x)
    ld (25,x),a 
    ld a,(48,x)
    ld (49,x),a 
    ld a,(72,x)
    ld (73,x),a 
    incw x 
    dec (SHIFT_CNT,sp)
    jrne 4$ 
    dec (BYTE_CNT,sp)
    jrne 1$
    ldw x,#MEGA_FONT_SIZE
    call oled_data 
    ldw y,(YSAVE,sp)
    _drop VAR_SIZE 
    ret 

;--------------------
; put mega character 
; string 
;     XH   top page   
;     XL   left column  
;     Y    *string 
;--------------------
    PAGE=1 
    COL=2 
    VAR_SIZE=2 
put_mega_string:
    _vars VAR_SIZE 
    ldw (PAGE,sp),x 
1$:
    tnz (y)
    jreq 9$ 
    ldw x,(PAGE,sp)
    ld a,(y)
    incw y 
    call put_mega_char
    ld a,(COL,sp)
    add a,#MEGA_FONT_WIDTH
    LD (COL,sp),a 
    jra 1$
9$:
    _drop VAR_SIZE 
    ret 

