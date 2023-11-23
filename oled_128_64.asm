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

DISP_HEIGHT=64 ; pixels 
DISP_WIDTH=128 ; pixels 

;-------------------------------
;  SSD1306 commands set 
;-------------------------------
; display on/off commands 
DISP_OFF=0XAE      ; turn off display 
DISP_ON=0XAF       ; turn on display 
DISP_CONTRAST=0X81 ; adjust contrast 0..127
DISP_RAM=0XA4     ; diplay RAM bits 
DISP_ALL_ON=0XA5  ; all pixel on 
DISP_NORMAL=0XA6  ; normal display, i.e. bit set oled light 
DISP_INVERSE=0XA7 ; inverted display 
DISP_CHARGE_PUMP=0X8D ; enable charge pump 
; scrolling commands 
SCROLL_RIGHT=0X26  ; scroll pages range right 
SCROLL_LEFT=0X27   ; scroll pages range left 
SCROLL_VRIGHT=0X29 ; scroll vertical and right  
SCROLL_VLEFT=0X2A ; scroll vertical and left 
SCROLL_STOP=0X2E   ; stop scrolling 
SCROLL_START=0X2F  ; start scrolling 
VERT_SCROLL_AREA=0XA3  ; set vertical scrolling area 
; addressing setting commands 
; 0x00-0x0f set lower nibble for column start address, page mode  
; 0x10-0x1f set high nibble for column start address, page mode 
ADR_MODE=0X20 ; 0-> horz mode, 1-> vert mode, 2->page mode 
COL_WND=0X21 ; set column window for horz and vert mode 
PAG_WND=0X22 ; set page window for horz and vert mode 
; 0xb0-0xb7 set start page for page mode 
START_LINE=0X40 ; 0x40-0x7f set display start line 
MAP_SEG0_COL0=0XA0 ; map segment 0 to column 0 
MAP_SEG0_COL128=0XA1 ; inverse mapping segment 0 to col 127   
MUX_RATIO=0XA8 ; reset to 64 
SCAN_TOP_DOWN=0XC0 ; scan from COM0 to COM63 
SCAN_REVERSE=0XC8 ; scan from COM63 to COM0 
DISP_OFFSET=0XD3 ; display offset to COMx 
COM_CFG=0XDA ; set COM pins hardware configuration 
;Timing & Driving Scheme Setting Command Table
CLK_FREQ_DIV=0xD5 ; clock frequency and divisor 
PRE_CHARGE=0xD9 ; set pre-charge period 
VCOM_DESEL=0XDB ; set Vcomh deselect level 
OLED_NOP=0xE3 

; switch charge pump on/off 
CP_OFF=0x10 
CP_ON=0x14 


OLED_CMD=0x80 
OLED_DATA=0x40 


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
    _send_cmd 0x12
; constrast level 0x7f half-way 
    _send_cmd DISP_CONTRAST
    _send_cmd 0x1 
; display RAM 
    _send_cmd DISP_RAM
; display normal 
    _send_cmd DISP_NORMAL
; clock frequency=std and display divisor=1 
    _send_cmd CLK_FREQ_DIV
    _send_cmd 0xF0 
; pre-charge phase1=1 and phase2=15 
    _send_cmd PRE_CHARGE
    _send_cmd 0xf1 
; page addressing mode       
    _send_cmd ADR_MODE 
    _send_cmd 2
; Vcomh deselect level 0.83volt 
    _send_cmd VCOM_DESEL 
    _send_cmd #0x30 
; enable charge pump 
    _send_cmd DISP_CHARGE_PUMP
    _send_cmd 0x14
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
;    ldw x,#2 
;    _strxz i2c_count 
    _clrz i2c_count 
    mov i2c_count+1,#2
    ldw x,#co_code 
    ld (1,x),a 
    ld a,#OLED_CMD 
oled_send:
    ld (x),a   
    _strxz i2c_buf 
    mov i2c_devid,#OLED_DEVID 
    _clrz i2c_status
    call i2c_write
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
    jra oled_send  


