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
;  zero fill display buffer 
;--------------------------
display_clear:
    pushw x 
    pushw y 
    ldw x,#disp_buffer
    ldw y,#DISPLAY_BUFFER_SIZE
1$:
    clr (x)
    incw x 
    decw y 
    jrne 1$
    _clrz cur_x 
    _clrz cur_y 
    popw y 
    popw x 
    ret 


;------------------------------
; refresh OLED with buffer data 
;------------------------------
display_refresh:
    pushw x 
    pushw y 
    call all_display 
    ldw y,#DISPLAY_BUFFER_SIZE+1
    ldw x,#(disp_buffer-1) 
    call oled_data 
    popw y 
    popw x 
    ret 

;----------------------------
; crate bit mask 
; input:
;    A   bit position n{0..7}
; output:
;    A    mask,  2^^n 
;----------------------------
bit_mask:
    push a 
    ld a,#1 
    tnz (1,sp)
    jreq 9$ 
1$: sll a 
    dec (1,sp)
    jrne 1$
9$: _drop 1
    ret 

;--------------------------------
; translate x,y coordinates 
; to buffer address 
; and bit mask  
; parameters:
;     XL  x coord 
;     XH  y coord 
; output:
;     A   bit mask  
;     X   buffer address  
;---------------------------------
buffer_addr:
    clr a 
    rrwa x ; x coord    
    push a 
    push #0  
    ld a,#8 
    div x,a ; xl=page 
    push a  ; remainder=bit position 
    ld a,#128 
    mul x,a 
    addw x,#disp_buffer 
    addw x,(2,sp) ; x=buffer_addr 
    pop a 
    call bit_mask  
    _drop 2
    ret 

;-----------------------------------
; set a single pixel in disp_buffer 
; parameters:
;     XL      x coord 
;     XY      y coord
;-----------------------------------
set_pixel:
    call buffer_addr
    or a,(x)
    ld (x),a 
    ret 

;-----------------------------------
; reset a single pixel in disp_buffer 
; parameters:
;     XL      x coord 
;     XH      y coord
;-----------------------------------
reset_pixel:
    call buffer_addr
    cpl a 
    and a,(x)
    ld (x),a 
    ret 

;-----------------------------------
; invert a single pixel in disp_buffer 
; parameters:
;     XL      x coord 
;     XH      y coord
; output:
;     A    bit state, 0 if bit reset 
;-----------------------------------
invert_pixel:
    call buffer_addr
    push a 
    xor a,(x)
    ld (x),a 
    and a,(1,sp)
    pop a 
    ret 

;--------------------------------
; read pixel at x,y coordinates 
; input:
;    XL    x coord 
;    XH    y coord 
; ouput:
;     A    0|1 
;--------------------------------
get_pixel:
    call buffer_addr 
    and a,(x)
    jreq 9$
1$: cp a,#1
    jreq 9$
    srl a 
    jra 1$  
9$:    
    ret 

.if 0
;-------------------------------
; line drawing 
;  X0<=X1 
;  Y0<=Y1 
; input:
;     XH  x0 
;     XL  x1 
;     YH  y0 
;     YL  y1 
;--------------------------------
    X0=1  ; int8 
    X1=2  ; int8 
    Y0=3  ; int8 
    Y1=4  ; int8 
    DX=5   ; int16 
    DY=7   ; int16 
    DELTA=9 ; int16 
    VAR_SIZE=10
line:
    _vars VAR_SIZE 
    ldw (X0,sp),x 
    ldw (Y0,sp),y
    ld a,(X1,sp)
    sub a,(X0,sp)
    clrw x 
    ld xl,a 
    ldw (DX,sp),x 
    ld a,(Y1,sp)
    sub a,(Y0,sp)
    ld xl,a 
    ldw (DY,sp),x 
    sllw x 
    subw x,(DX,sp)
    ldw (DELTA,sp),x 
1$:  
    ld a,(X0,sp)
    cp a,(X1,sp)
    jreq 9$ 
    ld xl,a 
    ld a,(Y0,sp)
    ld xh,a
    call set_pixel 
    ldw x,(DELTA,sp)
    tnzw x
    jrmi 2$
    inc (Y0,sp)
    subw x,(DX,sp)
    subw x,(DX,sp)
2$: 
    addw x,(DY,sp)
    addw x,(DY,sp)
    ldw (DELTA,sp),x  
    inc (X0,sp)
    jra 1$
9$:
    _drop VAR_SIZE 
    ret 
.endif 

;-----------------------
; send text cursor 
; at next line 
;------------------------
crlf:
    _ldaz cur_y
    add a,#OLED_FONT_HEIGHT 
    cp a,#DISP_HEIGHT-OLED_FONT_HEIGHT
    jrsle 6$
    ld a,#OLED_FONT_HEIGHT
    call up_n_lines
    ld a,#DISP_HEIGHT-OLED_FONT_HEIGHT  
6$: _straz cur_y 
    clr a 
8$: _straz cur_x 
    ret 

