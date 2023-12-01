;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  configuration parameters 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;-----------------------
;  version  
;  information 
;-----------------------
	MAJOR=1
	MINOR=1
	REV=0

; master clock frequency in Mhz 
	FMSTR=16 

DEBUG=1 ; set to 0 for final version 

WANT_TERMINAL=1 ; to have support for usart terminal  

RX_QUEUE_SIZE=16
TIB_SIZE=40

SOUND_PORT=PD_BASE 
SOUND_BIT=4 

LED_PORT=PD_BASE 
LED_BIT=2


BTN_PORT=PC_BASE 
BTN_IDR=PC_IDR
BTN_A=1
BTN_B=2
BTN_UP=3 
BTN_RIGHT=4
BTN_DOWN=5
BTN_LEFT=7

ALL_KEY_UP=(1<<BTN_A)|(1<<BTN_B)|(1<<BTN_UP)|(1<<BTN_DOWN)|(1<<BTN_LEFT)|(1<<BTN_RIGHT)

;------------------------
; beep on pin CN3:13 
; use TIM2_CH1 
;-------------------------

; I2C port on pin 11,12 
	I2C_PORT=PB 
	SCL_BIT=4
	SDA_BIT=5

; ss1306 device ID 
	OLED_DEVID = 0x78 
	.include "inc/ascii.inc"

S207=0
.if S207
S103=0	
    .include "inc/stm8s207.inc"
	.include "inc/nucleo_8s207.inc" 
.else 
S103=1
.endif
.if S103 
	.include "inc/stm8s103f3.inc"
	.include "inc/stm8s103f3_config.inc" 
.endif 
	.include "inc/gen_macros.inc" 
	.include "app_macros.inc" 




