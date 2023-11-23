;;
; Copyright Jacques Deschênes 2019,2022  
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

.if DEBUG 
    .module STM8_MON 

;--------------------------------------
    .area DATA
mode: .blkb 1 ; command mode 
xamadr: .blkw 1 ; examine address 
storadr: .blkw 1 ; store address 
last: .blkw 1   ; last address parsed from input 

    .area  CODE

;----------------------------------------------------------------------------------------
; command line interface
; input formats:
;       hex_number  -> display byte at that address 
;       hex_number.hex_number -> display bytes in that range 
;       hex_number: hex_byte [hex_byte]*  -> modify content of RAM or peripheral registers 
;       R  -> run binary code at xamadr address  
;------------------------------------------------------------------------------------------
; operatiing modes 
    NOP=0
    READ=1 ; single address or block
    STORE=2 

    ; get next character from input buffer 
    .macro _next_char 
    ld a,(y)
    incw y 
    .endm ; 4 bytes, 2 cy 

cli: 
    ld a,#CR 
    call putchar 
    ld a,#'# 
    call putchar ; prompt character 
    call getline
; analyze input line      
    ldw y,#tib  
    _clrz mode 
next_char:     
    _next_char
    tnz a     
    jrne parse01
; at end of line 
    tnz mode 
    jreq cli 
    call exam_block 
    jra cli 
parse01:
    cp a,#'R 
    jrne 4$
    _ldxz xamadr   
    call (x) ; run program 
4$: cp a,#':
    jrne 5$ 
    call modify 
    jra cli     
5$:
    cp a,#'. 
    jrne 8$ 
    tnz mode 
    jreq cli ; here mode should be set to 1 
    jra next_char 
8$: 
    cp a,#SPACE 
    jrmi next_char ; skip separator and invalids characters  
    call parse_hex ; maybe an hexadecimal number 
    tnz a ; unknown token ignore rest of line
    jreq cli 
    tnz mode 
    jreq 9$
    call exam_block
    jra next_char
9$:
    _strxz xamadr 
    _strxz storadr
    _incz mode
    jra next_char 

;-------------------------------------
; modify RAM or peripheral register 
; read byte list from input buffer
;--------------------------------------
modify:
1$: 
; skip spaces 
    _next_char 
    cp a,#SPACE 
    jreq 1$ 
    call parse_hex
    tnz a 
    jreq 9$ 
    ld a,xl 
    _ldxz storadr 
    ld (x),a 
    incw x 
    _strxz storadr
    jra 1$ 
9$: _clrz mode 
    ret 

;-------------------------------------------
; display memory in range 'xamadr'...'last' 
;-------------------------------------------    
    ROW_SIZE=1
    VSIZE=1
exam_block:
    _vars VSIZE
    _ldxz xamadr
new_row: 
    ld a,#8
    ld (ROW_SIZE,sp),a ; bytes per row 
    ld a,#CR 
    call putchar 
    call print_adr ; display address and first byte of row 
    call print_mem ; display byte at address  
row:
    incw x 
    cpw x,last 
    jrugt 9$ 
    dec (ROW_SIZE,sp)
    jreq new_row  
    call print_mem  
    jra row 
9$:
    _clrz mode 
    _drop VSIZE 
    ret  

;----------------------------
; parse hexadecimal number 
; from input buffer 
; input:
;    A   first character 
;    Y   pointer to TIB 
; output: 
;    X     number 
;    Y     point after number 
;-----------------------------      
parse_hex:
    push #0 ; digits count 
    clrw x
1$:    
    xor a,#0x30
    cp a,#10 
    jrmi 2$   ; 0..9 
    cp a,#0x71
    jrmi 9$
    sub a,#0x67  
2$: push #4
    swap a 
3$:
    sll a 
    rlcw x 
    dec (1,sp)
    jrne 3$
    pop a
    inc (1,sp) ; digits count  
    _next_char 
    tnz a 
    jrne 1$
9$: ; end of hex number
    decw y  ; put back last character  
    pop a 
    tnz a 
    jreq 10$
    _strxz last 
10$:
    ret 

;-----------------------------------
;  print address in xamadr variable
;  followed by ': '  
;  input: 
;    X     address to print 
;  output:
;   X      not modified 
;-------------------------------------
print_adr: 
    callr print_word 
    ld a,#': 
    callr putchar 
    jra space

;-------------------------------------
;  print byte at memory location 
;  pointed by X followed by ' ' 
;  input:
;     X     memory address 
;  output:
;    X      not modified 
;-------------------------------------
print_mem:
    ld a,(x) 
    call print_byte 
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     TERMIO 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;--------------------------------
; print blank space 
;-------------------------------
space:
    ld a,#SPACE 
    callr putchar 
    ret 

