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

    TIM2_CLK_FREQ=62500

; boolean flags 
    F_GAME_TMR=7 ; game timer expired reset 
    F_SOUND_TMR=6 ; sound timer expired reset  
    F_DISP_MODE=5 ; display mode 0->text,1->graphic 
    
;--------------------------------------
;   assembler flags 
;-------------------------------------

    ; assume 16 Mhz Fcpu 
     .macro _usec_dly n 
    ldw x,#(16*n-2)/4 ; 2 cy 
    decw x  ; 1 cy 
    nop     ; 1 cy 
    jrne .-2 ; 2 cy 
    .endm 

;----------------------------------
; functions arguments access 
; from stack 
; caller push arguments before call
; and drop them after call  
;----------------------------------    
    ; get argument in X 
    .macro _get_arg n 
    ldw x,(2*(n+1),sp)
    .endm 

    ; store X in argument n 
    .macro _store_arg n 
    ldw (2*(n+1),sp),x 
    .endm 

    ; drop function arguments 
    .macro _drop_args n 
    addw sp,#2*n
    .endm 


    ; read buttons 
    .macro _read_buttons
    ld a,#BTN_PORT+GPIO_IDR 
    and a,#ALL_KEY_UP
    .endm 


;-----------------------------
;   keypad macros 
;-----------------------------

    .macro _btn_down btn 
    ld a,BTN_IDR 
    and a,#(1<<btn)
    or a,#(1<<btn)
    .endm 

    .macro _btn_up 
    ld a,#BTN_IDR 
    and a,#(1<<btn)
    .endm 

    .macro _btn_state 
    ld a,#BTN_IDR 
    and a,#ALL_KEY_UP
    .endm 

    .macro _wait_key_release  ?loop 
    loop:
    ld a,BTN_IDR 
    and a,#ALL_KEY_UP 
    cp a,#ALL_KEY_UP 
    jrne loop 
    .endm 

;------------------------
; LED control 
;-----------------------

    .macro _led_on 
    bset LED_PORT+GPIO_ODR,#LED_BIT 
    .endm 

    .macro _led_off 
    bres LED_PORT+GPIO_ODR,#LED_BIT
    .endm 

    .macro _led_toggle 
    bcpl LED_PORT+GPIO_ODR,#LED_BIT
    .endm 

    