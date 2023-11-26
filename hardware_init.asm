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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hardware initialisation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;------------------------
; if unified compilation 
; must be first in list 
;-----------------------

    .module HW_INIT 

    .include "config.inc"


STACK_SIZE=128
STACK_EMPTY=RAM_SIZE-1 
DISPLAY_BUFFER_SIZE=128 ; horz pixels   

;;-----------------------------------
    .area SSEG (ABS)
;; working buffers and stack at end of RAM. 	
;;-----------------------------------
    .org RAM_END - STACK_SIZE - 1
free_ram_end: 
stack_full: .ds STACK_SIZE   ; control stack 
stack_unf: ; stack underflow ; control_stack bottom 

;;--------------------------------------
    .area HOME 
;; interrupt vector table at 0x8000
;;--------------------------------------

	int cold_start	        ; reset
	int NonHandledInterrupt	; trap
	int NonHandledInterrupt	; irq0
	int NonHandledInterrupt	; irq1
	int NonHandledInterrupt	; irq2
	int NonHandledInterrupt	; irq3
	int NonHandledInterrupt	; irq4
	int NonHandledInterrupt	; irq5
	int NonHandledInterrupt	; irq6
	int NonHandledInterrupt	; irq7
	int NonHandledInterrupt	; irq8
	int NonHandledInterrupt	; irq9
	int NonHandledInterrupt	; irq10
	int NonHandledInterrupt	; irq11
	int NonHandledInterrupt	; irq12
	int NonHandledInterrupt	; irq13
	int NonHandledInterrupt	; irq14
	int NonHandledInterrupt	; irq15
	int NonHandledInterrupt	; irq16
	int NonHandledInterrupt	; irq17
	int NonHandledInterrupt	; irq18
	int I2cIntHandler  		; irq19
	int NonHandledInterrupt	; irq20
.if DEBUG 
	int UartRxHandler   	; irq21
.else 
	int NonHandledInterrupt	; irq21
.endif	
	int NonHandledInterrupt	; irq22
	int Timer4UpdateHandler ; irq23
	int NonHandledInterrupt	; irq24
	int NonHandledInterrupt	; irq25
	int NonHandledInterrupt	; irq26
	int NonHandledInterrupt	; irq27
	int NonHandledInterrupt	; irq28
	int NonHandledInterrupt	; irq29


;--------------------------------------
    .area DATA (ABS)
	.org 8 
;--------------------------------------	

ticks: .blkw 1 ; 1.664 milliseconds ticks counter (see Timer4UpdateHandler)
delay_timer: .blkb 1 ; 60 hertz timer   
sound_timer: .blkb 1 ; 60 hertz timer  
seedx: .blkw 1  ; xorshift 16 seed x  used by RND() function 
seedy: .blkw 1  ; xorshift 16 seed y  used by RND() funcion
acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
flags:: .blkb 1 ; various boolean flags
; i2c peripheral 
i2c_buf: .blkw 1 ; i2c buffer address 
i2c_count: .blkw 1 ; bytes to transmit 
i2c_idx: .blkw 1 ; index in buffer
i2c_status: .blkb 1 ; error status 
i2c_devid: .blkb 1 ; device identifier  
;; OLED display 
line: .blkb 1 ; text line cursor position 
col: .blkb 1 ;  text column cursor position
cpl: .blkb 1 ; characters per line 
disp_lines: .blkb 1 ; text lines per display  
font_width: .blkb 1 ; character width in pixels 
font_height: .blkb 1 ; character height in pixels 
to_send: .blkb 1 ; bytes to send per character 
disp_flags: .blkb 1 ; boolean flags 

.if DEBUG 
; usart queue 
rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
rx1_head:  .blkb 1 ; rx1_queue head pointer
rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
; transaction input buffer 
tib: .ds TIB_SIZE
count: .blkb 1 ; character count in tib  
.endif ; DEBUG 

	.org 0x100
co_code: .blkb 1	
disp_buffer: .ds DISPLAY_BUFFER_SIZE ; oled display page buffer 