;----------------------------
; set text cursor position 
; input:
;    XL   coloumn {0..20}
;    XH   line {0..7}
;----------------------------
curpos:
    pushw x 
    ld a,#OLED_FONT_WIDTH 
    mul x,a 
    ld a,xl 
    _straz cur_x 
    ld a,#OLED_FONT_HEIGHT 
    ld xl,a 
    ld a,(1,sp)
    mul x,a
    ld a,xl  
    _straz cur_y
    _drop 2
    ret 

;-----------------------
; move cursor right 
; 1 character position
; scroll up if needed 
;-----------------------
cursor_right:
    _ldaz cur_x 
    add a,#OLED_FONT_WIDTH  
    _straz cur_x 
    cp a,#DISP_WIDTH-OLED_FONT_WIDTH 
    jrsle 9$
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
	ldw x,#6
	mul x,a 
	addw x,#oled_font_6x8
    ldw y,x 
    _ldxz cur_y 
    call buffer_addr 
    push #OLED_FONT_WIDTH
1$:
    ld a,(y)
    ld (x),a 
    incw x 
    incw y 
    dec (1,sp)
    jrne 1$ 
    _drop 1
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

;-----------------------
; shift diplay page  
; 4 pixel left 
; input:
;    A    page {0..7} 
;-----------------------
pageleft4pixels:
    pushw x 
    ldw x,#128 
    mul x,a 
    addw x,#disp_buffer
    push #128-4
1$: ld a,(4,x)
    ld (x),a 
    incw x 
    dec (1,sp)
    jrne 1$
    ld a,#4 
    ld (1,sp),a 
2$: clr (x)
    incw x 
    dec (1,sp)
    jrne 2$
    _drop 1    
    popw x
    ret 


;-----------------------
; shift display 4 pixels 
; left with 4 right left 
; blank
;-----------------------
left_4_pixels:
    push a 
    push #7 
1$: ld a,(1,sp)
    call pageleft4pixels
    dec (1,sp)
    jrpl 1$
    _drop 1
    pop a 
    ret 


;---------------------
; shift display page 
; 4 pixel right 
; input:
;     A   page 
;---------------------
pageright4pixels:
    pushw x 
    ldw x,#128 
    mul x,a 
    addw x,#disp_buffer 
    addw x,#127-4
    push #128-4 
1$: ld a,(x)
    ld (4,x),a 
    decw x 
    dec (1,sp)
    jrne 1$ 
    ld a,#4 
    ld (1,sp),a
    incw x  
2$:
    clr (x)
    incw x 
    dec (1,sp)
    jrne 2$
    _drop 1 
    popw x
    ret 

;-------------------------
; shift display 4 pixels 
; right with 4 left pixels 
; left blank 
;-------------------------
right_4_pixels:
    push a 
    push #7 
1$:
    ld a,(1,sp)
    call pageright4pixels
    dec (1,sp)
    jrpl 1$
    _drop 1
    pop a 
    ret 



;-----------------------------
; shift column down 1 pixel 
; input:
;    A    column number {0..127} 
;-----------------------------
column_down:
    pushw x 
    clrw x 
    ld xl,a 
    addw x,#disp_buffer
    push #8 
    rcf 
    push cc 
1$: pop cc 
    rlc (x)
    push cc 
    addw x,#128 
    dec (2,sp)
    jrne 1$ 
    _drop 2
    popw x 
    ret 

;------------------------------------
; shift 1 column up 1 bit 
; input:
;    A      c  
;------------------------------------
column_up:
    pushw x 
    clrw x 
    ld xl,a 
    addw x,#disp_buffer+7*128
    push #8 
    rcf 
    push cc
2$: pop cc 
    ld a,(x)
    rrc a 
    ld (x),a 
    push cc 
    subw x,#128 
    dec (2,sp)
    jrne 2$
    _drop 2 
    popw x 
    ret 


;-------------------------------
; up or down display shift 
; input:
;   A      n  lines shift count 
;   Y      routine vector 
;--------------------------------
    COL=1 
    N=2 
    SHIFT_CNTR=3
    VAR_SIZE=3
vertical_shift:
    _vars VAR_SIZE 
    tnz a 
    jreq 9$ 
    ld (N,sp),a 
    clr (COL,sp)
2$:
    ld a,(N,sp)
    ld (SHIFT_CNTR,sp),a
4$:
    ld a,(COL,sp)
    call (y) 
    dec (SHIFT_CNTR,sp)
    jrne 4$  
    inc (COL,sp)
    jrpl 2$ 
9$:
    _drop VAR_SIZE 
    ret 

;-----------------------------
; shift down display 
; n lines leaving top n lines 
; blank
; input:
;    A     n 
;----------------------------
down_n_lines:
    pushw y 
    ldw y,#column_down
    call vertical_shift
    popw y 
    ret 

;------------------------------------
; shift up diplay 
; n lines leaving bottom lines blank
; input:
;    A     n 
;------------------------------------
up_n_lines:
    pushw y 
    ldw y,#column_up
    call vertical_shift
    popw y 
    ret 