;-------------------------------
;  print hexadecimal number 
; input:
;    X  number to print 
; output:
;    none 
;--------------------------------
print_word: 
    ld a,xh
    call print_byte 
    ld a,xl 
    call print_byte 
    ret 

;---------------------
; print byte value 
; in hexadecimal 
; input:
;    A   value to print 
; output:
;    none 
;-----------------------
print_byte:
    push a 
    swap a 
    call print_digit 
    pop a 

;-------------------------
; print lower nibble 
; as digit 
; input:
;    A     hex digit to print
; output:
;   none:
;---------------------------
print_digit: 
    and a,#15 
    add a,#'0 
    cp a,#'9+1 
    jrmi 1$
    add a,#7 
1$:
    call putchar 
9$:
    ret 


;---------------------------------
; Query for character in rx1_queue
; input:
;   none 
; output:
;   A     0 no charcter available
;   Z     1 no character available
;---------------------------------
uart_qgetc:
	_ldaz rx1_head 
	sub a,rx1_tail 
	ret 

;---------------------------------
; wait character from UART 
; input:
;   none
; output:
;   A 			char  
;--------------------------------	
uart_getc::
	call uart_qgetc
	jreq uart_getc 
	pushw x 
	_clrz acc16 
    _movz acc8,rx1_head 
    ldw x,#rx1_queue
	_ldaz rx1_head 
	inc a 
	and a,#RX_QUEUE_SIZE-1
	_straz rx1_head 
	ld a,([acc16],x)
	cp a,#'a 
    jrmi 2$ 
    cp a,#'z+1 
    jrpl 2$
	and a,#0xDF ; uppercase letter 
2$:
	popw x
	ret 


;---------------------------------------
; send character to terminal 
; input:
;    A    character to send 
; output:
;    none 
;----------------------------------------    
putchar:
    btjf UART_SR,#UART_SR_TXE,. 
    ld UART_DR,a 
    ret 

;------------------------------------
;  read text line from terminal 
;  put it in tib buffer 
;  CR to terminale input.
;  BS to deleter character left 
;  input:
;   none 
;  output:
;    tib      input line ASCIZ no CR  
;-------------------------------------
getline:
    ldw y,#tib 
1$:
    clr (y) 
    callr uart_getc 
    cp a,#CR 
    jreq 9$ 
    cp a,#BS 
    jrne 2$
    callr delback 
    jra 1$ 
2$: 
    cp a,#ESC 
    jrne 3$
    ldw y,#tib
    clr(y)
    ret 
3$:    
    cp a,#SPACE 
    jrmi 1$  ; ignore others control char 
    callr putchar
    ld (y),a 
    incw y 
    jra 1$
9$: callr putchar 
    ret 

;-----------------------------------
; delete character left of cursor 
; decrement Y 
; input:
;   none 
; output:
;   none 
;-----------------------------------
delback:
    cpw y,#tib 
    jreq 9$     
    callr putchar ; backspace 
    ld a,#SPACE    
    callr putchar ; overwrite with space 
    ld a,#BS 
    callr putchar ;  backspace
    decw y
9$:
    ret 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   UART subroutines
;;   used for user interface 
;;   communication channel.
;;   settings: 
;;		115200 8N1 no flow control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Uart intterrupt handler 
;;; on receive character 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;--------------------------
; UART receive character
; in a FIFO buffer 
; CTRL+X reboot system 
;--------------------------
UartRxHandler: ; console receive char 
	btjf UART_SR,#UART_SR_RXNE,5$ 
	ld a,UART_DR 
	cp a,#CTRL_C 
	jrne 2$ 
	ldw x,#cli  
	clr (7,sp)
	ldw (8,sp),x 
	jra 5$
2$:
	cp a,#CAN ; CTRL_X 
	jrne 3$
	_swreset 	
3$:	push a 
	ld a,#rx1_queue 
	add a,rx1_tail 
	clrw x 
	ld xl,a 
	pop a 
	ld (x),a 
	ld a,rx1_tail 
	inc a 
	and a,#RX_QUEUE_SIZE-1
	ld rx1_tail,a 
5$:	iret 


;---------------------------------------------
; initialize UART, 115200 8N1
; called from cold_start in hardware_init.asm 
; input:
;	none
; output:
;   none
;---------------------------------------------
uart_init:
; enable UART clock
	bset CLK_PCKENR1,#UART_PCKEN 	
	bres UART,#UART_CR1_PIEN
; baud rate 115200
; BRR value = 16Mhz/115200 ; 139 (0x8b) 
	ld a,#0xb
	ld UART_BRR2,a 
	ld a,#0x8 
	ld UART_BRR1,a 
3$:
    clr UART_DR
	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
	bset UART_CR2,#UART_CR2_SBK
    btjf UART_SR,#UART_SR_TC,.
    clr rx1_head 
	clr rx1_tail
	bset UART,#UART_CR1_PIEN
	ret

.endif ; DEBUG
