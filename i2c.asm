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

;-------------------------------------
;    I2C macros 
;-------------------------------------
    .macro _i2c_stop 
    bset I2C_CR2,#I2C_CR2_STOP
    .endm 

;--------------------------------
;  I2C peripheral driver 
;  Support only 7 bit addressing 
;  and master mode 
;--------------------------------

I2C_STATUS_DONE=7 ; bit 7 of i2c_status indicate operation completed  
I2C_STATUS_NO_STOP=6 ; don't send a stop at end of transmission


;------------------------------
; i2c global interrupt handler
;------------------------------
I2cIntHandler:
    ld a, I2C_SR2 ; errors status 
    clr I2C_SR2 
    and a,#15 
    jreq 1$
    or a,i2c_status 
    _straz i2c_status 
    bset I2C_CR2,#I2C_CR2_STOP
    iret 
1$: ; no error detected 
    btjf i2c_status,#I2C_STATUS_DONE,2$
    clr I2C_ITR 
    iret 
; handle events 
2$: _ldxz i2c_idx  
    btjt I2C_SR1,#I2C_SR1_SB,evt_sb 
    btjt I2C_SR1,#I2C_SR1_ADDR,evt_addr 
    btjt I2C_SR1,#I2C_SR1_BTF,evt_btf  
    btjt I2C_SR1,#I2C_SR1_TXE,evt_txe 
    btjt I2C_SR1,#I2C_SR1_RXNE,evt_rxne 
    btjt I2C_SR1,#I2C_SR1_STOPF,evt_stopf 
    iret 

evt_sb: ; EV5  start bit sent 
    _ldaz i2c_devid
    ld I2C_DR,a ; send device address 
    iret 

evt_addr: ; EV6  address sent, send data bytes  
    btjt I2C_SR3,#I2C_SR3_TRA,evt_txe
    iret 

; master transmit mode 
evt_txe: ; EV8  send data byte 
    _ldyz i2c_count 
    jreq end_of_tx 
evt_txe_1:
    ld a,([i2c_buf],x)
    ld I2C_DR,a
    incw x 
    _strxz i2c_idx 
    decw y  
    _stryz i2c_count  
1$: iret 

; only append if no STOP send 
evt_btf: 
    btjf I2C_SR3,#I2C_SR3_TRA,#evt_rxne  
    _ldyz i2c_count 
    jrne evt_txe_1 
    jra end_of_tx 

; end of transmission
end_of_tx:
    bset i2c_status,#I2C_STATUS_DONE  
;    btjt i2c_status,#I2C_STATUS_NO_STOP,1$
    bset I2C_CR2,#I2C_CR2_STOP
1$: clr I2C_ITR
    iret 

; master receive mode 
evt_rxne: 
    _ldyz i2c_count 
    jreq evt_stopf  
1$: ld a,I2C_DR 
    ld ([i2c_buf],x),a  
    incw x 
    _strxz i2c_idx 
    decw y 
    _stryz i2c_count
    jrne 4$
    bres I2C_CR2,#I2C_CR2_ACK
4$: iret 

evt_stopf:
    ld a,I2C_DR 
    ld ([i2c_buf],x),a 
    bset I2C_CR2,#I2C_CR2_STOP
    bset i2c_status,#I2C_STATUS_DONE
    clr I2C_ITR 
    iret  

; error message 
I2C_ERR_NONE=0 
I2C_ERR_NO_ACK=1 ; no ack received 
I2C_ERR_OVR=2 ; overrun 
I2C_ERR_ARLO=3 ; arbitration lost 
I2C_ERR_BERR=4 ; bus error 
I2C_ERR_TIMEOUT=5 ; operation time out 
;---------------------------
; display error message 
; blink error code on LED
; in binary format 
; most significant bit first 
; 0 -> 100msec blink
; 1 -> 300msec blink 
; space -> 100msec LED off 
; inter code -> 500msec LED off
;---------------------------
i2c_error:
    _ldaz i2c_status 
    swap a 
    ld acc8,a 
    push #4 
nibble_loop:     
    ld a,#12 
    call beep 
    sll acc8  
    jrc blink1 
blink0:
    ldw x,#200
    jra blink