free_ram: ; from here RAM free up to free_ram_end 


	.area CODE 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; non handled interrupt 
; reset MCU
;;;;;;;;;;;;;;;;;;;;;;;;;;;
NonHandledInterrupt:
	iret 

;------------------------------
; TIMER 4 is used to maintain 
; timers and ticks 
; interrupt interval is 1.664 msec 
;--------------------------------
Timer4UpdateHandler:
	clr TIM4_SR 
	_ldxz ticks
	incw x 
	_strxz ticks
; decrement delay_timer and sound_timer on ticks mod 10==0
	ld a,#10
	div x,a 
	tnz a
	jrne 9$
1$:	 
	btjf flags,#F_GAME_TMR,2$  
	dec delay_timer 
	jrne 2$ 
	bres flags,#F_GAME_TMR  
2$:
	btjf flags,#F_SOUND_TMR,9$
	dec sound_timer 
	jrne 9$ 
	bres flags,#F_SOUND_TMR
9$:
	iret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    peripherals initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;----------------------------------------
; inialize MCU clock 
; HSI no divisor 
; FMSTR=16Mhz 
;----------------------------------------
clock_init:	
	clr CLK_CKDIVR 
	ret

;---------------------------------
; TIM4 is configured to generate an 
; interrupt every 1.66 millisecond 
;----------------------------------
timer4_init:
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
	bres TIM4_CR1,#TIM4_CR1_CEN 
	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
	bset TIM4_IER,#TIM4_IER_UIE
; set int level to 1 
.if 0
	ld a,#ITC_SPR_LEVEL1 
	ldw x,#INT_TIM4_OVF 
	call set_int_priority
	bres flags,#F_GAME_TMR
	bres flags,#F_SOUND_TMR 
.endif 
	ret

;----------------------------------
; TIMER2 used as audio tone output 
; on port D:4. CN3-13
; channel 1 configured as PWM mode 1 
;-----------------------------------  
timer2_init:
	bset CLK_PCKENR1,#CLK_PCKENR1_TIM2 ; enable TIMER2 clock 
 	mov TIM2_CCMR1,#(6<<TIM2_CCMR_OCM) ; PWM mode 1 
	mov TIM2_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
	bset TIM2_CR1,#TIM2_CR1_CEN
	bres TIM2_CCER1,#TIM2_CCER1_CC1E
	ret 

.if 0
;--------------------------
; set software interrupt 
; priority 
; input:
;   A    priority 1,2,3 
;   X    vector 
;---------------------------
	SPR_ADDR=1 
	PRIORITY=3
	SLOT=4
	MASKED=5  
	VSIZE=5
set_int_priority::
	_vars VSIZE
	and a,#3  
	ld (PRIORITY,sp),a 
	ld a,#4 
	div x,a 
	sll a  ; slot*2 
	ld (SLOT,sp),a
	addw x,#ITC_SPR1 
	ldw (SPR_ADDR,sp),x 
; build mask
	ldw x,#0xfffc 	
	ld a,(SLOT,sp)
	jreq 2$ 
	scf 
1$:	rlcw x 
	dec a 
	jrne 1$
2$:	ld a,xl 
; apply mask to slot 
	ldw x,(SPR_ADDR,sp)
	and a,(x)
	ld (MASKED,sp),a 
; shift priority to slot 
	ld a,(PRIORITY,sp)
	ld xl,a 
	ld a,(SLOT,sp)
	jreq 4$
3$:	sllw x 
	dec a 
	jrne 3$
4$:	ld a,xl 
	or a,(MASKED,sp)
	ldw x,(SPR_ADDR,sp)
	ld (x),a 
	_drop VSIZE 
	ret
.endif ;DEBUG 

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

.if DEBUG 
;---------------------------------
; Pseudo Random Number Generator 
; XORShift algorithm.
;---------------------------------

