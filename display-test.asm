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

;---------------------------------------
; move memory block 
; input:
;   X 		destination 
;   Y 	    source 
;   acc16	bytes count 
; output:
;   none 
;--------------------------------------
	INCR=1 ; incrament high byte 
	LB=2 ; increment low byte 
	VSIZE=2
move::
	push a 
	_vars VSIZE 
	clr (INCR,sp)
	clr (LB,sp)
	pushw y 
	cpw x,(1,sp) ; compare DEST to SRC 
	popw y 
	jreq move_exit ; x==y 
	jrmi move_down
move_up: ; start from top address with incr=-1
	addw x,acc16
	addw y,acc16
	cpl (INCR,sp)
	cpl (LB,sp)   ; increment = -1 
	jra move_loop  
move_down: ; start from bottom address with incr=1 
    decw x 
	decw y
	inc (LB,sp) ; incr=1 
move_loop:	
    _ldaz acc16 
	or a, acc8
	jreq move_exit 
	addw x,(INCR,sp)
	addw y,(INCR,sp) 
	ld a,(y)
	ld (x),a 
	pushw x 
	_ldxz acc16 
	decw x 
	ldw acc16,x 
	popw x 
	jra move_loop
move_exit:
	_drop VSIZE
	pop a 
	ret 	

;-------------------------------------
; retrun string length
; input:
;   X         .asciz  pointer 
; output:
;   X         not affected 
;   A         length 
;-------------------------------------
strlen::
	pushw x 
	clr a
1$:	tnz (x) 
	jreq 9$ 
	inc a 
	incw x 
	jra 1$ 
9$:	popw x 
	ret 

;------------------------
; suspend execution 
; input:
;   A     n/60 seconds  
;-------------------------
pause:
	_straz delay_timer 
	bset flags,#F_GAME_TMR 
1$: wfi 	
	btjt flags,#F_GAME_TMR,1$ 
	ret 

;--------------------------
; sound timer blocking 
; delay 
; input:
;   A    n*10 msec
;--------------------------
sound_pause:
	_straz sound_timer  
	bset flags,#F_SOUND_TMR 
1$: wfi 
	btjt flags,#F_SOUND_TMR,1$
	bres TIM2_CR1,#TIM2_CR1_CEN 
	bres TIM2_CCER1,#TIM2_CCER1_CC1E
	bset TIM2_EGR,#TIM2_EGR_UG
9$:	ret 

;-----------------------
; tone generator 
; Ft2clk=62500 hertz 
; input:
;   A   duration n*10 msec    
;   X   frequency 
;------------------------
FR_T2_CLK=62500
tone:
	pushw y 
	push a 
	ldw y,x 
	ldw x,#FR_T2_CLK 
	divw x,y 
	ld a,xh 
	ld TIM2_ARRH,a 
	ld a,xl 
	ld TIM2_ARRL,a 
	srlw x 
	ld a,xh 
	ld TIM2_CCR1H,a 
	ld a,xl 
	ld TIM2_CCR1L,a 
	bset TIM2_CCER1,#TIM2_CCER1_CC1E
	bset TIM2_CR1,#TIM2_CR1_CEN 
	pop a 
	call sound_pause 
	popw y 
	ret 

;-----------------
; 1Khz beep 
;-----------------
beep:
	ldw x,#1000 ; hertz 
	ld a,#20
	call tone  
	ret 

; tempered scale 
scale: 
    .word 262,277,294,311,330,349,370,392,415,440,466,494 ; C4..B4 
    .word 523,554,587,622,659,698,740,784,831,880,932,988 ; c5..B5

;---------------------------
; generate white noise using
; 16 bits lfsr 
; input:
;    A   duration 
;----------------------------
noise:
	bres TIM2_CCER1,#TIM2_CCER1_CC1E
	_straz sound_timer 
	call prng 
	pushw x 
	bset flags,#F_SOUND_TMR
1$: ld a,SOUND_PORT+GPIO_ODR 
	swap a 
	srl a 
	rlc (2,sp)
	rlc (1,sp)
	bccm SOUND_PORT+GPIO_ODR,#SOUND_BIT 
	jrc 2$ 
	ld a,(1,sp)
	xor a,#0xAC 
	ld (1,sp),a 
	ld a,(2,sp)
	xor a,#0xE1
	ld (2,sp),a 
2$: btjf flags,#F_SOUND_TMR,4$
	_usec_dly 500 
	jra 1$
4$: 
	popw x 
	ret 

.if DEBUG 
; print x,y,a 
debug_print:
    pushw x
    pushw y 
    push a  
    call print_word 
    ld a,#SPACE 
    call putchar 
    ldw x,(2,sp)
	call print_word 
	ld a,#SPACE 
	call putchar 
	ld a,(1,sp) 	
    call print_byte 
    ld a,#CR 
    call putchar 
    pop a
	popw y 
    popw x 
    ret 
.endif 


main:
	call beep 
	call oled_init	
	call display_clear 
.if DEBUG
	ld a,#ESC 
	call putchar 
	ld a,#'c 
	call putchar 
test1:
	_clrz ticks+1 
	push #8*21-1
1$: ld a,#'A 
	call put_char 
	dec (1,sp)
	jrne 1$ 
	_ldxz ticks 
	call print_word
	ld a,#CR 
	call putchar 	
test4: ; echo character from usart  
	call display_clear 
0$:	 
	call uart_getc
	cp a,#'a 
	jrmi 1$ 
	and a,#0xDF  
1$:	call put_char
	jra 0$ 
hello: .asciz "HELLO "
qbf: .asciz "THE QUICK BROWN FOX JUMP OVER THE LAZY DOG.\n" 
end_test: 	 
.endif 

