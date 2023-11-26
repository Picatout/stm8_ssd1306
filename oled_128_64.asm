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

;------------------------------
; SSD1306 OLED display 128x64
;------------------------------

    .include "inc/ssd1306.inc"

;--------------------------------
; oled commands macros 
;----------------------------------

    ; initialize cmd_buffer 
    .macro _cmd_init 
        BUF_OFS=0
    .endm 

    ; set oled command buffer values 
    ; initialize BUF_OFS=0 
    ; before using it 
    .macro _set_cmd n
    BUF_OFS=BUF_OFS+1 
    mov cmd_buffer_BUF_OFS,#0x80
    BUF_OFS=BUF_OFS+1 
    mov cmd_buffer+BUF_OFS,#n 
    .endm 

    
    ; send command 
    .macro _send_cmd code 
    ld a,#code 
    call oled_cmd 
    .endm 

;----------------------------
; initialize OLED display
;----------------------------
oled_init:: 
; multiplex ratio to default 64 
    _send_cmd MUX_RATIO 
    _send_cmd 63
; no display offset 
    _send_cmd DISP_OFFSET 
    _send_cmd 0 
; no segment remap SEG0 -> COM0 
    _send_cmd MAP_SEG0_COL0   
; COMMON scan direction top to bottom 
    _send_cmd SCAN_TOP_DOWN
; common pins config, bit 5=0, 4=1 
    _send_cmd COM_CFG 
    _send_cmd COM_DISABLE_REMAP+COM_ALTERNATE
; constrast level 1, lowest 
    _send_cmd DISP_CONTRAST
    _send_cmd 1
; display RAM 
    _send_cmd DISP_RAM
; display normal 
    _send_cmd DISP_NORMAL
; clock frequency=maximum and display divisor=1 
    _send_cmd CLK_FREQ_DIV
    _send_cmd ((15<<CLK_FREQ)+(0<<DISP_DIV)) 
; pre-charge phase1=1 and phase2=15
; reducing phase2 value dim display  
    _send_cmd PRE_CHARGE
    _send_cmd ((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD))
; RAM addressing mode       
    _send_cmd ADR_MODE 
    _send_cmd HORZ_MODE
; Vcomh deselect level 0.83volt 
    _send_cmd VCOMH_DSEL 
    _send_cmd VCOMH_DSEL_83
; enable charge pump 
    _send_cmd DISP_CHARGE_PUMP
    _send_cmd CP_ON 
; disable scrolling 
    _send_cmd SCROLL_STOP
; diplay row from 0 
    _send_cmd START_LINE 
; activate display 
    _send_cmd DISP_ON 
    ret 

;--------------------------------
; set column address to 0:127 
; set page address to 0:7 
;--------------------------------
all_display:
; page window 0..7
    _send_cmd PAG_WND 
    _send_cmd 0  
    _send_cmd 7 
; columns windows 0..127
    _send_cmd COL_WND 
    _send_cmd 0 
    _send_cmd 127
    ret 

;-----------------------
; set ram write window 
; input:
;     XH  col low  
;     XL  col high
;     YH  page low 
;     YL  page high 
;-----------------------
set_window:
    pushw x 
    pushw y 
    _send_cmd PAG_WND 
    pop a 
    call oled_cmd 
    pop a 
    call oled_cmd 
    _send_cmd COL_WND 
    pop a 
    call oled_cmd 
    pop a 
    jp oled_cmd 

.if 0
;------------------------
; scroll display left|right  
; input:
;     A   SCROLL_LEFT|SCROLL_RIGHT 
;     XL  speed 
;------------------------
scroll:
    pushw x 
    call oled_cmd 
    _send_cmd 0 ; dummy byte  
    _send_cmd 0 ; start page 0 
    pop a ; 
    pop a ; 
    call oled_cmd ;speed  
    _send_cmd 7 ; end page 
    _send_cmd 0 ; dummy 
    _send_cmd 255 ; dummy
    _send_cmd SCROLL_START 
    ret 

;---------------------------------
; enable/disable charge pump 
; parameters:
;    A    CP_OFF|CP_ON 
;---------------------------------
charge_pump_switch:
    push a 
    _send_cmd DISP_CHARGE_PUMP
    pop a 
    jra oled_cmd 

.endif 

;---------------------------------
; send command to OLED 
; parameters:
;     A     command code  
;---------------------------------
oled_cmd:
    pushw x 
    _clrz i2c_count 
    mov i2c_count+1,#2
    ldw x,#co_code 
    ld (1,x),a 
    ld a,#OLED_CMD 
    ld (x),a   
    _strxz i2c_buf 
    mov i2c_devid,#OLED_DEVID 
    _clrz i2c_status
    call i2c_write
    popw x 
    ret 

;---------------------------------
; send data to OLED GDDRAM
; parameters:
;     X     byte count  
;---------------------------------
oled_data:
    incw x   
    _strxz i2c_count     
    ldw x,#co_code 
    ld a,#OLED_DATA 
    ld (x),a 
    _strxz i2c_buf
    mov i2c_devid,#OLED_DEVID 
    _clrz i2c_status
    call i2c_write
    ret 