;---------------------------------
;  seedx:seedy= x:y ^ seedx:seedy
; output:
;  X:Y   seedx:seedy new value   
;---------------------------------
xor_seed32:
    ld a,xh 
    _xorz seedx 
    _straz seedx
    ld a,xl 
    _xorz seedx+1 
    _straz seedx+1 
    ld a,yh 
    _xorz seedy
    _straz seedy 
    ld a,yl 
    _xorz seedy+1 
    _straz seedy+1 
    _ldxz seedx  
    _ldyz seedy 
    ret 

;-----------------------------------
;   x:y= x:y << a 
;  input:
;    A     shift count 
;    X:Y   uint32 value 
;  output:
;    X:Y   uint32 shifted value   
;-----------------------------------
sll_xy_32: 
    sllw y 
    rlcw x
    dec a 
    jrne sll_xy_32 
    ret 

;-----------------------------------
;   x:y= x:y >> a 
;  input:
;    A     shift count 
;    X:Y   uint32 value 
;  output:
;    X:Y   uint32 shifted value   
;-----------------------------------
srl_xy_32: 
    srlw x 
    rrcw y 
    dec a 
    jrne srl_xy_32 
    ret 

;-------------------------------------
;  PRNG generator proper 
; input:
;   none 
; ouput:
;   X     bits 31...16  PRNG seed  
;  use: 
;   seedx:seedy   system variables   
;--------------------------------------
prng::
	pushw y   
    _ldxz seedx
	_ldyz seedy  
	ld a,#13
    call sll_xy_32 
    call xor_seed32
    ld a,#17 
    call srl_xy_32
    call xor_seed32 
    ld a,#5 
    call sll_xy_32
    call xor_seed32
    popw y 
    ret 


;---------------------------------
; initialize seedx:seedy 
; input:
;    X    0 -> seedx=ticks, seedy=tib[0..1] 
;    X    !0 -> seedx=X, seedy=[0x60<<8|XL]
;-------------------------------------------
set_seed:
    tnzw x 
    jrne 1$ 
    ldw x,ticks 
    _strxz seedx
    ldw x,disp_buffer  
    _strxz seedy  
    ret 
1$:  
    _strxz seedx
    _clrz seedy 
    _clrz seedy+1
    ret 

;----------------------------
;  read keypad 
; output:
;    A    keypress|0
;----------------------------
key:
	ld a,BTN_IDR 
	and a,#ALL_KEY_UP
    ret 

;----------------------------
; wait for key press 
; output:
;    A    key 
;----------------------------
	KPAD=1
wait_key:
	push #ALL_KEY_UP 
1$:	
	ld a,BTN_IDR 
	and a,#ALL_KEY_UP 
	cp a,#ALL_KEY_UP
	jreq 1$
	ld (KPAD,sp),a  
; debounce
	mov delay_timer,#2
	bset flags,#F_GAME_TMR
2$: ld a,BTN_IDR 
	and a,#ALL_KEY_UP 
	cp a,(KPAD,sp)
	jrne 1$
	btjt flags,#F_GAME_TMR,2$ 
	pop a  
	ret 
.endif ; DEBUG 

;-------------------------------------
;  initialization entry point 
;-------------------------------------
cold_start:
;set stack 
	ldw x,#STACK_EMPTY
	ldw sp,x
; clear all ram 
0$: clr (x)
	decw x 
	jrne 0$
    call clock_init 
.if DEBUG 
; set pull up on PC_IDR (buttons input)
	cLr BTN_PORT+GPIO_DDR
	mov BTN_PORT+GPIO_CR1,#255
.endif ; DEBUG 
; set sound output 	
	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT 
	bset SOUND_PORT+GPIO_CR1,#SOUND_BIT 
.if DEBUG 
	call uart_init 
.endif ;DEBUG 	
	call timer4_init ; msec ticks timer 
	call timer2_init ; tone generator 
	ld a,#I2C_FAST   
	call i2c_init 
	rim ; enable interrupts
.if DEBUG 
; RND function seed 
; must be initialized 
; to value other than 0.
; take values from FLASH space 
	ldw x,#I2cIntHandler
	ldw seedy,x  
	ldw x,#app 
	ldw seedx,x  	
.endif ; DEBUG 
	jp app 