blink1: 
    ldw x,#600 
blink:
    call pause 
    clr a 
    call beep  
    ldw x,#200 
    call pause 
    dec (1,sp)
    jrne nibble_loop 
    pop a 
    ldw x,#700 
    call pause 
jra i2c_error     
    ret  

.if 0
;----------------------------
; set_i2c_params(devid,count,buf_addr,no_stop)
; set i2c operation parameters  
; 
; devid: BYTE 
;     7 bit device identifier 
;
; count: BYTE 
;     bytes to send|receive
;
; buf_addr: WORD 
;     pointer to buffer 
;  
; no_stop:  BYTE 
;     0   set STOP bit at end 
;     1   don't set STOP bit 
;---------------------------
    ARGCOUNT=4 
i2c_set_params: ; (stop_cond buf_addr count devid -- )
    clr i2c_status  
1$: _get_arg 0 ; no_stop 
    jreq 2$
    bset i2c_status,#I2C_STATUS_NO_STOP
2$: _get_arg 1 ; buf_addr 
    ldw i2c_buf,x 
    _get_arg 2 ; count 
    _strxz i2c_count 
    _get_arg 3 ; devid 
    ld a,xl 
    _straz i2c_devid 
    ret 
.endif 

;--------------------------------
; write bytes to i2c device 
; devid:  device identifier 
; count: of bytes to write 
; buf_addr: address of bytes buffer 
; no_stop: dont't send a stop
;---------------------------------
i2c_write:
    btjt I2C_SR3,#I2C_SR3_MSL,.
    clrw x 
    _strxz i2c_idx 
    ld a,#(1<<I2C_ITR_ITBUFEN)|(1<<I2C_ITR_ITERREN)|(1<<I2C_ITR_ITEVTEN) 
    ld I2C_ITR,a 
    ld a,#(1<<I2C_CR2_START)|(1<<I2C_CR2_ACK)
    ld I2C_CR2,a      
1$: btjf i2c_status,#I2C_STATUS_DONE,1$ 
    ret 

;-------------------------------
; set I2C SCL frequency
; parameter:
;    A    {I2C_STD,I2C_FAST}
;-------------------------------
i2c_scl_freq:
	bres I2C_CR1,#I2C_CR1_PE 
	cp a,#I2C_STD 
	jrne fast
std:
	mov I2C_CCRH,#I2C_CCRH_16MHZ_STD_100 
	mov I2C_CCRL,#I2C_CCRL_16MHZ_STD_100
	mov I2C_TRISER,#I2C_TRISER_16MHZ_STD_100
	jra i2c_scl_freq_exit 
fast:
	mov I2C_CCRH,#I2C_CCRH_16MHZ_FAST_400 
	mov I2C_CCRL,#I2C_CCRL_16MHZ_FAST_400
	mov I2C_TRISER,#I2C_TRISER_16MHZ_FAST_400
i2c_scl_freq_exit:
	bset I2C_CR1,#I2C_CR1_PE 
	ret 

;-------------------------------
; initialize I2C peripheral 
; parameter:
;    A    {I2C_STD,I2C_FAST}
;-------------------------------
i2c_init:
; set SDA and SCL pins as OD output 
	bres I2C_PORT+GPIO_CR1,#SDA_BIT
	bres I2C_PORT+GPIO_CR1,#SCL_BIT 
; set I2C peripheral 
	bset CLK_PCKENR1,#CLK_PCKENR1_I2C 
	clr I2C_CR1 
	clr I2C_CR2 
    mov I2C_FREQR,#FMSTR ; peripheral clock frequency 
	callr i2c_scl_freq
	bset I2C_CR1,#I2C_CR1_PE ; enable peripheral 
	ret 


;-----------------------------
; send start bit and device id 
; paramenter:
;     A      device_id, 
; 			 b0=1 -> transmit
;			 b0=0 -> receive 
;----------------------------- 
i2c_start:
    btjt I2C_SR3,#I2C_SR3_BUSY,.
	bset I2C_CR2,#I2C_CR2_START 
	btjf I2C_SR1,#I2C_SR1_SB,. 
	ld I2C_DR,a 
	btjf I2C_SR1,#I2C_SR1_ADDR,. 
	ret 


