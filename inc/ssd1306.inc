;-----------------------
;  SSD1306 commands set 
;-----------------------


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
VCOMH_DSEL=0XDB ; set Vcomh deselect level 
OLED_NOP=0xE3 

; memory addressing mode 
HORZ_MODE=0 ; At each byte write column address pointer increase by 1 
            ; when reach end rollback to 0 and page pointer is increased by 1.
VERT_MODE=1 ; At each byte write page pointer is increased by 1 and 
            ; when last page is reached rollback to page 0 and column pointer
            ; is increased by 1.
PAGE_MODE=2 ; At each byte write column address pointer is increased by 1 
            ; when reach end rollback to 0 but page address pointer is not modified. 

; switch charge pump on/off 
CP_OFF=0x10 
CP_ON=0x14 

; co byte, first byte sent 
; after device address.
OLED_CMD=0x80 
OLED_DATA=0x40 


;--------------------------------
; command 0XDA parameter  
; COM pins hardware configuration
;--------------------------------
COM_SEQUENTIAL=0 ; sequential pin scanning 0..63
COM_ALTERNATE=0x10 ; alternate pin scanning 
COM_DISABLE_REMAP=0  ; direct scanning 
COM_ENABLE_REMAP=0x20 ; inverse scanning 

;------------------------
; command 0xD5 
; set display clock Divide
; and frequency 
;--------------------------
CLK_FREQ=4; bit field 7:4 clok frequency (0..15)
DISP_DIV=0 ; bit field 3:0 display clock divisor {0..15}

;--------------------------
; command 0xD9 
; set pre-charge period 
;-------------------------
PHASE1_PERIOD=0 ; bit field 3:0 range {0..15}
PHASE2_PERIOD=4 ; bit field 7:4 range {0..15}

;-------------------------
; command 0XDB 
; set Vcomh deslect level 
;------------------------
VCOMH_DSEL_65=0
VCOMH_DSEL_77=0X20 
VCOMH_DSEL_83=0X30
