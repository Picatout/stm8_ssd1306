ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     20 ;;; hardware initialisation
                                     21 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
                                     22 
                                     23 ;------------------------
                                     24 ; if unified compilation 
                                     25 ; must be first in list 
                                     26 ;-----------------------
                                     27 
                                     28     .module HW_INIT 
                                     29 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 2.
Hexadecimal [24-Bits]



                                     30     .include "config.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;;  configuration parameters 
                                      3 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      4 
                                      5 ;-----------------------
                                      6 ;  version  
                                      7 ;  information 
                                      8 ;-----------------------
                           000001     9 	MAJOR=1
                           000001    10 	MINOR=1
                           000000    11 	REV=0
                                     12 
                                     13 ; master clock frequency in Mhz 
                           000010    14 	FMSTR=16 
                                     15 
                           000001    16 DEBUG=1 ; set to 0 for final version 
                                     17 
                           000001    18 WANT_TERMINAL=1 ; to have support for usart terminal  
                                     19 
                           000010    20 RX_QUEUE_SIZE=16
                           000028    21 TIB_SIZE=40
                                     22 
                           00500F    23 SOUND_PORT=PD_BASE 
                           000004    24 SOUND_BIT=4 
                                     25 
                           00500F    26 LED_PORT=PD_BASE 
                           000002    27 LED_BIT=2
                                     28 
                                     29 
                           00500A    30 BTN_PORT=PC_BASE 
                           00500B    31 BTN_IDR=PC_IDR
                           000001    32 BTN_A=1
                           000002    33 BTN_B=2
                           000003    34 BTN_UP=3 
                           000004    35 BTN_RIGHT=4
                           000005    36 BTN_DOWN=5
                           000007    37 BTN_LEFT=7
                                     38 
                           0000BE    39 ALL_KEY_UP=(1<<BTN_A)|(1<<BTN_B)|(1<<BTN_UP)|(1<<BTN_DOWN)|(1<<BTN_LEFT)|(1<<BTN_RIGHT)
                                     40 
                                     41 ;------------------------
                                     42 ; beep on pin CN3:13 
                                     43 ; use TIM2_CH1 
                                     44 ;-------------------------
                                     45 
                                     46 ; I2C port on pin 11,12 
                           005005    47 	I2C_PORT=PB 
                           000004    48 	SCL_BIT=4
                           000005    49 	SDA_BIT=5
                                     50 
                                     51 ; ss1306 device ID 
                           000078    52 	OLED_DEVID = 0x78 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     53 	.include "inc/ascii.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of MONA 
                                      4 ;
                                      5 ;     MONA is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     MONA is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------------------------------
                                     20 ;     ASCII control  values
                                     21 ;     CTRL_x   are VT100 keyboard values  
                                     22 ; REF: https://en.wikipedia.org/wiki/ASCII    
                                     23 ;-------------------------------------------------------
                           000001    24 		CTRL_A = 1
                           000001    25 		SOH=CTRL_A  ; start of heading 
                           000002    26 		CTRL_B = 2
                           000002    27 		STX=CTRL_B  ; start of text 
                           000003    28 		CTRL_C = 3
                           000003    29 		ETX=CTRL_C  ; end of text 
                           000004    30 		CTRL_D = 4
                           000004    31 		EOT=CTRL_D  ; end of transmission 
                           000005    32 		CTRL_E = 5
                           000005    33 		ENQ=CTRL_E  ; enquery 
                           000006    34 		CTRL_F = 6
                           000006    35 		ACK=CTRL_F  ; acknowledge
                           000007    36 		CTRL_G = 7
                           000007    37         BELL = 7    ; vt100 terminal generate a sound.
                           000008    38 		CTRL_H = 8  
                           000008    39 		BS = 8     ; back space 
                           000009    40         CTRL_I = 9
                           000009    41     	TAB = 9     ; horizontal tabulation
                           00000A    42         CTRL_J = 10 
                           00000A    43 		LF = 10     ; line feed
                           00000B    44 		CTRL_K = 11
                           00000B    45         VT = 11     ; vertical tabulation 
                           00000C    46 		CTRL_L = 12
                           00000C    47         FF = 12      ; new page
                           00000D    48 		CTRL_M = 13
                           00000D    49 		CR = 13      ; carriage return 
                           00000E    50 		CTRL_N = 14
                           00000E    51 		SO=CTRL_N    ; shift out 
                           00000F    52 		CTRL_O = 15
                           00000F    53 		SI=CTRL_O    ; shift in 
                           000010    54 		CTRL_P = 16
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 4.
Hexadecimal [24-Bits]



                           000010    55 		DLE=CTRL_P   ; data link escape 
                           000011    56 		CTRL_Q = 17
                           000011    57 		DC1=CTRL_Q   ; device control 1 
                           000011    58 		XON=DC1 
                           000012    59 		CTRL_R = 18
                           000012    60 		DC2=CTRL_R   ; device control 2 
                           000013    61 		CTRL_S = 19
                           000013    62 		DC3=CTRL_S   ; device control 3
                           000013    63 		XOFF=DC3 
                           000014    64 		CTRL_T = 20
                           000014    65 		DC4=CTRL_T   ; device control 4 
                           000015    66 		CTRL_U = 21
                           000015    67 		NAK=CTRL_U   ; negative acknowledge
                           000016    68 		CTRL_V = 22
                           000016    69 		SYN=CTRL_V   ; synchronous idle 
                           000017    70 		CTRL_W = 23
                           000017    71 		ETB=CTRL_W   ; end of transmission block
                           000018    72 		CTRL_X = 24
                           000018    73 		CAN=CTRL_X   ; cancel 
                           000019    74 		CTRL_Y = 25
                           000019    75 		EM=CTRL_Y    ; end of medium
                           00001A    76 		CTRL_Z = 26
                           00001A    77 		SUB=CTRL_Z   ; substitute 
                           00001A    78 		EOF=SUB      ; end of text file in MSDOS 
                           00001B    79 		ESC = 27     ; escape 
                           00001C    80 		FS=28        ; file separator 
                           00001D    81 		GS=29        ; group separator 
                           00001E    82 		RS=30		 ; record separator 
                           00001F    83 		US=31 		 ; unit separator 
                           000020    84 		SPACE = 32
                           00002C    85 		COMMA = 44
                           00003A    86 		COLON = 58 
                           00003B    87 		SEMIC = 59  
                           000023    88 		SHARP = 35
                           000027    89 		TICK = 39
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 5.
Hexadecimal [24-Bits]



                                     54 
                           000000    55 S207=0
                           000000    56 .if S207
                                     57 S103=0	
                                     58     .include "inc/stm8s207.inc"
                                     59 	.include "inc/nucleo_8s207.inc" 
                           000001    60 .else 
                           000001    61 S103=1
                                     62 .endif
                           000001    63 .if S103 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
Hexadecimal [24-Bits]



                                     64 	.include "inc/stm8s103f3.inc"
                                      1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                      2 ;; Copyright Jacques Deschênes 2019,2020,2021 
                                      3 ;; This file is part of stm32_eforth  
                                      4 ;;
                                      5 ;;     stm8_eforth is free software: you can redistribute it and/or modify
                                      6 ;;     it under the terms of the GNU General Public License as published by
                                      7 ;;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;;     (at your option) any later version.
                                      9 ;;
                                     10 ;;     stm32_eforth is distributed in the hope that it will be useful,
                                     11 ;;     but WITHOUT ANY WARRANTY;; without even the implied warranty of
                                     12 ;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;;     GNU General Public License for more details.
                                     14 ;;
                                     15 ;;     You should have received a copy of the GNU General Public License
                                     16 ;;     along with stm32_eforth.  If not, see <http:;;www.gnu.org/licenses/>.
                                     17 ;;;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 
                                     20 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     21 ; 2019/04/26
                                     22 ; STM8S105x4/6 µC registers map
                                     23 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     24 	.module stm8s105c6
                                     25 	
                                     26 ;;;;;;;;;;
                                     27 ; bit mask
                                     28 ;;;;;;;;;;
                           000000    29  BIT0 = (0)
                           000001    30  BIT1 = (1)
                           000002    31  BIT2 = (2)
                           000003    32  BIT3 = (3)
                           000004    33  BIT4 = (4)
                           000005    34  BIT5 = (5)
                           000006    35  BIT6 = (6)
                           000007    36  BIT7 = (7)
                                     37 
                                     38 ; controller memory regions
                           000400    39 RAM_SIZE = (1024) 
                           000280    40 EEPROM_SIZE = (640) 
                           002000    41 FLASH_SIZE = (8192)
                                     42 
                           000000    43  RAM_BASE = (0)
                           0003FF    44  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           004000    45  EEPROM_BASE = (0x4000)
                           00427F    46  EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
                           005000    47  SFR_BASE = (0x5000)
                           0057FF    48  SFR_END = (0x57FF)
                           008000    49  FLASH_BASE = (0x8000)
                           004800    50  OPTION_BASE = (0x4800)
                           00480A    51  OPTION_END = (0x480A)
                           004865    52  DEVID_BASE = (0x4865)
                           004870    53  DEVID_END = (0x4870)
                           000040    54  BLOCK_SIZE = 64 ; flash|eeprom block size
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                           004000    55 GPIO_BASE = (0x4000)
                           0057FF    56 GPIO_END = (0x57ff)
                                     57 
                                     58 ; options bytes
                                     59 ; this one can be programmed only from SWIM  (ICP)
                           004800    60  OPT0  = (0x4800)
                                     61 ; these can be programmed at runtime (IAP)
                           004801    62  OPT1  = (0x4801)
                           004802    63  NOPT1  = (0x4802)
                           004803    64  OPT2  = (0x4803)
                           004804    65  NOPT2  = (0x4804)
                           004805    66  OPT3  = (0x4805)
                           004806    67  NOPT3  = (0x4806)
                           004807    68  OPT4  = (0x4807)
                           004808    69  NOPT4  = (0x4808)
                           004809    70  OPT5  = (0x4809)
                           00480A    71  NOPT5  = (0x480A)
                                     72 ; option registers usage
                                     73 ; read out protection, value 0xAA enable ROP
                           004800    74  ROP = OPT0  
                                     75 ; user boot code, {0..0x3e} 512 bytes row
                           004801    76  UBC = OPT1
                           004802    77  NUBC = NOPT1
                                     78 ; alternate function register
                           004803    79  AFR = OPT2
                           004804    80  NAFR = NOPT2
                                     81 ; miscelinous options
                           004805    82  MISCOPT = OPT3
                           004806    83  NMISCOPT = NOPT3
                                     84 ; clock options
                           004807    85  CLKOPT = OPT4
                           004808    86  NCLKOPT = NOPT4
                                     87 ; HSE clock startup delay
                           004809    88  HSECNT = OPT5
                           00480A    89  NHSECNT = NOPT5
                                     90 
                                     91 ; MISCOPT bits
                           000004    92   MISCOPT_HSITRIM =  BIT4
                           000003    93   MISCOPT_LSIEN   =  BIT3
                           000002    94   MISCOPT_IWDG_HW =  BIT2
                           000001    95   MISCOPT_WWDG_HW =  BIT1
                           000000    96   MISCOPT_WWDG_HALT = BIT0
                                     97 ; NMISCOPT bits
                           FFFFFFFB    98   NMISCOPT_NHSITRIM  = ~BIT4
                           FFFFFFFC    99   NMISCOPT_NLSIEN    = ~BIT3
                           FFFFFFFD   100   NMISCOPT_NIWDG_HW  = ~BIT2
                           FFFFFFFE   101   NMISCOPT_NWWDG_HW  = ~BIT1
                           FFFFFFFF   102   NMISCOPT_NWWDG_HALT = ~BIT0
                                    103 ; CLKOPT bits
                           000003   104  CLKOPT_EXT_CLK  = BIT3
                           000002   105  CLKOPT_CKAWUSEL = BIT2
                           000001   106  CLKOPT_PRS_C1   = BIT1
                           000000   107  CLKOPT_PRS_C0   = BIT0
                                    108 
                                    109 ; AFR option, remapable functions
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                           000007   110  AFR7 = BIT7 ;Port C3 = TIM1_CH1N; port C4 = TIM1_CH2N.
                           000006   111  AFR6 = BIT6 ;reserved  
                           000005   112  AFR5 = BIT5 ;reserved 
                           000004   113  AFR4 = BIT4 ;Port B4 = ADC1_ETR; port B5 =TIM1_BKIN
                           000003   114  AFR3 = BIT3 ;Port C3 = TLI
                           000002   115  AFR2 = BIT2 ;reserved
                           000001   116  AFR1 = BIT1 ;Port A3 = SPI_NSS; port D2 =TIM2_CH3
                           000000   117  AFR0 = BIT0 ;Port C5 = TIM2_CH1; port C6 =TIM1_CH1; port C7 = TIM1_CH2
                                    118 
                                    119 ; device ID = (read only)
                           0048CD   120  DEVID_XL  = (0x48CD)
                           0048CE   121  DEVID_XH  = (0x48CE)
                           0048CF   122  DEVID_YL  = (0x48CF)
                           0048D0   123  DEVID_YH  = (0x48D0)
                           0048D1   124  DEVID_WAF  = (0x48D1)
                           0048D2   125  DEVID_LOT0  = (0x48D2)
                           0048D3   126  DEVID_LOT1  = (0x48D3)
                           0048D4   127  DEVID_LOT2  = (0x48D4)
                           0048D5   128  DEVID_LOT3  = (0x48D5)
                           0048D6   129  DEVID_LOT4  = (0x48D6)
                           0048D7   130  DEVID_LOT5  = (0x48D7)
                           0048D8   131  DEVID_LOT6  = (0x48D8)
                                    132 
                                    133 
                                    134 ; port bit
                           000000   135  PIN0 = (0)
                           000001   136  PIN1 = (1)
                           000002   137  PIN2 = (2)
                           000003   138  PIN3 = (3)
                           000004   139  PIN4 = (4)
                           000005   140  PIN5 = (5)
                           000006   141  PIN6 = (6)
                           000007   142  PIN7 = (7)
                                    143 
                                    144 ; GPIO PORTS base addresses
                           005000   145 PA = 0x5000
                           005005   146 PB = 0x5005
                           00500A   147 PC = 0x500A
                           00500F   148 PD = 0x500F
                           005014   149 PE = 0x5014
                           005019   150 PF = 0x5019
                                    151 
                                    152 ; GPIO register offset 
                           000000   153 GPIO_ODR = (0)
                           000001   154 GPIO_IDR = (1)
                           000002   155 GPIO_DDR = (2)
                           000003   156 GPIO_CR1 = (3)
                           000004   157 GPIO_CR2 = (4)
                                    158 
                                    159 ; GPIO
                           005000   160  PA_BASE = (0x5000)
                           005000   161  PA_ODR  = (0x5000)
                           005001   162  PA_IDR  = (0x5001)
                           005002   163  PA_DDR  = (0x5002)
                           005003   164  PA_CR1  = (0x5003)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                           005004   165  PA_CR2  = (0x5004)
                                    166 
                           005005   167  PB_BASE = (0x5005)
                           005005   168  PB_ODR  = (0x5005)
                           005006   169  PB_IDR  = (0x5006)
                           005007   170  PB_DDR  = (0x5007)
                           005008   171  PB_CR1  = (0x5008)
                           005009   172  PB_CR2  = (0x5009)
                                    173 
                           00500A   174  PC_BASE = (0x500A)
                           00500A   175  PC_ODR  = (0x500A)
                           00500B   176  PC_IDR  = (0x500B)
                           00500C   177  PC_DDR  = (0x500C)
                           00500D   178  PC_CR1  = (0x500D)
                           00500E   179  PC_CR2  = (0x500E)
                                    180 
                           00500F   181  PD_BASE = (0x500F)
                           00500F   182  PD_ODR  = (0x500F)
                           005010   183  PD_IDR  = (0x5010)
                           005011   184  PD_DDR  = (0x5011)
                           005012   185  PD_CR1  = (0x5012)
                           005013   186  PD_CR2  = (0x5013)
                                    187 
                           005014   188  PE_BASE = (0x5014)
                           005014   189  PE_ODR  = (0x5014)
                           005015   190  PE_IDR  = (0x5015)
                           005016   191  PE_DDR  = (0x5016)
                           005017   192  PE_CR1  = (0x5017)
                           005018   193  PE_CR2  = (0x5018)
                                    194 
                           005019   195  PF_BASE = (0x5019)
                           005019   196  PF_ODR  = (0x5019)
                           00501A   197  PF_IDR  = (0x501A)
                           00501B   198  PF_DDR  = (0x501B)
                           00501C   199  PF_CR1  = (0x501C)
                           00501D   200  PF_CR2  = (0x501D)
                                    201 
                                    202  ; input modes CR1
                           000000   203  INPUT_FLOAT = (0)
                           000001   204  INPUT_PULLUP = (1)
                                    205 ; output mode CR1
                           000000   206  OUTPUT_OD = (0)
                           000001   207  OUTPUT_PP = (1)
                                    208 ; input modes CR2
                           000000   209  INPUT_DI = (0)
                           000001   210  INPUT_EI = (1)
                                    211 ; output speed CR2
                           000000   212  OUTPUT_SLOW = (0)
                           000001   213  OUTPUT_FAST = (1)
                                    214 
                                    215 
                                    216 ; Flash
                           00505A   217  FLASH_CR1  = (0x505A)
                           00505B   218  FLASH_CR2  = (0x505B)
                           00505C   219  FLASH_NCR2  = (0x505C)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                           00505D   220  FLASH_FPR  = (0x505D)
                           00505E   221  FLASH_NFPR  = (0x505E)
                           00505F   222  FLASH_IAPSR  = (0x505F)
                           005062   223  FLASH_PUKR  = (0x5062)
                           005064   224  FLASH_DUKR  = (0x5064)
                                    225 ; data memory unlock keys
                           0000AE   226  FLASH_DUKR_KEY1 = (0xae)
                           000056   227  FLASH_DUKR_KEY2 = (0x56)
                                    228 ; flash memory unlock keys
                           000056   229  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   230  FLASH_PUKR_KEY2 = (0xae)
                                    231 ; FLASH_CR1 bits
                           000003   232  FLASH_CR1_HALT = BIT3
                           000002   233  FLASH_CR1_AHALT = BIT2
                           000001   234  FLASH_CR1_IE = BIT1
                           000000   235  FLASH_CR1_FIX = BIT0
                                    236 ; FLASH_CR2 bits
                           000007   237  FLASH_CR2_OPT = BIT7
                           000006   238  FLASH_CR2_WPRG = BIT6
                           000005   239  FLASH_CR2_ERASE = BIT5
                           000004   240  FLASH_CR2_FPRG = BIT4
                           000000   241  FLASH_CR2_PRG = BIT0
                                    242 ; FLASH_FPR bits
                           000005   243  FLASH_FPR_WPB5 = BIT5
                           000004   244  FLASH_FPR_WPB4 = BIT4
                           000003   245  FLASH_FPR_WPB3 = BIT3
                           000002   246  FLASH_FPR_WPB2 = BIT2
                           000001   247  FLASH_FPR_WPB1 = BIT1
                           000000   248  FLASH_FPR_WPB0 = BIT0
                                    249 ; FLASH_NFPR bits
                           000005   250  FLASH_NFPR_NWPB5 = BIT5
                           000004   251  FLASH_NFPR_NWPB4 = BIT4
                           000003   252  FLASH_NFPR_NWPB3 = BIT3
                           000002   253  FLASH_NFPR_NWPB2 = BIT2
                           000001   254  FLASH_NFPR_NWPB1 = BIT1
                           000000   255  FLASH_NFPR_NWPB0 = BIT0
                                    256 ; FLASH_IAPSR bits
                           000006   257  FLASH_IAPSR_HVOFF = BIT6
                           000003   258  FLASH_IAPSR_DUL = BIT3
                           000002   259  FLASH_IAPSR_EOP = BIT2
                           000001   260  FLASH_IAPSR_PUL = BIT1
                           000000   261  FLASH_IAPSR_WR_PG_DIS = BIT0
                                    262 
                                    263 ; Interrupt control
                           0050A0   264  EXTI_CR1  = (0x50A0)
                           0050A1   265  EXTI_CR2  = (0x50A1)
                                    266 
                                    267 ; Reset Status
                           0050B3   268  RST_SR  = (0x50B3)
                                    269 
                                    270 ; Clock Registers
                           0050C0   271  CLK_ICKR  = (0x50c0)
                           0050C1   272  CLK_ECKR  = (0x50c1)
                           0050C3   273  CLK_CMSR  = (0x50C3)
                           0050C4   274  CLK_SWR  = (0x50C4)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                           0050C5   275  CLK_SWCR  = (0x50C5)
                           0050C6   276  CLK_CKDIVR  = (0x50C6)
                           0050C7   277  CLK_PCKENR1  = (0x50C7)
                           0050C8   278  CLK_CSSR  = (0x50C8)
                           0050C9   279  CLK_CCOR  = (0x50C9)
                           0050CA   280  CLK_PCKENR2  = (0x50CA)
                           0050CC   281  CLK_HSITRIMR  = (0x50CC)
                           0050CD   282  CLK_SWIMCCR  = (0x50CD)
                                    283 
                                    284 ; Peripherals clock gating
                                    285 ; CLK_PCKENR1 
                           000007   286  CLK_PCKENR1_TIM1 = (7)
                           000005   287  CLK_PCKENR1_TIM2 = (5)
                           000004   288  CLK_PCKENR1_TIM4 = (4)
                           000003   289  CLK_PCKENR1_UART1 = (3)
                           000001   290  CLK_PCKENR1_SPI = (1)
                           000000   291  CLK_PCKENR1_I2C = (0)
                                    292 ; CLK_PCKENR2
                           000003   293  CLK_PCKENR2_ADC1 = (3)
                           000002   294  CLK_PCKENR2_AWU = (2)
                                    295 
                                    296 ; Clock bits
                           000005   297  CLK_ICKR_REGAH = (5)
                           000004   298  CLK_ICKR_LSIRDY = (4)
                           000003   299  CLK_ICKR_LSIEN = (3)
                           000002   300  CLK_ICKR_FHW = (2)
                           000001   301  CLK_ICKR_HSIRDY = (1)
                           000000   302  CLK_ICKR_HSIEN = (0)
                                    303 
                           000001   304  CLK_ECKR_HSERDY = (1)
                           000000   305  CLK_ECKR_HSEEN = (0)
                                    306 ; clock source
                           0000E1   307  CLK_SWR_HSI = 0xE1
                           0000D2   308  CLK_SWR_LSI = 0xD2
                           0000B4   309  CLK_SWR_HSE = 0xB4
                                    310 
                           000003   311  CLK_SWCR_SWIF = (3)
                           000002   312  CLK_SWCR_SWIEN = (2)
                           000001   313  CLK_SWCR_SWEN = (1)
                           000000   314  CLK_SWCR_SWBSY = (0)
                                    315 
                           000004   316  CLK_CKDIVR_HSIDIV1 = (4)
                           000003   317  CLK_CKDIVR_HSIDIV0 = (3)
                           000002   318  CLK_CKDIVR_CPUDIV2 = (2)
                           000001   319  CLK_CKDIVR_CPUDIV1 = (1)
                           000000   320  CLK_CKDIVR_CPUDIV0 = (0)
                                    321 
                                    322 ; Watchdog
                           0050D1   323  WWDG_CR  = (0x50D1)
                           0050D2   324  WWDG_WR  = (0x50D2)
                           0050E0   325  IWDG_KR  = (0x50E0)
                           0050E1   326  IWDG_PR  = (0x50E1)
                           0050E2   327  IWDG_RLR  = (0x50E2)
                           0050F0   328  AWU_CSR1  = (0x50F0)
                           0050F1   329  AWU_APR  = (0x50F1)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                           0050F2   330  AWU_TBR  = (0x50F2)
                                    331 
                                    332 ; Beep
                           0050F3   333  BEEP_CSR  = (0x50F3)
                                    334 
                                    335 ; SPI
                           005200   336  SPI_CR1  = (0x5200)
                           005201   337  SPI_CR2  = (0x5201)
                           005202   338  SPI_ICR  = (0x5202)
                           005203   339  SPI_SR  = (0x5203)
                           005204   340  SPI_DR  = (0x5204)
                           005205   341  SPI_CRCPR  = (0x5205)
                           005206   342  SPI_RXCRCR  = (0x5206)
                           005207   343  SPI_TXCRCR  = (0x5207)
                                    344 
                                    345 ; I2C
                           005210   346  I2C_CR1  = (0x5210)
                           005211   347  I2C_CR2  = (0x5211)
                           005212   348  I2C_FREQR  = (0x5212)
                           005213   349  I2C_OARL  = (0x5213)
                           005214   350  I2C_OARH  = (0x5214)
                           005216   351  I2C_DR  = (0x5216)
                           005217   352  I2C_SR1  = (0x5217)
                           005218   353  I2C_SR2  = (0x5218)
                           005219   354  I2C_SR3  = (0x5219)
                           00521A   355  I2C_ITR  = (0x521A)
                           00521B   356  I2C_CCRL  = (0x521B)
                           00521C   357  I2C_CCRH  = (0x521C)
                           00521D   358  I2C_TRISER  = (0x521D)
                           00521E   359  I2C_PECR  = (0x521E)
                                    360 
                           000000   361  I2C_STD = 0 
                           000001   362  I2C_FAST = 1 
                                    363 
                                    364 
                           000007   365  I2C_CR1_NOSTRETCH = (7)
                           000006   366  I2C_CR1_ENGC = (6)
                           000000   367  I2C_CR1_PE = (0)
                                    368 
                           000007   369  I2C_CR2_SWRST = (7)
                           000003   370  I2C_CR2_POS = (3)
                           000002   371  I2C_CR2_ACK = (2)
                           000001   372  I2C_CR2_STOP = (1)
                           000000   373  I2C_CR2_START = (0)
                                    374 
                           000000   375  I2C_OARL_ADD0 = (0)
                                    376 
                           000009   377  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   378  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    379 
                           000007   380  I2C_OARH_ADDMODE = (7)
                           000006   381  I2C_OARH_ADDCONF = (6)
                           000002   382  I2C_OARH_ADD9 = (2)
                           000001   383  I2C_OARH_ADD8 = (1)
                                    384 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                           000007   385  I2C_SR1_TXE = (7)
                           000006   386  I2C_SR1_RXNE = (6)
                           000004   387  I2C_SR1_STOPF = (4)
                           000003   388  I2C_SR1_ADD10 = (3)
                           000002   389  I2C_SR1_BTF = (2)
                           000001   390  I2C_SR1_ADDR = (1)
                           000000   391  I2C_SR1_SB = (0)
                                    392 
                           000005   393  I2C_SR2_WUFH = (5)
                           000003   394  I2C_SR2_OVR = (3)
                           000002   395  I2C_SR2_AF = (2)
                           000001   396  I2C_SR2_ARLO = (1)
                           000000   397  I2C_SR2_BERR = (0)
                                    398 
                           000007   399  I2C_SR3_DUALF = (7)
                           000004   400  I2C_SR3_GENCALL = (4)
                           000002   401  I2C_SR3_TRA = (2)
                           000001   402  I2C_SR3_BUSY = (1)
                           000000   403  I2C_SR3_MSL = (0)
                                    404 
                           000002   405  I2C_ITR_ITBUFEN = (2)
                           000001   406  I2C_ITR_ITEVTEN = (1)
                           000000   407  I2C_ITR_ITERREN = (0)
                                    408 
                                    409 ; Precalculated values, all in KHz
                           000080   410  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   411  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    412 ;
                                    413 ; Fast I2C mode max rise time = 300ns
                                    414 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    415 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
                                    416 
                           000005   417  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    418 
                           0000C0   419  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   420  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   421  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    422 
                           000080   423  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   424  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   425  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    426 
                           000000   427  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   428  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    429 ;
                                    430 ; Standard I2C mode max rise time = 1000ns
                                    431 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    432 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    433 
                           000011   434  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    435 
                           000000   436  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   437  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   438  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    439 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                           000001   440  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   441  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   442  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    443 
                           000001   444  I2C_READ = 1
                           000000   445  I2C_WRITE = 0
                                    446 
                                    447 ; baudrate constant for brr_value table access
                           000000   448 B2400=0
                           000001   449 B4800=1
                           000002   450 B9600=2
                           000003   451 B19200=3
                           000004   452 B38400=4
                           000005   453 B57600=5
                           000006   454 B115200=6
                           000007   455 B230400=7
                           000008   456 B460800=8
                           000009   457 B921600=9
                                    458 
                                    459 ; UART1
                           005230   460 UART1 = 0x5230 
                           005230   461  UART1_SR    = (0x5230)
                           005231   462  UART1_DR    = (0x5231)
                           005232   463  UART1_BRR1  = (0x5232)
                           005233   464  UART1_BRR2  = (0x5233)
                           005234   465  UART1_CR1   = (0x5234)
                           005235   466  UART1_CR2   = (0x5235)
                           005236   467  UART1_CR3   = (0x5236)
                           005237   468  UART1_CR4   = (0x5237)
                           005238   469  UART1_CR5   = (0x5238)
                           005239   470  UART1_GTR   = (0x5239)
                           00523A   471  UART1_PSCR  = (0x523A)
                                    472 
                           000002   473  UART1_TX_PIN = 2 ; PD5
                           000003   474  UART1_RX_PIN = 3 ; PD6 
                           00900F   475  UART1_PORT = GPIO_BASE+PD 
                                    476 
                                    477 ; UART Status Register bits
                           000007   478  UART_SR_TXE = (7)
                           000006   479  UART_SR_TC = (6)
                           000005   480  UART_SR_RXNE = (5)
                           000004   481  UART_SR_IDLE = (4)
                           000003   482  UART_SR_OR = (3)
                           000002   483  UART_SR_NF = (2)
                           000001   484  UART_SR_FE = (1)
                           000000   485  UART_SR_PE = (0)
                                    486 
                                    487 ; Uart Control Register bits
                           000007   488  UART_CR1_R8 = (7)
                           000006   489  UART_CR1_T8 = (6)
                           000005   490  UART_CR1_UARTD = (5)
                           000004   491  UART_CR1_M = (4)
                           000003   492  UART_CR1_WAKE = (3)
                           000002   493  UART_CR1_PCEN = (2)
                           000001   494  UART_CR1_PS = (1)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                           000000   495  UART_CR1_PIEN = (0)
                                    496 
                           000007   497  UART_CR2_TIEN = (7)
                           000006   498  UART_CR2_TCIEN = (6)
                           000005   499  UART_CR2_RIEN = (5)
                           000004   500  UART_CR2_ILIEN = (4)
                           000003   501  UART_CR2_TEN = (3)
                           000002   502  UART_CR2_REN = (2)
                           000001   503  UART_CR2_RWU = (1)
                           000000   504  UART_CR2_SBK = (0)
                                    505 
                           000006   506  UART_CR3_LINEN = (6)
                           000005   507  UART_CR3_STOP1 = (5)
                           000004   508  UART_CR3_STOP0 = (4)
                           000003   509  UART_CR3_CLKEN = (3)
                           000002   510  UART_CR3_CPOL = (2)
                           000001   511  UART_CR3_CPHA = (1)
                           000000   512  UART_CR3_LBCL = (0)
                                    513 
                           000006   514  UART_CR4_LBDIEN = (6)
                           000005   515  UART_CR4_LBDL = (5)
                           000004   516  UART_CR4_LBDF = (4)
                           000003   517  UART_CR4_ADD3 = (3)
                           000002   518  UART_CR4_ADD2 = (2)
                           000001   519  UART_CR4_ADD1 = (1)
                           000000   520  UART_CR4_ADD0 = (0)
                                    521 
                           000005   522  UART_CR5_SCEN = (5)
                           000004   523  UART_CR5_NACK = (4)
                           000003   524  UART_CR5_HDSEL = (3)
                           000002   525  UART_CR5_IRLP = (2)
                           000001   526  UART_CR5_IREN = (1)
                                    527 
                                    528 ; TIMERS
                                    529 ; Timer 1 - 16-bit timer with complementary PWM outputs
                           005250   530  TIM1_CR1  = (0x5250)
                           005251   531  TIM1_CR2  = (0x5251)
                           005252   532  TIM1_SMCR  = (0x5252)
                           005253   533  TIM1_ETR  = (0x5253)
                           005254   534  TIM1_IER  = (0x5254)
                           005255   535  TIM1_SR1  = (0x5255)
                           005256   536  TIM1_SR2  = (0x5256)
                           005257   537  TIM1_EGR  = (0x5257)
                           005258   538  TIM1_CCMR1  = (0x5258)
                           005259   539  TIM1_CCMR2  = (0x5259)
                           00525A   540  TIM1_CCMR3  = (0x525A)
                           00525B   541  TIM1_CCMR4  = (0x525B)
                           00525C   542  TIM1_CCER1  = (0x525C)
                           00525D   543  TIM1_CCER2  = (0x525D)
                           00525E   544  TIM1_CNTRH  = (0x525E)
                           00525F   545  TIM1_CNTRL  = (0x525F)
                           005260   546  TIM1_PSCRH  = (0x5260)
                           005261   547  TIM1_PSCRL  = (0x5261)
                           005262   548  TIM1_ARRH  = (0x5262)
                           005263   549  TIM1_ARRL  = (0x5263)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                           005264   550  TIM1_RCR  = (0x5264)
                           005265   551  TIM1_CCR1H  = (0x5265)
                           005266   552  TIM1_CCR1L  = (0x5266)
                           005267   553  TIM1_CCR2H  = (0x5267)
                           005268   554  TIM1_CCR2L  = (0x5268)
                           005269   555  TIM1_CCR3H  = (0x5269)
                           00526A   556  TIM1_CCR3L  = (0x526A)
                           00526B   557  TIM1_CCR4H  = (0x526B)
                           00526C   558  TIM1_CCR4L  = (0x526C)
                           00526D   559  TIM1_BKR  = (0x526D)
                           00526E   560  TIM1_DTR  = (0x526E)
                           00526F   561  TIM1_OISR  = (0x526F)
                                    562 
                                    563 ; Timer Control Register bits
                           000007   564  TIM_CR1_ARPE = (7)
                           000006   565  TIM_CR1_CMSH = (6)
                           000005   566  TIM_CR1_CMSL = (5)
                           000004   567  TIM_CR1_DIR = (4)
                           000003   568  TIM_CR1_OPM = (3)
                           000002   569  TIM_CR1_URS = (2)
                           000001   570  TIM_CR1_UDIS = (1)
                           000000   571  TIM_CR1_CEN = (0)
                                    572 
                           000006   573  TIM1_CR2_MMS2 = (6)
                           000005   574  TIM1_CR2_MMS1 = (5)
                           000004   575  TIM1_CR2_MMS0 = (4)
                           000002   576  TIM1_CR2_COMS = (2)
                           000000   577  TIM1_CR2_CCPC = (0)
                                    578 
                                    579 ; Timer Slave Mode Control bits
                           000007   580  TIM1_SMCR_MSM = (7)
                           000006   581  TIM1_SMCR_TS2 = (6)
                           000005   582  TIM1_SMCR_TS1 = (5)
                           000004   583  TIM1_SMCR_TS0 = (4)
                           000002   584  TIM1_SMCR_SMS2 = (2)
                           000001   585  TIM1_SMCR_SMS1 = (1)
                           000000   586  TIM1_SMCR_SMS0 = (0)
                                    587 
                                    588 ; Timer External Trigger Enable bits
                           000007   589  TIM1_ETR_ETP = (7)
                           000006   590  TIM1_ETR_ECE = (6)
                           000005   591  TIM1_ETR_ETPS1 = (5)
                           000004   592  TIM1_ETR_ETPS0 = (4)
                           000003   593  TIM1_ETR_ETF3 = (3)
                           000002   594  TIM1_ETR_ETF2 = (2)
                           000001   595  TIM1_ETR_ETF1 = (1)
                           000000   596  TIM1_ETR_ETF0 = (0)
                                    597 
                                    598 ; Timer Interrupt Enable bits
                           000007   599  TIM1_IER_BIE = (7)
                           000006   600  TIM1_IER_TIE = (6)
                           000005   601  TIM1_IER_COMIE = (5)
                           000004   602  TIM1_IER_CC4IE = (4)
                           000003   603  TIM1_IER_CC3IE = (3)
                           000002   604  TIM1_IER_CC2IE = (2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                           000001   605  TIM1_IER_CC1IE = (1)
                           000000   606  TIM1_IER_UIE = (0)
                                    607 
                                    608 ; Timer Status Register bits
                           000007   609  TIM1_SR1_BIF = (7)
                           000006   610  TIM1_SR1_TIF = (6)
                           000005   611  TIM1_SR1_COMIF = (5)
                           000004   612  TIM1_SR1_CC4IF = (4)
                           000003   613  TIM1_SR1_CC3IF = (3)
                           000002   614  TIM1_SR1_CC2IF = (2)
                           000001   615  TIM1_SR1_CC1IF = (1)
                           000000   616  TIM1_SR1_UIF = (0)
                                    617 
                           000004   618  TIM1_SR2_CC4OF = (4)
                           000003   619  TIM1_SR2_CC3OF = (3)
                           000002   620  TIM1_SR2_CC2OF = (2)
                           000001   621  TIM1_SR2_CC1OF = (1)
                                    622 
                                    623 ; Timer Event Generation Register bits
                           000007   624  TIM_EGR_BG = (7)
                           000006   625  TIM_EGR_TG = (6)
                           000005   626  TIM_EGR_COMG = (5)
                           000004   627  TIM_EGR_CC4G = (4)
                           000003   628  TIM_EGR_CC3G = (3)
                           000002   629  TIM_EGR_CC2G = (2)
                           000001   630  TIM_EGR_CC1G = (1)
                           000000   631  TIM_EGR_UG = (0)
                                    632 
                                    633 ; timer capture compare enable register 
                                    634 ; bit fields 
                           000000   635 TIM_CCER1_CC1E=0 
                           000001   636 TIM_CCER1_CC1P=1 
                           000002   637 TIM_CCER1_CC1NE=2
                           000003   638 TIM_CCER1_CC2NP=3
                           000004   639 TIM_CCER1_CC2E=4 
                           000005   640 TIM_CCER1_CC2P=5
                           000006   641 TIM_CCER1_CC2NE=6
                           000007   642 TIM_CCER1_CC2NP=7
                           000000   643 TIM_CCER2_CC3E=0 
                           000001   644 TIM_CCER2_CC3P=1 
                           000002   645 TIM_CCER2_CC2NE=2
                           000003   646 TIM_CCER2_CC2NP=3
                           000004   647 TIM_CCER2_CC4E=4
                           000005   648 TIM_CCER2_CC4P=5 
                                    649 
                                    650 
                                    651 ; Capture/Compare Mode Register 1 - channel configured in output
                           000007   652  TIM1_CCMR1_OC1CE = (7)
                           000006   653  TIM1_CCMR1_OC1M2 = (6)
                           000005   654  TIM1_CCMR1_OC1M1 = (5)
                           000004   655  TIM1_CCMR1_OC1M0 = (4)
                           000003   656  TIM1_CCMR1_OC1PE = (3)
                           000002   657  TIM1_CCMR1_OC1FE = (2)
                           000001   658  TIM1_CCMR1_CC1S1 = (1)
                           000000   659  TIM1_CCMR1_CC1S0 = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                                    660 
                                    661 ; Capture/Compare Mode Register 1 - channel configured in input
                           000007   662  TIM1_CCMR1_IC1F3 = (7)
                           000006   663  TIM1_CCMR1_IC1F2 = (6)
                           000005   664  TIM1_CCMR1_IC1F1 = (5)
                           000004   665  TIM1_CCMR1_IC1F0 = (4)
                           000003   666  TIM1_CCMR1_IC1PSC1 = (3)
                           000002   667  TIM1_CCMR1_IC1PSC0 = (2)
                                    668 ;  TIM1_CCMR1_CC1S1 = (1)
                           000000   669  TIM1_CCMR1_CC1S0 = (0)
                                    670 
                                    671 ; Capture/Compare Mode Register 2 - channel configured in output
                           000007   672  TIM1_CCMR2_OC2CE = (7)
                           000006   673  TIM1_CCMR2_OC2M2 = (6)
                           000005   674  TIM1_CCMR2_OC2M1 = (5)
                           000004   675  TIM1_CCMR2_OC2M0 = (4)
                           000003   676  TIM1_CCMR2_OC2PE = (3)
                           000002   677  TIM1_CCMR2_OC2FE = (2)
                           000001   678  TIM1_CCMR2_CC2S1 = (1)
                           000000   679  TIM1_CCMR2_CC2S0 = (0)
                                    680 
                                    681 ; Capture/Compare Mode Register 2 - channel configured in input
                           000007   682  TIM1_CCMR2_IC2F3 = (7)
                           000006   683  TIM1_CCMR2_IC2F2 = (6)
                           000005   684  TIM1_CCMR2_IC2F1 = (5)
                           000004   685  TIM1_CCMR2_IC2F0 = (4)
                           000003   686  TIM1_CCMR2_IC2PSC1 = (3)
                           000002   687  TIM1_CCMR2_IC2PSC0 = (2)
                                    688 ;  TIM1_CCMR2_CC2S1 = (1)
                           000000   689  TIM1_CCMR2_CC2S0 = (0)
                                    690 
                                    691 ; Capture/Compare Mode Register 3 - channel configured in output
                           000007   692  TIM1_CCMR3_OC3CE = (7)
                           000006   693  TIM1_CCMR3_OC3M2 = (6)
                           000005   694  TIM1_CCMR3_OC3M1 = (5)
                           000004   695  TIM1_CCMR3_OC3M0 = (4)
                           000003   696  TIM1_CCMR3_OC3PE = (3)
                           000002   697  TIM1_CCMR3_OC3FE = (2)
                           000001   698  TIM1_CCMR3_CC3S1 = (1)
                           000000   699  TIM1_CCMR3_CC3S0 = (0)
                                    700 
                                    701 ; Capture/Compare Mode Register 3 - channel configured in input
                           000007   702  TIM1_CCMR3_IC3F3 = (7)
                           000006   703  TIM1_CCMR3_IC3F2 = (6)
                           000005   704  TIM1_CCMR3_IC3F1 = (5)
                           000004   705  TIM1_CCMR3_IC3F0 = (4)
                           000003   706  TIM1_CCMR3_IC3PSC1 = (3)
                           000002   707  TIM1_CCMR3_IC3PSC0 = (2)
                                    708 ;  TIM1_CCMR3_CC3S1 = (1)
                           000000   709  TIM1_CCMR3_CC3S0 = (0)
                                    710 
                                    711 ; Capture/Compare Mode Register 4 - channel configured in output
                           000007   712  TIM1_CCMR4_OC4CE = (7)
                           000006   713  TIM1_CCMR4_OC4M2 = (6)
                           000005   714  TIM1_CCMR4_OC4M1 = (5)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                           000004   715  TIM1_CCMR4_OC4M0 = (4)
                           000003   716  TIM1_CCMR4_OC4PE = (3)
                           000002   717  TIM1_CCMR4_OC4FE = (2)
                           000001   718  TIM1_CCMR4_CC4S1 = (1)
                           000000   719  TIM1_CCMR4_CC4S0 = (0)
                                    720 
                                    721 ; Capture/Compare Mode Register 4 - channel configured in input
                           000007   722  TIM1_CCMR4_IC4F3 = (7)
                           000006   723  TIM1_CCMR4_IC4F2 = (6)
                           000005   724  TIM1_CCMR4_IC4F1 = (5)
                           000004   725  TIM1_CCMR4_IC4F0 = (4)
                           000003   726  TIM1_CCMR4_IC4PSC1 = (3)
                           000002   727  TIM1_CCMR4_IC4PSC0 = (2)
                                    728 ;  TIM1_CCMR4_CC4S1 = (1)
                           000000   729  TIM1_CCMR4_CC4S0 = (0)
                                    730 
                                    731 ; timer 1 break register bits 
                           000000   732 TIM1_BKR_LOCK=0 ;(0:1) lock configuration
                           000002   733 TIM1_BKR_OSSI=2 ; Off state selection for idle mode
                           000003   734 TIM1_BKR_OSSR=3 ; Off state selection for Run mode
                           000004   735 TIM1_BKR_BKE=4  ; Break enable
                           000005   736 TIM1_BKR_BKP=5  ; Break polarity
                           000006   737 TIM1_BKR_AOE=6  ; Automatic output enable
                           000007   738 TIM1_BKR_MOE=7  ; Main output enable
                                    739 
                                    740 ; timer 1 output idle state register bits 
                           000000   741 TIM1_OISR_OS1=0 
                           000001   742 TIM1_OISR_OSN1=1 
                           000002   743 TIM1_OISR_OS2=2 
                           000003   744 TIM1_OISR_OSN2=3 
                           000004   745 TIM1_OISR_OS3=4 
                           000005   746 TIM1_OISR_OSN3=5
                           000006   747 TIM1_OISR_OS4=6 
                           000007   748 TIM1_OISR_OSN4=7
                                    749 
                                    750 ; Timer 2 - 16-bit timer
                           005300   751  TIM2_CR1  = (0x5300)
                           005303   752  TIM2_IER  = (0x5303)
                           005304   753  TIM2_SR1  = (0x5304)
                           005305   754  TIM2_SR2  = (0x5305)
                           005306   755  TIM2_EGR  = (0x5306)
                           005307   756  TIM2_CCMR1  = (0x5307)
                           005308   757  TIM2_CCMR2  = (0x5308)
                           005309   758  TIM2_CCMR3  = (0x5309)
                           00530A   759  TIM2_CCER1  = (0x530A)
                           00530B   760  TIM2_CCER2  = (0x530B)
                           00530C   761  TIM2_CNTRH  = (0x530C)
                           00530D   762  TIM2_CNTRL  = (0x530D)
                           00530E   763  TIM2_PSCR  = (0x530E)
                           00530F   764  TIM2_ARRH  = (0x530F)
                           005310   765  TIM2_ARRL  = (0x5310)
                           005311   766  TIM2_CCR1H  = (0x5311)
                           005312   767  TIM2_CCR1L  = (0x5312)
                           005313   768  TIM2_CCR2H  = (0x5313)
                           005314   769  TIM2_CCR2L  = (0x5314)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                           005315   770  TIM2_CCR3H  = (0x5315)
                           005316   771  TIM2_CCR3L  = (0x5316)
                                    772 
                                    773 ; TIM2_CR1 bitfields
                           000000   774  TIM2_CR1_CEN=(0) ; Counter enable
                           000001   775  TIM2_CR1_UDIS=(1) ; Update disable
                           000002   776  TIM2_CR1_URS=(2) ; Update request source
                           000003   777  TIM2_CR1_OPM=(3) ; One-pulse mode
                           000007   778  TIM2_CR1_ARPE=(7) ; Auto-reload preload enable
                                    779 
                                    780 ; TIMER2_CCMR bitfields 
                           000000   781  TIM2_CCMR_CCS=(0) ; input/output select
                           000003   782  TIM2_CCMR_OCPE=(3) ; preload enable
                           000004   783  TIM2_CCMR_OCM=(4)  ; output compare mode 
                                    784 
                                    785 ; TIMER2_CCER1 bitfields
                           000000   786  TIM2_CCER1_CC1E=(0)
                           000001   787  TIM2_CCER1_CC1P=(1)
                           000004   788  TIM2_CCER1_CC2E=(4)
                           000005   789  TIM2_CCER1_CC2P=(5)
                                    790 
                                    791 ; TIMER2_EGR bitfields
                           000000   792  TIM2_EGR_UG=(0) ; update generation
                           000001   793  TIM2_EGR_CC1G=(1) ; Capture/compare 1 generation
                           000002   794  TIM2_EGR_CC2G=(2) ; Capture/compare 2 generation
                           000003   795  TIM2_EGR_CC3G=(3) ; Capture/compare 3 generation
                           000006   796  TIM2_EGR_TG=(6); Trigger generation
                                    797 
                                    798 ; Timer 4
                           005340   799  TIM4_CR1  = (0x5340)
                           005343   800  TIM4_IER  = (0x5343)
                           005344   801  TIM4_SR  = (0x5344)
                           005345   802  TIM4_EGR  = (0x5345)
                           005346   803  TIM4_CNTR  = (0x5346)
                           005347   804  TIM4_PSCR  = (0x5347)
                           005348   805  TIM4_ARR  = (0x5348)
                                    806 
                                    807 ; Timer 4 bitmasks
                                    808 
                           000007   809  TIM4_CR1_ARPE = (7)
                           000003   810  TIM4_CR1_OPM = (3)
                           000002   811  TIM4_CR1_URS = (2)
                           000001   812  TIM4_CR1_UDIS = (1)
                           000000   813  TIM4_CR1_CEN = (0)
                                    814 
                           000000   815  TIM4_IER_UIE = (0)
                                    816 
                           000000   817  TIM4_SR_UIF = (0)
                                    818 
                           000000   819  TIM4_EGR_UG = (0)
                                    820 
                           000002   821  TIM4_PSCR_PSC2 = (2)
                           000001   822  TIM4_PSCR_PSC1 = (1)
                           000000   823  TIM4_PSCR_PSC0 = (0)
                                    824 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                           000000   825  TIM4_PSCR_1 = 0
                           000001   826  TIM4_PSCR_2 = 1
                           000002   827  TIM4_PSCR_4 = 2
                           000003   828  TIM4_PSCR_8 = 3
                           000004   829  TIM4_PSCR_16 = 4
                           000005   830  TIM4_PSCR_32 = 5
                           000006   831  TIM4_PSCR_64 = 6
                           000007   832  TIM4_PSCR_128 = 7
                                    833 
                                    834 ; TIMx_CCMRx bit fields 
                           000004   835 TIMx_CCRM1_OC1M=4
                           000003   836 TIMx_CCRM1_OC1PE=3 
                           000000   837 TIMx_CCRM1_CC1S=0 
                                    838 
                                    839 ; ADC1 individual element access
                           0053E0   840  ADC1_DB0RH  = (0x53E0)
                           0053E1   841  ADC1_DB0RL  = (0x53E1)
                           0053E2   842  ADC1_DB1RH  = (0x53E2)
                           0053E3   843  ADC1_DB1RL  = (0x53E3)
                           0053E4   844  ADC1_DB2RH  = (0x53E4)
                           0053E5   845  ADC1_DB2RL  = (0x53E5)
                           0053E6   846  ADC1_DB3RH  = (0x53E6)
                           0053E7   847  ADC1_DB3RL  = (0x53E7)
                           0053E8   848  ADC1_DB4RH  = (0x53E8)
                           0053E9   849  ADC1_DB4RL  = (0x53E9)
                           0053EA   850  ADC1_DB5RH  = (0x53EA)
                           0053EB   851  ADC1_DB5RL  = (0x53EB)
                           0053EC   852  ADC1_DB6RH  = (0x53EC)
                           0053ED   853  ADC1_DB6RL  = (0x53ED)
                           0053EE   854  ADC1_DB7RH  = (0x53EE)
                           0053EF   855  ADC1_DB7RL  = (0x53EF)
                           0053F0   856  ADC1_DB8RH  = (0x53F0)
                           0053F1   857  ADC1_DB8RL  = (0x53F1)
                           0053F2   858  ADC1_DB9RH  = (0x53F2)
                           0053F3   859  ADC1_DB9RL  = (0x53F3)
                                    860 
                           005400   861  ADC1_CSR  = (0x5400)
                           005401   862  ADC1_CR1  = (0x5401)
                           005402   863  ADC1_CR2  = (0x5402)
                           005403   864  ADC1_CR3  = (0x5403)
                           005404   865  ADC1_DRH  = (0x5404)
                           005405   866  ADC1_DRL  = (0x5405)
                           005406   867  ADC1_TDRH  = (0x5406)
                           005407   868  ADC1_TDRL  = (0x5407)
                           005408   869  ADC1_HTRH  = (0x5408)
                           005409   870  ADC1_HTRL  = (0x5409)
                           00540A   871  ADC1_LTRH  = (0x540A)
                           00540B   872  ADC1_LTRL  = (0x540B)
                           00540C   873  ADC1_AWSRH  = (0x540C)
                           00540D   874  ADC1_AWSRL  = (0x540D)
                           00540E   875  ADC1_AWCRH  = (0x540E)
                           00540F   876  ADC1_AWCRL  = (0x540F)
                                    877 
                                    878 ; ADC1 bitmasks
                                    879 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           000007   880  ADC1_CSR_EOC = (7)
                           000006   881  ADC1_CSR_AWD = (6)
                           000005   882  ADC1_CSR_EOCIE = (5)
                           000004   883  ADC1_CSR_AWDIE = (4)
                           000003   884  ADC1_CSR_CH3 = (3)
                           000002   885  ADC1_CSR_CH2 = (2)
                           000001   886  ADC1_CSR_CH1 = (1)
                           000000   887  ADC1_CSR_CH0 = (0)
                                    888 
                           000006   889  ADC1_CR1_SPSEL2 = (6)
                           000005   890  ADC1_CR1_SPSEL1 = (5)
                           000004   891  ADC1_CR1_SPSEL0 = (4)
                           000001   892  ADC1_CR1_CONT = (1)
                           000000   893  ADC1_CR1_ADON = (0)
                                    894 
                           000006   895  ADC1_CR2_EXTTRIG = (6)
                           000005   896  ADC1_CR2_EXTSEL1 = (5)
                           000004   897  ADC1_CR2_EXTSEL0 = (4)
                           000003   898  ADC1_CR2_ALIGN = (3)
                           000001   899  ADC1_CR2_SCAN = (1)
                                    900 
                           000007   901  ADC1_CR3_DBUF = (7)
                           000006   902  ADC1_CR3_DRH = (6)
                                    903 
                                    904 ; CPU
                           007F00   905  CPU_A  = (0x7F00)
                           007F01   906  CPU_PCE  = (0x7F01)
                           007F02   907  CPU_PCH  = (0x7F02)
                           007F03   908  CPU_PCL  = (0x7F03)
                           007F04   909  CPU_XH  = (0x7F04)
                           007F05   910  CPU_XL  = (0x7F05)
                           007F06   911  CPU_YH  = (0x7F06)
                           007F07   912  CPU_YL  = (0x7F07)
                           007F08   913  CPU_SPH  = (0x7F08)
                           007F09   914  CPU_SPL   = (0x7F09)
                           007F0A   915  CPU_CCR   = (0x7F0A)
                                    916 
                                    917 ; global configuration register
                           007F60   918  CFG_GCR   = (0x7F60)
                                    919 
                                    920 ; interrupt control registers
                           007F70   921  ITC_SPR1   = (0x7F70)
                           007F71   922  ITC_SPR2   = (0x7F71)
                           007F72   923  ITC_SPR3   = (0x7F72)
                           007F73   924  ITC_SPR4   = (0x7F73)
                           007F74   925  ITC_SPR5   = (0x7F74)
                           007F75   926  ITC_SPR6   = (0x7F75)
                           007F76   927  ITC_SPR7   = (0x7F76)
                           007F77   928  ITC_SPR8   = (0x7F77)
                                    929 
                           000001   930 ITC_SPR_LEVEL1=1 
                           000000   931 ITC_SPR_LEVEL2=0
                           000003   932 ITC_SPR_LEVEL3=3 
                                    933 
                                    934 ; interrupt priority
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           000002   935  IPR0 = 2
                           000001   936  IPR1 = 1
                           000000   937  IPR2 = 0
                           000003   938  IPR3 = 3 
                           000003   939  IPR_MASK = 3
                                    940 
                                    941 ; SWIM, control and status register
                           007F80   942  SWIM_CSR   = (0x7F80)
                                    943 ; debug registers
                           007F90   944  DM_BK1RE   = (0x7F90)
                           007F91   945  DM_BK1RH   = (0x7F91)
                           007F92   946  DM_BK1RL   = (0x7F92)
                           007F93   947  DM_BK2RE   = (0x7F93)
                           007F94   948  DM_BK2RH   = (0x7F94)
                           007F95   949  DM_BK2RL   = (0x7F95)
                           007F96   950  DM_CR1   = (0x7F96)
                           007F97   951  DM_CR2   = (0x7F97)
                           007F98   952  DM_CSR1   = (0x7F98)
                           007F99   953  DM_CSR2   = (0x7F99)
                           007F9A   954  DM_ENFCTR   = (0x7F9A)
                                    955 
                                    956 ; Interrupt Numbers
                           000000   957  INT_TLI = 0
                           000001   958  INT_AWU = 1
                           000002   959  INT_CLK = 2
                           000003   960  INT_EXTI0 = 3
                           000004   961  INT_EXTI1 = 4
                           000005   962  INT_EXTI2 = 5
                           000006   963  INT_EXTI3 = 6
                           000007   964  INT_EXTI4 = 7
                           000008   965  INT_RES1 = 8
                           000009   966  INT_RES2 = 9
                           00000A   967  INT_SPI = 10
                           00000B   968  INT_TIM1_OVF = 11
                           00000C   969  INT_TIM1_CCM = 12
                           00000D   970  INT_TIM2_OVF = 13
                           00000E   971  INT_TIM2_CCM = 14
                           00000F   972  INT_RES3 = 15
                           000010   973  INT_RES4 = 16
                           000011   974  INT_UART1_TXC = 17
                           000012   975  INT_UART1_RX_FULL = 18
                           000013   976  INT_I2C = 19
                           000014   977  INT_RES5 = 20
                           000015   978  INT_RES6 = 21
                           000016   979  INT_ADC1 = 22
                           000017   980  INT_TIM4_OVF = 23
                           000018   981  INT_FLASH = 24
                                    982 
                                    983 ; Interrupt Vectors
                           008000   984  INT_VECTOR_RESET = 0x8000
                           008004   985  INT_VECTOR_TRAP = 0x8004
                           008008   986  INT_VECTOR_TLI = 0x8008
                           00800C   987  INT_VECTOR_AWU = 0x800C
                           008010   988  INT_VECTOR_CLK = 0x8010
                           008014   989  INT_VECTOR_EXTI0 = 0x8014
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                           008018   990  INT_VECTOR_EXTI1 = 0x8018
                           00801C   991  INT_VECTOR_EXTI2 = 0x801C
                           008020   992  INT_VECTOR_EXTI3 = 0x8020
                           008024   993  INT_VECTOR_EXTI4 = 0x8024
                           008030   994  INT_VECTOR_SPI = 0x8030
                           008034   995  INT_VECTOR_TIM1_OVF = 0x8034
                           008038   996  INT_VECTOR_TIM1_CCM = 0x8038
                           00803C   997  INT_VECTOR_TIM2_OVF = 0x803C
                           008040   998  INT_VECTOR_TIM2_CCM = 0x8040
                           00804C   999  INT_VECTOR_UART1_TX_COMPLETE = 0x804c
                           008050  1000  INT_VECTOR_UART1_RX_FULL = 0x8050
                           008054  1001  INT_VECTOR_I2C = 0x8054
                           008060  1002  INT_VECTOR_ADC1 = 0x8060
                           008064  1003  INT_VECTOR_TIM4_OVF = 0x8064
                           008068  1004  INT_VECTOR_FLASH = 0x8068
                                   1005 
                                   1006  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                                     65 	.include "inc/stm8s103f3_config.inc" 
                           005230     1 UART=UART1 
                           005230     2 UART_SR=UART1_SR 
                           005232     3 UART_BRR1=UART1_BRR1 
                           005233     4 UART_BRR2=UART1_BRR2
                           005235     5 UART_CR2=UART1_CR2 
                           005231     6 UART_DR=UART1_DR 
                           000003     7 UART_PCKEN=CLK_PCKENR1_UART1
                                      8 
                           005404     9 ADC_DRH=ADC1_DRH 
                           005405    10 ADC_DRL=ADC1_DRL 
                           005400    11 ADC_CSR=ADC1_CSR 
                           005401    12 ADC_CR1=ADC1_CR1 
                           005402    13 ADC_CR2=ADC1_CR2 
                           005403    14 ADC_CR3=ADC1_CR3 
                           000000    15 ADC_CR1_ADON=ADC1_CR1_ADON 
                           000003    16 ADC_CR2_ALIGN=ADC1_CR2_ALIGN
                           000007    17 ADC_CSR_EOC=ADC1_CSR_EOC  
                           000004    18 ADC_CHANNEL=4
                                     19 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                     66 .endif 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                                     67 	.include "inc/gen_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019 
                                      3 ; This file is part of STM8_NUCLEO 
                                      4 ;
                                      5 ;     STM8_NUCLEO is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     STM8_NUCLEO is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;--------------------------------------
                                     19 ;   console Input/Output module
                                     20 ;   DATE: 2019-12-11
                                     21 ;    
                                     22 ;   General usage macros.   
                                     23 ;
                                     24 ;--------------------------------------
                                     25 
                                     26     ; microseconds delay 
                                     27     .macro usec n, ?loop 
                                     28         ldw x,#4*n 
                                     29     loop:
                                     30         decw x 
                                     31         nop 
                                     32         jrne loop
                                     33     .endm 
                                     34 
                                     35     ; reserve space on stack
                                     36     ; for local variables
                                     37     .macro _vars n 
                                     38     sub sp,#n 
                                     39     .endm 
                                     40     
                                     41     ; free space on stack
                                     42     .macro _drop n 
                                     43     addw sp,#n 
                                     44     .endm
                                     45 
                                     46     ; declare ARG_OFS for arguments 
                                     47     ; displacement on stack. This 
                                     48     ; value depend on local variables 
                                     49     ; size.
                                     50     .macro _argofs n 
                                     51     ARG_OFS=2+n 
                                     52     .endm 
                                     53 
                                     54     ; declare a function argument 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                                     55     ; position relative to stack pointer 
                                     56     ; _argofs must be called before it.
                                     57     .macro _arg name ofs 
                                     58     name=ARG_OFS+ofs 
                                     59     .endm 
                                     60 
                                     61     ; increment zero page variable 
                                     62     .macro _incz v 
                                     63     .byte 0x3c, v 
                                     64     .endm 
                                     65 
                                     66     ; decrement zero page variable 
                                     67     .macro _decz v 
                                     68     .byte 0x3a,v 
                                     69     .endm 
                                     70 
                                     71     ; clear zero page variable 
                                     72     .macro _clrz v 
                                     73     .byte 0x3f, v 
                                     74     .endm 
                                     75 
                                     76     ; load A zero page variable 
                                     77     .macro _ldaz v 
                                     78     .byte 0xb6,v 
                                     79     .endm 
                                     80 
                                     81     ; store A zero page variable 
                                     82     .macro _straz v 
                                     83     .byte 0xb7,v 
                                     84     .endm 
                                     85 
                                     86     ; load x from variable in zero page 
                                     87     .macro _ldxz v 
                                     88     .byte 0xbe,v 
                                     89     .endm 
                                     90 
                                     91     ; load y from variable in zero page 
                                     92     .macro _ldyz v 
                                     93     .byte 0x90,0xbe,v 
                                     94     .endm 
                                     95 
                                     96     ; store x in zero page variable 
                                     97     .macro _strxz v 
                                     98     .byte 0xbf,v 
                                     99     .endm 
                                    100 
                                    101     ; store y in zero page variable 
                                    102     .macro _stryz v 
                                    103     .byte 0x90,0xbf,v 
                                    104     .endm 
                                    105 
                                    106     ;  increment 16 bits variable
                                    107     ;  use 10 bytes  
                                    108     .macro _incwz  v 
                                    109         _incz v+1   ; 1 cy, 2 bytes 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
Hexadecimal [24-Bits]



                                    110         jrne .+4  ; 1|2 cy, 2 bytes 
                                    111         _incz v     ; 1 cy, 2 bytes  
                                    112     .endm ; 3 cy 
                                    113 
                                    114     ; xor op with zero page variable 
                                    115     .macro _xorz v 
                                    116     .byte 0xb8,v 
                                    117     .endm 
                                    118     
                                    119     ; mov memory to memory page 0 
                                    120     .macro _movz m1,m2 
                                    121     .byte 0x45,m2,m1 
                                    122     .endm 
                                    123     
                                    124     ; software reset 
                                    125     .macro _swreset
                                    126     mov WWDG_CR,#0X80
                                    127     .endm 
                                    128 
                                    129 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
Hexadecimal [24-Bits]



                                     68 	.include "app_macros.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           00F424    19     TIM2_CLK_FREQ=62500
                                     20 
                                     21 ; boolean flags 
                           000007    22     F_GAME_TMR=7 ; game timer expired reset 
                           000006    23     F_SOUND_TMR=6 ; sound timer expired reset  
                           000005    24     F_DISP_MODE=5 ; display mode 0->text,1->graphic 
                                     25     
                                     26 ;--------------------------------------
                                     27 ;   assembler flags 
                                     28 ;-------------------------------------
                                     29 
                                     30     ; assume 16 Mhz Fcpu 
                                     31      .macro _usec_dly n 
                                     32     ldw x,#(16*n-2)/4 ; 2 cy 
                                     33     decw x  ; 1 cy 
                                     34     nop     ; 1 cy 
                                     35     jrne .-2 ; 2 cy 
                                     36     .endm 
                                     37 
                                     38 ;----------------------------------
                                     39 ; functions arguments access 
                                     40 ; from stack 
                                     41 ; caller push arguments before call
                                     42 ; and drop them after call  
                                     43 ;----------------------------------    
                                     44     ; get argument in X 
                                     45     .macro _get_arg n 
                                     46     ldw x,(2*(n+1),sp)
                                     47     .endm 
                                     48 
                                     49     ; store X in argument n 
                                     50     .macro _store_arg n 
                                     51     ldw (2*(n+1),sp),x 
                                     52     .endm 
                                     53 
                                     54     ; drop function arguments 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                     55     .macro _drop_args n 
                                     56     addw sp,#2*n
                                     57     .endm 
                                     58 
                                     59 
                                     60     ; read buttons 
                                     61     .macro _read_buttons
                                     62     ld a,#BTN_PORT+GPIO_IDR 
                                     63     and a,#ALL_KEY_UP
                                     64     .endm 
                                     65 
                                     66 
                                     67 ;-----------------------------
                                     68 ;   keypad macros 
                                     69 ;-----------------------------
                                     70 
                                     71     .macro _btn_down btn 
                                     72     ld a,BTN_IDR 
                                     73     and a,#(1<<btn)
                                     74     or a,#(1<<btn)
                                     75     .endm 
                                     76 
                                     77     .macro _btn_up 
                                     78     ld a,#BTN_IDR 
                                     79     and a,#(1<<btn)
                                     80     .endm 
                                     81 
                                     82     .macro _btn_state 
                                     83     ld a,#BTN_IDR 
                                     84     and a,#ALL_KEY_UP
                                     85     .endm 
                                     86 
                                     87     .macro _wait_key_release  ?loop 
                                     88     loop:
                                     89     ld a,BTN_IDR 
                                     90     and a,#ALL_KEY_UP 
                                     91     cp a,#ALL_KEY_UP 
                                     92     jrne loop 
                                     93     .endm 
                                     94 
                                     95 ;------------------------
                                     96 ; LED control 
                                     97 ;-----------------------
                                     98 
                                     99     .macro _led_on 
                                    100     bset LED_PORT+GPIO_ODR,#LED_BIT 
                                    101     .endm 
                                    102 
                                    103     .macro _led_off 
                                    104     bres LED_PORT+GPIO_ODR,#LED_BIT
                                    105     .endm 
                                    106 
                                    107     .macro _led_toggle 
                                    108     bcpl LED_PORT+GPIO_ODR,#LED_BIT
                                    109     .endm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                    110 
                                    111     
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                     69 
                                     70 
                                     71 
                                     72 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                     31 
                                     32 
                           000080    33 STACK_SIZE=128
                           0003FF    34 STACK_EMPTY=RAM_SIZE-1 
                           000080    35 DISPLAY_BUFFER_SIZE=128 ; horz pixels   
                                     36 
                                     37 ;;-----------------------------------
                                     38     .area SSEG (ABS)
                                     39 ;; working buffers and stack at end of RAM. 	
                                     40 ;;-----------------------------------
      00037E                         41     .org RAM_END - STACK_SIZE - 1
      00037E                         42 free_ram_end: 
      00037E                         43 stack_full: .ds STACK_SIZE   ; control stack 
      0003FE                         44 stack_unf: ; stack underflow ; control_stack bottom 
                                     45 
                                     46 ;;--------------------------------------
                                     47     .area HOME 
                                     48 ;; interrupt vector table at 0x8000
                                     49 ;;--------------------------------------
                                     50 
      008000 82 00 81 C6             51 	int cold_start	        ; reset
      008004 82 00 80 80             52 	int NonHandledInterrupt	; trap
      008008 82 00 80 80             53 	int NonHandledInterrupt	; irq0
      00800C 82 00 80 80             54 	int NonHandledInterrupt	; irq1
      008010 82 00 80 80             55 	int NonHandledInterrupt	; irq2
      008014 82 00 80 80             56 	int NonHandledInterrupt	; irq3
      008018 82 00 80 80             57 	int NonHandledInterrupt	; irq4
      00801C 82 00 80 80             58 	int NonHandledInterrupt	; irq5
      008020 82 00 80 80             59 	int NonHandledInterrupt	; irq6
      008024 82 00 80 80             60 	int NonHandledInterrupt	; irq7
      008028 82 00 80 80             61 	int NonHandledInterrupt	; irq8
      00802C 82 00 80 80             62 	int NonHandledInterrupt	; irq9
      008030 82 00 80 80             63 	int NonHandledInterrupt	; irq10
      008034 82 00 80 80             64 	int NonHandledInterrupt	; irq11
      008038 82 00 80 80             65 	int NonHandledInterrupt	; irq12
      00803C 82 00 80 80             66 	int NonHandledInterrupt	; irq13
      008040 82 00 80 80             67 	int NonHandledInterrupt	; irq14
      008044 82 00 80 80             68 	int NonHandledInterrupt	; irq15
      008048 82 00 80 80             69 	int NonHandledInterrupt	; irq16
      00804C 82 00 80 80             70 	int NonHandledInterrupt	; irq17
      008050 82 00 80 80             71 	int NonHandledInterrupt	; irq18
      008054 82 00 82 0B             72 	int I2cIntHandler  		; irq19
      008058 82 00 80 80             73 	int NonHandledInterrupt	; irq20
                           000001    74 .if DEBUG 
      00805C 82 00 8A C5             75 	int UartRxHandler   	; irq21
                           000000    76 .else 
                                     77 	int NonHandledInterrupt	; irq21
                                     78 .endif	
      008060 82 00 80 80             79 	int NonHandledInterrupt	; irq22
      008064 82 00 80 81             80 	int Timer4UpdateHandler ; irq23
      008068 82 00 80 80             81 	int NonHandledInterrupt	; irq24
      00806C 82 00 80 80             82 	int NonHandledInterrupt	; irq25
      008070 82 00 80 80             83 	int NonHandledInterrupt	; irq26
      008074 82 00 80 80             84 	int NonHandledInterrupt	; irq27
      008078 82 00 80 80             85 	int NonHandledInterrupt	; irq28
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



      00807C 82 00 80 80             86 	int NonHandledInterrupt	; irq29
                                     87 
                                     88 
                                     89 ;--------------------------------------
                                     90     .area DATA (ABS)
      000008                         91 	.org 8 
                                     92 ;--------------------------------------	
                                     93 
      000008                         94 ticks: .blkw 1 ; 1.664 milliseconds ticks counter (see Timer4UpdateHandler)
      00000A                         95 delay_timer: .blkb 1 ; 60 hertz timer   
      00000B                         96 sound_timer: .blkb 1 ; 60 hertz timer  
      00000C                         97 seedx: .blkw 1  ; xorshift 16 seed x  used by RND() function 
      00000E                         98 seedy: .blkw 1  ; xorshift 16 seed y  used by RND() funcion
      000010                         99 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000011                        100 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      000012                        101 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000013                        102 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      000014                        103 flags:: .blkb 1 ; various boolean flags
                                    104 ; i2c peripheral 
      000015                        105 i2c_buf: .blkw 1 ; i2c buffer address 
      000017                        106 i2c_count: .blkw 1 ; bytes to transmit 
      000019                        107 i2c_idx: .blkw 1 ; index in buffer
      00001B                        108 i2c_status: .blkb 1 ; error status 
      00001C                        109 i2c_devid: .blkb 1 ; device identifier  
                                    110 ;; OLED display 
      00001D                        111 line: .blkb 1 ; text line cursor position 
      00001E                        112 col: .blkb 1 ;  text column cursor position
      00001F                        113 cpl: .blkb 1 ; characters per line 
      000020                        114 disp_lines: .blkb 1 ; text lines per display  
      000021                        115 font_width: .blkb 1 ; character width in pixels 
      000022                        116 font_height: .blkb 1 ; character height in pixels 
      000023                        117 to_send: .blkb 1 ; bytes to send per character 
      000024                        118 disp_flags: .blkb 1 ; boolean flags 
                                    119 
                           000001   120 .if DEBUG 
                                    121 ; usart queue 
      000025                        122 rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
      000035                        123 rx1_head:  .blkb 1 ; rx1_queue head pointer
      000036                        124 rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
                                    125 ; transaction input buffer 
      000037                        126 tib: .ds TIB_SIZE
      00005F                        127 count: .blkb 1 ; character count in tib  
                                    128 .endif ; DEBUG 
                                    129 
      000100                        130 	.org 0x100
      000100                        131 co_code: .blkb 1	
      000101                        132 disp_buffer: .ds DISPLAY_BUFFER_SIZE ; oled display page buffer 
                                    133 
      000181                        134 free_ram: ; from here RAM free up to free_ram_end 
                                    135 
                                    136 
                                    137 	.area CODE 
                                    138 
                                    139 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    140 ; non handled interrupt 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



                                    141 ; reset MCU
                                    142 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        143 NonHandledInterrupt:
      008080 80               [11]  144 	iret 
                                    145 
                                    146 ;------------------------------
                                    147 ; TIMER 4 is used to maintain 
                                    148 ; timers and ticks 
                                    149 ; interrupt interval is 1.664 msec 
                                    150 ;--------------------------------
      008081                        151 Timer4UpdateHandler:
      008081 72 5F 53 44      [ 1]  152 	clr TIM4_SR 
      000005                        153 	_ldxz ticks
      008085 BE 08                    1     .byte 0xbe,ticks 
      008087 5C               [ 1]  154 	incw x 
      000008                        155 	_strxz ticks
      008088 BF 08                    1     .byte 0xbf,ticks 
                                    156 ; decrement delay_timer and sound_timer on ticks mod 10==0
      00808A A6 0A            [ 1]  157 	ld a,#10
      00808C 62               [ 2]  158 	div x,a 
      00808D 4D               [ 1]  159 	tnz a
      00808E 26 1E            [ 1]  160 	jrne 9$
      008090                        161 1$:	 
      008090 72 0F 00 14 0A   [ 2]  162 	btjf flags,#F_GAME_TMR,2$  
      008095 72 5A 00 0A      [ 1]  163 	dec delay_timer 
      008099 26 04            [ 1]  164 	jrne 2$ 
      00809B 72 1F 00 14      [ 1]  165 	bres flags,#F_GAME_TMR  
      00809F                        166 2$:
      00809F 72 0D 00 14 0A   [ 2]  167 	btjf flags,#F_SOUND_TMR,9$
      0080A4 72 5A 00 0B      [ 1]  168 	dec sound_timer 
      0080A8 26 04            [ 1]  169 	jrne 9$ 
      0080AA 72 1D 00 14      [ 1]  170 	bres flags,#F_SOUND_TMR
      0080AE                        171 9$:
      0080AE 80               [11]  172 	iret 
                                    173 
                                    174 
                                    175 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    176 ;    peripherals initialization
                                    177 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    178 
                                    179 ;----------------------------------------
                                    180 ; inialize MCU clock 
                                    181 ; HSI no divisor 
                                    182 ; FMSTR=16Mhz 
                                    183 ;----------------------------------------
      0080AF                        184 clock_init:	
      0080AF 72 5F 50 C6      [ 1]  185 	clr CLK_CKDIVR 
      0080B3 81               [ 4]  186 	ret
                                    187 
                                    188 ;---------------------------------
                                    189 ; TIM4 is configured to generate an 
                                    190 ; interrupt every 1.66 millisecond 
                                    191 ;----------------------------------
      0080B4                        192 timer4_init:
      0080B4 72 18 50 C7      [ 1]  193 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



      0080B8 72 11 53 40      [ 1]  194 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080BC 35 07 53 47      [ 1]  195 	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
      0080C0 35 83 53 48      [ 1]  196 	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
      0080C4 35 05 53 40      [ 1]  197 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080C8 72 10 53 43      [ 1]  198 	bset TIM4_IER,#TIM4_IER_UIE
                                    199 ; set int level to 1 
                           000000   200 .if 0
                                    201 	ld a,#ITC_SPR_LEVEL1 
                                    202 	ldw x,#INT_TIM4_OVF 
                                    203 	call set_int_priority
                                    204 	bres flags,#F_GAME_TMR
                                    205 	bres flags,#F_SOUND_TMR 
                                    206 .endif 
      0080CC 81               [ 4]  207 	ret
                                    208 
                                    209 ;----------------------------------
                                    210 ; TIMER2 used as audio tone output 
                                    211 ; on port D:4. CN3-13
                                    212 ; channel 1 configured as PWM mode 1 
                                    213 ;-----------------------------------  
      0080CD                        214 timer2_init:
      0080CD 72 1A 50 C7      [ 1]  215 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM2 ; enable TIMER2 clock 
      0080D1 35 60 53 07      [ 1]  216  	mov TIM2_CCMR1,#(6<<TIM2_CCMR_OCM) ; PWM mode 1 
      0080D5 35 08 53 0E      [ 1]  217 	mov TIM2_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
      0080D9 72 10 53 00      [ 1]  218 	bset TIM2_CR1,#TIM2_CR1_CEN
      0080DD 72 11 53 0A      [ 1]  219 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      0080E1 81               [ 4]  220 	ret 
                                    221 
                           000000   222 .if 0
                                    223 ;--------------------------
                                    224 ; set software interrupt 
                                    225 ; priority 
                                    226 ; input:
                                    227 ;   A    priority 1,2,3 
                                    228 ;   X    vector 
                                    229 ;---------------------------
                                    230 	SPR_ADDR=1 
                                    231 	PRIORITY=3
                                    232 	SLOT=4
                                    233 	MASKED=5  
                                    234 	VSIZE=5
                                    235 set_int_priority::
                                    236 	_vars VSIZE
                                    237 	and a,#3  
                                    238 	ld (PRIORITY,sp),a 
                                    239 	ld a,#4 
                                    240 	div x,a 
                                    241 	sll a  ; slot*2 
                                    242 	ld (SLOT,sp),a
                                    243 	addw x,#ITC_SPR1 
                                    244 	ldw (SPR_ADDR,sp),x 
                                    245 ; build mask
                                    246 	ldw x,#0xfffc 	
                                    247 	ld a,(SLOT,sp)
                                    248 	jreq 2$ 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                    249 	scf 
                                    250 1$:	rlcw x 
                                    251 	dec a 
                                    252 	jrne 1$
                                    253 2$:	ld a,xl 
                                    254 ; apply mask to slot 
                                    255 	ldw x,(SPR_ADDR,sp)
                                    256 	and a,(x)
                                    257 	ld (MASKED,sp),a 
                                    258 ; shift priority to slot 
                                    259 	ld a,(PRIORITY,sp)
                                    260 	ld xl,a 
                                    261 	ld a,(SLOT,sp)
                                    262 	jreq 4$
                                    263 3$:	sllw x 
                                    264 	dec a 
                                    265 	jrne 3$
                                    266 4$:	ld a,xl 
                                    267 	or a,(MASKED,sp)
                                    268 	ldw x,(SPR_ADDR,sp)
                                    269 	ld (x),a 
                                    270 	_drop VSIZE 
                                    271 	ret
                                    272 .endif ;DEBUG 
                                    273 
                                    274 ;------------------------
                                    275 ; suspend execution 
                                    276 ; input:
                                    277 ;   A     n/60 seconds  
                                    278 ;-------------------------
      0080E2                        279 pause:
      000062                        280 	_straz delay_timer 
      0080E2 B7 0A                    1     .byte 0xb7,delay_timer 
      0080E4 72 1E 00 14      [ 1]  281 	bset flags,#F_GAME_TMR 
      0080E8 8F               [10]  282 1$: wfi 	
      0080E9 72 0E 00 14 FA   [ 2]  283 	btjt flags,#F_GAME_TMR,1$ 
      0080EE 81               [ 4]  284 	ret 
                                    285 
                                    286 ;--------------------------
                                    287 ; sound timer blocking 
                                    288 ; delay 
                                    289 ; input:
                                    290 ;   A    n*10 msec
                                    291 ;--------------------------
      0080EF                        292 sound_pause:
      00006F                        293 	_straz sound_timer  
      0080EF B7 0B                    1     .byte 0xb7,sound_timer 
      0080F1 72 1C 00 14      [ 1]  294 	bset flags,#F_SOUND_TMR 
      0080F5 8F               [10]  295 1$: wfi 
      0080F6 72 0C 00 14 FA   [ 2]  296 	btjt flags,#F_SOUND_TMR,1$
      0080FB 72 11 53 00      [ 1]  297 	bres TIM2_CR1,#TIM2_CR1_CEN 
      0080FF 72 11 53 0A      [ 1]  298 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      008103 72 10 53 06      [ 1]  299 	bset TIM2_EGR,#TIM2_EGR_UG
      008107 81               [ 4]  300 9$:	ret 
                                    301 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                    302 ;-----------------------
                                    303 ; tone generator 
                                    304 ; Ft2clk=62500 hertz 
                                    305 ; input:
                                    306 ;   A   duration n*10 msec    
                                    307 ;   X   frequency 
                                    308 ;------------------------
                           00F424   309 FR_T2_CLK=62500
      008108                        310 tone:
      008108 90 89            [ 2]  311 	pushw y 
      00810A 88               [ 1]  312 	push a 
      00810B 90 93            [ 1]  313 	ldw y,x 
      00810D AE F4 24         [ 2]  314 	ldw x,#FR_T2_CLK 
      008110 65               [ 2]  315 	divw x,y 
      008111 9E               [ 1]  316 	ld a,xh 
      008112 C7 53 0F         [ 1]  317 	ld TIM2_ARRH,a 
      008115 9F               [ 1]  318 	ld a,xl 
      008116 C7 53 10         [ 1]  319 	ld TIM2_ARRL,a 
      008119 54               [ 2]  320 	srlw x 
      00811A 9E               [ 1]  321 	ld a,xh 
      00811B C7 53 11         [ 1]  322 	ld TIM2_CCR1H,a 
      00811E 9F               [ 1]  323 	ld a,xl 
      00811F C7 53 12         [ 1]  324 	ld TIM2_CCR1L,a 
      008122 72 10 53 0A      [ 1]  325 	bset TIM2_CCER1,#TIM2_CCER1_CC1E
      008126 72 10 53 00      [ 1]  326 	bset TIM2_CR1,#TIM2_CR1_CEN 
      00812A 84               [ 1]  327 	pop a 
      00812B CD 80 EF         [ 4]  328 	call sound_pause 
      00812E 90 85            [ 2]  329 	popw y 
      008130 81               [ 4]  330 	ret 
                                    331 
                                    332 ;-----------------
                                    333 ; 1Khz beep 
                                    334 ;-----------------
      008131                        335 beep:
      008131 AE 03 E8         [ 2]  336 	ldw x,#1000 ; hertz 
      008134 A6 14            [ 1]  337 	ld a,#20
      008136 CD 81 08         [ 4]  338 	call tone  
      008139 81               [ 4]  339 	ret 
                                    340 
                           000001   341 .if DEBUG 
                                    342 ;---------------------------------
                                    343 ; Pseudo Random Number Generator 
                                    344 ; XORShift algorithm.
                                    345 ;---------------------------------
                                    346 
                                    347 ;---------------------------------
                                    348 ;  seedx:seedy= x:y ^ seedx:seedy
                                    349 ; output:
                                    350 ;  X:Y   seedx:seedy new value   
                                    351 ;---------------------------------
      00813A                        352 xor_seed32:
      00813A 9E               [ 1]  353     ld a,xh 
      0000BB                        354     _xorz seedx 
      00813B B8 0C                    1     .byte 0xb8,seedx 
      0000BD                        355     _straz seedx
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



      00813D B7 0C                    1     .byte 0xb7,seedx 
      00813F 9F               [ 1]  356     ld a,xl 
      0000C0                        357     _xorz seedx+1 
      008140 B8 0D                    1     .byte 0xb8,seedx+1 
      0000C2                        358     _straz seedx+1 
      008142 B7 0D                    1     .byte 0xb7,seedx+1 
      008144 90 9E            [ 1]  359     ld a,yh 
      0000C6                        360     _xorz seedy
      008146 B8 0E                    1     .byte 0xb8,seedy 
      0000C8                        361     _straz seedy 
      008148 B7 0E                    1     .byte 0xb7,seedy 
      00814A 90 9F            [ 1]  362     ld a,yl 
      0000CC                        363     _xorz seedy+1 
      00814C B8 0F                    1     .byte 0xb8,seedy+1 
      0000CE                        364     _straz seedy+1 
      00814E B7 0F                    1     .byte 0xb7,seedy+1 
      0000D0                        365     _ldxz seedx  
      008150 BE 0C                    1     .byte 0xbe,seedx 
      0000D2                        366     _ldyz seedy 
      008152 90 BE 0E                 1     .byte 0x90,0xbe,seedy 
      008155 81               [ 4]  367     ret 
                                    368 
                                    369 ;-----------------------------------
                                    370 ;   x:y= x:y << a 
                                    371 ;  input:
                                    372 ;    A     shift count 
                                    373 ;    X:Y   uint32 value 
                                    374 ;  output:
                                    375 ;    X:Y   uint32 shifted value   
                                    376 ;-----------------------------------
      008156                        377 sll_xy_32: 
      008156 90 58            [ 2]  378     sllw y 
      008158 59               [ 2]  379     rlcw x
      008159 4A               [ 1]  380     dec a 
      00815A 26 FA            [ 1]  381     jrne sll_xy_32 
      00815C 81               [ 4]  382     ret 
                                    383 
                                    384 ;-----------------------------------
                                    385 ;   x:y= x:y >> a 
                                    386 ;  input:
                                    387 ;    A     shift count 
                                    388 ;    X:Y   uint32 value 
                                    389 ;  output:
                                    390 ;    X:Y   uint32 shifted value   
                                    391 ;-----------------------------------
      00815D                        392 srl_xy_32: 
      00815D 54               [ 2]  393     srlw x 
      00815E 90 56            [ 2]  394     rrcw y 
      008160 4A               [ 1]  395     dec a 
      008161 26 FA            [ 1]  396     jrne srl_xy_32 
      008163 81               [ 4]  397     ret 
                                    398 
                                    399 ;-------------------------------------
                                    400 ;  PRNG generator proper 
                                    401 ; input:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



                                    402 ;   none 
                                    403 ; ouput:
                                    404 ;   X     bits 31...16  PRNG seed  
                                    405 ;  use: 
                                    406 ;   seedx:seedy   system variables   
                                    407 ;--------------------------------------
      008164                        408 prng::
      008164 90 89            [ 2]  409 	pushw y   
      0000E6                        410     _ldxz seedx
      008166 BE 0C                    1     .byte 0xbe,seedx 
      0000E8                        411 	_ldyz seedy  
      008168 90 BE 0E                 1     .byte 0x90,0xbe,seedy 
      00816B A6 0D            [ 1]  412 	ld a,#13
      00816D CD 81 56         [ 4]  413     call sll_xy_32 
      008170 CD 81 3A         [ 4]  414     call xor_seed32
      008173 A6 11            [ 1]  415     ld a,#17 
      008175 CD 81 5D         [ 4]  416     call srl_xy_32
      008178 CD 81 3A         [ 4]  417     call xor_seed32 
      00817B A6 05            [ 1]  418     ld a,#5 
      00817D CD 81 56         [ 4]  419     call sll_xy_32
      008180 CD 81 3A         [ 4]  420     call xor_seed32
      008183 90 85            [ 2]  421     popw y 
      008185 81               [ 4]  422     ret 
                                    423 
                                    424 
                                    425 ;---------------------------------
                                    426 ; initialize seedx:seedy 
                                    427 ; input:
                                    428 ;    X    0 -> seedx=ticks, seedy=tib[0..1] 
                                    429 ;    X    !0 -> seedx=X, seedy=[0x60<<8|XL]
                                    430 ;-------------------------------------------
      008186                        431 set_seed:
      008186 5D               [ 2]  432     tnzw x 
      008187 26 0B            [ 1]  433     jrne 1$ 
      008189 CE 00 08         [ 2]  434     ldw x,ticks 
      00010C                        435     _strxz seedx
      00818C BF 0C                    1     .byte 0xbf,seedx 
      00818E CE 01 01         [ 2]  436     ldw x,disp_buffer  
      000111                        437     _strxz seedy  
      008191 BF 0E                    1     .byte 0xbf,seedy 
      008193 81               [ 4]  438     ret 
      008194                        439 1$:  
      000114                        440     _strxz seedx
      008194 BF 0C                    1     .byte 0xbf,seedx 
      000116                        441     _clrz seedy 
      008196 3F 0E                    1     .byte 0x3f, seedy 
      000118                        442     _clrz seedy+1
      008198 3F 0F                    1     .byte 0x3f, seedy+1 
      00819A 81               [ 4]  443     ret 
                                    444 
                                    445 ;----------------------------
                                    446 ;  read keypad 
                                    447 ; output:
                                    448 ;    A    keypress|0
                                    449 ;----------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



      00819B                        450 key:
      00819B C6 50 0B         [ 1]  451 	ld a,BTN_IDR 
      00819E A4 BE            [ 1]  452 	and a,#ALL_KEY_UP
      0081A0 81               [ 4]  453     ret 
                                    454 
                                    455 ;----------------------------
                                    456 ; wait for key press 
                                    457 ; output:
                                    458 ;    A    key 
                                    459 ;----------------------------
                           000001   460 	KPAD=1
      0081A1                        461 wait_key:
      0081A1 4B BE            [ 1]  462 	push #ALL_KEY_UP 
      0081A3                        463 1$:	
      0081A3 C6 50 0B         [ 1]  464 	ld a,BTN_IDR 
      0081A6 A4 BE            [ 1]  465 	and a,#ALL_KEY_UP 
      0081A8 A1 BE            [ 1]  466 	cp a,#ALL_KEY_UP
      0081AA 27 F7            [ 1]  467 	jreq 1$
      0081AC 6B 01            [ 1]  468 	ld (KPAD,sp),a  
                                    469 ; debounce
      0081AE 35 02 00 0A      [ 1]  470 	mov delay_timer,#2
      0081B2 72 1E 00 14      [ 1]  471 	bset flags,#F_GAME_TMR
      0081B6 C6 50 0B         [ 1]  472 2$: ld a,BTN_IDR 
      0081B9 A4 BE            [ 1]  473 	and a,#ALL_KEY_UP 
      0081BB 11 01            [ 1]  474 	cp a,(KPAD,sp)
      0081BD 26 E4            [ 1]  475 	jrne 1$
      0081BF 72 0E 00 14 F2   [ 2]  476 	btjt flags,#F_GAME_TMR,2$ 
      0081C4 84               [ 1]  477 	pop a  
      0081C5 81               [ 4]  478 	ret 
                                    479 .endif ; DEBUG 
                                    480 
                                    481 ;-------------------------------------
                                    482 ;  initialization entry point 
                                    483 ;-------------------------------------
      0081C6                        484 cold_start:
                                    485 ;set stack 
      0081C6 AE 03 FF         [ 2]  486 	ldw x,#STACK_EMPTY
      0081C9 94               [ 1]  487 	ldw sp,x
                                    488 ; clear all ram 
      0081CA 7F               [ 1]  489 0$: clr (x)
      0081CB 5A               [ 2]  490 	decw x 
      0081CC 26 FC            [ 1]  491 	jrne 0$
      0081CE CD 80 AF         [ 4]  492     call clock_init 
                           000001   493 .if DEBUG 
                                    494 ; set pull up on PC_IDR (buttons input)
      0081D1 72 5F 50 0C      [ 1]  495 	cLr BTN_PORT+GPIO_DDR
      0081D5 35 FF 50 0D      [ 1]  496 	mov BTN_PORT+GPIO_CR1,#255
                                    497 .endif ; DEBUG 
                                    498 ; set sound output 	
      0081D9 72 18 50 11      [ 1]  499 	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT 
      0081DD 72 18 50 12      [ 1]  500 	bset SOUND_PORT+GPIO_CR1,#SOUND_BIT 
                                    501 ; led output 
      0081E1 72 14 50 11      [ 1]  502 	bset LED_PORT+GPIO_DDR,#LED_BIT 
      0081E5 72 14 50 12      [ 1]  503 	bset LED_PORT+GPIO_CR1,#LED_BIT
      000169                        504 	_led_off 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



      0081E9 72 15 50 0F      [ 1]    1     bres LED_PORT+GPIO_ODR,#LED_BIT
                           000001   505 .if DEBUG 
      0081ED CD 8A F6         [ 4]  506 	call uart_init 
                                    507 .endif ;DEBUG 	
      0081F0 CD 80 B4         [ 4]  508 	call timer4_init ; msec ticks timer 
      0081F3 CD 80 CD         [ 4]  509 	call timer2_init ; tone generator 
      0081F6 A6 01            [ 1]  510 	ld a,#I2C_FAST   
      0081F8 CD 83 29         [ 4]  511 	call i2c_init 
      0081FB 9A               [ 1]  512 	rim ; enable interrupts
                           000001   513 .if DEBUG 
                                    514 ; RND function seed 
                                    515 ; must be initialized 
                                    516 ; to value other than 0.
                                    517 ; take values from FLASH space 
      0081FC AE 82 0B         [ 2]  518 	ldw x,#I2cIntHandler
      0081FF CF 00 0E         [ 2]  519 	ldw seedy,x  
      008202 AE 8B 26         [ 2]  520 	ldw x,#app 
      008205 CF 00 0C         [ 2]  521 	ldw seedx,x  	
                                    522 .endif ; DEBUG 
      008208 CC 8B 26         [ 2]  523 	jp app 
                                    524 
                                    525 
                                    526 
                                    527 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------------
                                     20 ;    I2C macros 
                                     21 ;-------------------------------------
                                     22     .macro _i2c_stop 
                                     23     bset I2C_CR2,#I2C_CR2_STOP
                                     24     .endm 
                                     25 
                                     26 ;--------------------------------
                                     27 ;  I2C peripheral driver 
                                     28 ;  Support only 7 bit addressing 
                                     29 ;  and master mode 
                                     30 ;--------------------------------
                                     31 
                           000007    32 I2C_STATUS_DONE=7 ; bit 7 of i2c_status indicate operation completed  
                           000006    33 I2C_STATUS_NO_STOP=6 ; don't send a stop at end of transmission
                                     34 
                                     35 
                                     36 ;------------------------------
                                     37 ; i2c global interrupt handler
                                     38 ;------------------------------
      00820B                         39 I2cIntHandler:
      00820B C6 52 18         [ 1]   40     ld a, I2C_SR2 ; errors status 
      00820E 72 5F 52 18      [ 1]   41     clr I2C_SR2 
      008212 A4 0F            [ 1]   42     and a,#15 
      008214 27 0A            [ 1]   43     jreq 1$
      008216 CA 00 1B         [ 1]   44     or a,i2c_status 
      000199                         45     _straz i2c_status 
      008219 B7 1B                    1     .byte 0xb7,i2c_status 
      00821B 72 12 52 11      [ 1]   46     bset I2C_CR2,#I2C_CR2_STOP
      00821F 80               [11]   47     iret 
      008220                         48 1$: ; no error detected 
      008220 72 0F 00 1B 05   [ 2]   49     btjf i2c_status,#I2C_STATUS_DONE,2$
      008225 72 5F 52 1A      [ 1]   50     clr I2C_ITR 
      008229 80               [11]   51     iret 
                                     52 ; handle events 
      0001AA                         53 2$: _ldxz i2c_idx  
      00822A BE 19                    1     .byte 0xbe,i2c_idx 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



      00822C 72 00 52 17 1A   [ 2]   54     btjt I2C_SR1,#I2C_SR1_SB,evt_sb 
      008231 72 02 52 17 1B   [ 2]   55     btjt I2C_SR1,#I2C_SR1_ADDR,evt_addr 
      008236 72 04 52 17 31   [ 2]   56     btjt I2C_SR1,#I2C_SR1_BTF,evt_btf  
      00823B 72 0E 52 17 17   [ 2]   57     btjt I2C_SR1,#I2C_SR1_TXE,evt_txe 
      008240 72 0C 52 17 40   [ 2]   58     btjt I2C_SR1,#I2C_SR1_RXNE,evt_rxne 
      008245 72 08 52 17 56   [ 2]   59     btjt I2C_SR1,#I2C_SR1_STOPF,evt_stopf 
      00824A 80               [11]   60     iret 
                                     61 
      00824B                         62 evt_sb: ; EV5  start bit sent 
      0001CB                         63     _ldaz i2c_devid
      00824B B6 1C                    1     .byte 0xb6,i2c_devid 
      00824D C7 52 16         [ 1]   64     ld I2C_DR,a ; send device address 
      008250 80               [11]   65     iret 
                                     66 
      008251                         67 evt_addr: ; EV6  address sent, send data bytes  
      008251 72 04 52 19 01   [ 2]   68     btjt I2C_SR3,#I2C_SR3_TRA,evt_txe
      008256 80               [11]   69     iret 
                                     70 
                                     71 ; master transmit mode 
      008257                         72 evt_txe: ; EV8  send data byte 
      0001D7                         73     _ldyz i2c_count 
      008257 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      00825A 27 1C            [ 1]   74     jreq end_of_tx 
      00825C                         75 evt_txe_1:
      00825C 72 D6 00 15      [ 4]   76     ld a,([i2c_buf],x)
      008260 C7 52 16         [ 1]   77     ld I2C_DR,a
      008263 5C               [ 1]   78     incw x 
      0001E4                         79     _strxz i2c_idx 
      008264 BF 19                    1     .byte 0xbf,i2c_idx 
      008266 90 5A            [ 2]   80     decw y  
      0001E8                         81     _stryz i2c_count  
      008268 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      00826B 80               [11]   82 1$: iret 
                                     83 
                                     84 ; only append if no STOP send 
      00826C                         85 evt_btf: 
      00826C 72 05 52 19 14   [ 2]   86     btjf I2C_SR3,#I2C_SR3_TRA,#evt_rxne  
      0001F1                         87     _ldyz i2c_count 
      008271 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      008274 26 E6            [ 1]   88     jrne evt_txe_1 
      008276 20 00            [ 2]   89     jra end_of_tx 
                                     90 
                                     91 ; end of transmission
      008278                         92 end_of_tx:
      008278 72 1E 00 1B      [ 1]   93     bset i2c_status,#I2C_STATUS_DONE  
                                     94 ;    btjt i2c_status,#I2C_STATUS_NO_STOP,1$
      00827C 72 12 52 11      [ 1]   95     bset I2C_CR2,#I2C_CR2_STOP
      008280 72 5F 52 1A      [ 1]   96 1$: clr I2C_ITR
      008284 80               [11]   97     iret 
                                     98 
                                     99 ; master receive mode 
      008285                        100 evt_rxne: 
      000205                        101     _ldyz i2c_count 
      008285 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      008288 27 16            [ 1]  102     jreq evt_stopf  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



      00828A C6 52 16         [ 1]  103 1$: ld a,I2C_DR 
      00828D 72 D7 00 15      [ 4]  104     ld ([i2c_buf],x),a  
      008291 5C               [ 1]  105     incw x 
      000212                        106     _strxz i2c_idx 
      008292 BF 19                    1     .byte 0xbf,i2c_idx 
      008294 90 5A            [ 2]  107     decw y 
      000216                        108     _stryz i2c_count
      008296 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      008299 26 04            [ 1]  109     jrne 4$
      00829B 72 15 52 11      [ 1]  110     bres I2C_CR2,#I2C_CR2_ACK
      00829F 80               [11]  111 4$: iret 
                                    112 
      0082A0                        113 evt_stopf:
      0082A0 C6 52 16         [ 1]  114     ld a,I2C_DR 
      0082A3 72 D7 00 15      [ 4]  115     ld ([i2c_buf],x),a 
      0082A7 72 12 52 11      [ 1]  116     bset I2C_CR2,#I2C_CR2_STOP
      0082AB 72 1E 00 1B      [ 1]  117     bset i2c_status,#I2C_STATUS_DONE
      0082AF 72 5F 52 1A      [ 1]  118     clr I2C_ITR 
      0082B3 80               [11]  119     iret  
                                    120 
                                    121 ; error message 
                           000000   122 I2C_ERR_NONE=0 
                           000001   123 I2C_ERR_NO_ACK=1 ; no ack received 
                           000002   124 I2C_ERR_OVR=2 ; overrun 
                           000003   125 I2C_ERR_ARLO=3 ; arbitration lost 
                           000004   126 I2C_ERR_BERR=4 ; bus error 
                           000005   127 I2C_ERR_TIMEOUT=5 ; operation time out 
                                    128 ;---------------------------
                                    129 ; display error message 
                                    130 ; blink error code on LED
                                    131 ; in binary format 
                                    132 ; most significant bit first 
                                    133 ; 0 -> 100msec blink
                                    134 ; 1 -> 300msec blink 
                                    135 ; space -> 100msec LED off 
                                    136 ; inter code -> 500msec LED off
                                    137 ;---------------------------
      0082B4                        138 i2c_error:
      000234                        139     _ldaz i2c_status 
      0082B4 B6 1B                    1     .byte 0xb6,i2c_status 
      0082B6 4E               [ 1]  140     swap a 
      0082B7 C7 00 11         [ 1]  141     ld acc8,a 
      0082BA 4B 04            [ 1]  142     push #4 
      0082BC                        143 nibble_loop:     
      0082BC A6 0C            [ 1]  144     ld a,#12 
      0082BE CD 81 31         [ 4]  145     call beep 
      0082C1 72 58 00 11      [ 1]  146     sll acc8  
      0082C5 25 05            [ 1]  147     jrc blink1 
      0082C7                        148 blink0:
      0082C7 AE 00 C8         [ 2]  149     ldw x,#200
      0082CA 20 03            [ 2]  150     jra blink
      0082CC                        151 blink1: 
      0082CC AE 02 58         [ 2]  152     ldw x,#600 
      0082CF                        153 blink:
      0082CF CD 80 E2         [ 4]  154     call pause 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



      0082D2 4F               [ 1]  155     clr a 
      0082D3 CD 81 31         [ 4]  156     call beep  
      0082D6 AE 00 C8         [ 2]  157     ldw x,#200 
      0082D9 CD 80 E2         [ 4]  158     call pause 
      0082DC 0A 01            [ 1]  159     dec (1,sp)
      0082DE 26 DC            [ 1]  160     jrne nibble_loop 
      0082E0 84               [ 1]  161     pop a 
      0082E1 AE 02 BC         [ 2]  162     ldw x,#700 
      0082E4 CD 80 E2         [ 4]  163     call pause 
      0082E7 20 CB            [ 2]  164 jra i2c_error     
      0082E9 81               [ 4]  165     ret  
                                    166 
                           000000   167 .if 0
                                    168 ;----------------------------
                                    169 ; set_i2c_params(devid,count,buf_addr,no_stop)
                                    170 ; set i2c operation parameters  
                                    171 ; 
                                    172 ; devid: BYTE 
                                    173 ;     7 bit device identifier 
                                    174 ;
                                    175 ; count: BYTE 
                                    176 ;     bytes to send|receive
                                    177 ;
                                    178 ; buf_addr: WORD 
                                    179 ;     pointer to buffer 
                                    180 ;  
                                    181 ; no_stop:  BYTE 
                                    182 ;     0   set STOP bit at end 
                                    183 ;     1   don't set STOP bit 
                                    184 ;---------------------------
                                    185     ARGCOUNT=4 
                                    186 i2c_set_params: ; (stop_cond buf_addr count devid -- )
                                    187     clr i2c_status  
                                    188 1$: _get_arg 0 ; no_stop 
                                    189     jreq 2$
                                    190     bset i2c_status,#I2C_STATUS_NO_STOP
                                    191 2$: _get_arg 1 ; buf_addr 
                                    192     ldw i2c_buf,x 
                                    193     _get_arg 2 ; count 
                                    194     _strxz i2c_count 
                                    195     _get_arg 3 ; devid 
                                    196     ld a,xl 
                                    197     _straz i2c_devid 
                                    198     ret 
                                    199 .endif 
                                    200 
                                    201 ;--------------------------------
                                    202 ; write bytes to i2c device 
                                    203 ; devid:  device identifier 
                                    204 ; count: of bytes to write 
                                    205 ; buf_addr: address of bytes buffer 
                                    206 ; no_stop: dont't send a stop
                                    207 ;---------------------------------
      0082EA                        208 i2c_write:
      0082EA 72 00 52 19 FB   [ 2]  209     btjt I2C_SR3,#I2C_SR3_MSL,.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



      0082EF 5F               [ 1]  210     clrw x 
      000270                        211     _strxz i2c_idx 
      0082F0 BF 19                    1     .byte 0xbf,i2c_idx 
      0082F2 A6 07            [ 1]  212     ld a,#(1<<I2C_ITR_ITBUFEN)|(1<<I2C_ITR_ITERREN)|(1<<I2C_ITR_ITEVTEN) 
      0082F4 C7 52 1A         [ 1]  213     ld I2C_ITR,a 
      0082F7 A6 05            [ 1]  214     ld a,#(1<<I2C_CR2_START)|(1<<I2C_CR2_ACK)
      0082F9 C7 52 11         [ 1]  215     ld I2C_CR2,a      
      0082FC 72 0F 00 1B FB   [ 2]  216 1$: btjf i2c_status,#I2C_STATUS_DONE,1$ 
      008301 81               [ 4]  217     ret 
                                    218 
                                    219 ;-------------------------------
                                    220 ; set I2C SCL frequency
                                    221 ; parameter:
                                    222 ;    A    {I2C_STD,I2C_FAST}
                                    223 ;-------------------------------
      008302                        224 i2c_scl_freq:
      008302 72 11 52 10      [ 1]  225 	bres I2C_CR1,#I2C_CR1_PE 
      008306 A1 00            [ 1]  226 	cp a,#I2C_STD 
      008308 26 0E            [ 1]  227 	jrne fast
      00830A                        228 std:
      00830A 35 00 52 1C      [ 1]  229 	mov I2C_CCRH,#I2C_CCRH_16MHZ_STD_100 
      00830E 35 50 52 1B      [ 1]  230 	mov I2C_CCRL,#I2C_CCRL_16MHZ_STD_100
      008312 35 11 52 1D      [ 1]  231 	mov I2C_TRISER,#I2C_TRISER_16MHZ_STD_100
      008316 20 0C            [ 2]  232 	jra i2c_scl_freq_exit 
      008318                        233 fast:
      008318 35 80 52 1C      [ 1]  234 	mov I2C_CCRH,#I2C_CCRH_16MHZ_FAST_400 
      00831C 35 0D 52 1B      [ 1]  235 	mov I2C_CCRL,#I2C_CCRL_16MHZ_FAST_400
      008320 35 05 52 1D      [ 1]  236 	mov I2C_TRISER,#I2C_TRISER_16MHZ_FAST_400
      008324                        237 i2c_scl_freq_exit:
      008324 72 10 52 10      [ 1]  238 	bset I2C_CR1,#I2C_CR1_PE 
      008328 81               [ 4]  239 	ret 
                                    240 
                                    241 ;-------------------------------
                                    242 ; initialize I2C peripheral 
                                    243 ; parameter:
                                    244 ;    A    {I2C_STD,I2C_FAST}
                                    245 ;-------------------------------
      008329                        246 i2c_init:
                                    247 ; set SDA and SCL pins as OD output 
      008329 72 1B 50 08      [ 1]  248 	bres I2C_PORT+GPIO_CR1,#SDA_BIT
      00832D 72 19 50 08      [ 1]  249 	bres I2C_PORT+GPIO_CR1,#SCL_BIT 
                                    250 ; set I2C peripheral 
      008331 72 10 50 C7      [ 1]  251 	bset CLK_PCKENR1,#CLK_PCKENR1_I2C 
      008335 72 5F 52 10      [ 1]  252 	clr I2C_CR1 
      008339 72 5F 52 11      [ 1]  253 	clr I2C_CR2 
      00833D 35 10 52 12      [ 1]  254     mov I2C_FREQR,#FMSTR ; peripheral clock frequency 
      008341 AD BF            [ 4]  255 	callr i2c_scl_freq
      008343 72 10 52 10      [ 1]  256 	bset I2C_CR1,#I2C_CR1_PE ; enable peripheral 
      008347 81               [ 4]  257 	ret 
                                    258 
                                    259 
                                    260 ;-----------------------------
                                    261 ; send start bit and device id 
                                    262 ; paramenter:
                                    263 ;     A      device_id, 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



                                    264 ; 			 b0=1 -> transmit
                                    265 ;			 b0=0 -> receive 
                                    266 ;----------------------------- 
      008348                        267 i2c_start:
      008348 72 02 52 19 FB   [ 2]  268     btjt I2C_SR3,#I2C_SR3_BUSY,.
      00834D 72 10 52 11      [ 1]  269 	bset I2C_CR2,#I2C_CR2_START 
      008351 72 01 52 17 FB   [ 2]  270 	btjf I2C_SR1,#I2C_SR1_SB,. 
      008356 C7 52 16         [ 1]  271 	ld I2C_DR,a 
      008359 72 03 52 17 FB   [ 2]  272 	btjf I2C_SR1,#I2C_SR1_ADDR,. 
      00835E 81               [ 4]  273 	ret 
                                    274 
                                    275 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;------------------------------
                                     20 ; SSD1306 OLED display 128x64
                                     21 ;------------------------------
                                     22 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



                                     23     .include "inc/ssd1306.inc"
                                      1 ;-----------------------
                                      2 ;  SSD1306 commands set 
                                      3 ;-----------------------
                                      4 
                                      5 
                           000040     6 DISP_HEIGHT=64 ; pixels 
                           000080     7 DISP_WIDTH=128 ; pixels 
                                      8 
                                      9 ;-------------------------------
                                     10 ;  SSD1306 commands set 
                                     11 ;-------------------------------
                                     12 ; display on/off commands 
                           0000AE    13 DISP_OFF=0XAE      ; turn off display 
                           0000AF    14 DISP_ON=0XAF       ; turn on display 
                           000081    15 DISP_CONTRAST=0X81 ; adjust contrast 0..127
                           0000A4    16 DISP_RAM=0XA4     ; diplay RAM bits 
                           0000A5    17 DISP_ALL_ON=0XA5  ; all pixel on 
                           0000A6    18 DISP_NORMAL=0XA6  ; normal display, i.e. bit set oled light 
                           0000A7    19 DISP_INVERSE=0XA7 ; inverted display 
                           00008D    20 DISP_CHARGE_PUMP=0X8D ; enable charge pump 
                                     21 ; scrolling commands 
                           000026    22 SCROLL_RIGHT=0X26  ; scroll pages range right 
                           000027    23 SCROLL_LEFT=0X27   ; scroll pages range left 
                           000029    24 SCROLL_VRIGHT=0X29 ; scroll vertical and right  
                           00002A    25 SCROLL_VLEFT=0X2A ; scroll vertical and left 
                           00002E    26 SCROLL_STOP=0X2E   ; stop scrolling 
                           00002F    27 SCROLL_START=0X2F  ; start scrolling 
                           0000A3    28 VERT_SCROLL_AREA=0XA3  ; set vertical scrolling area 
                                     29 ; addressing setting commands 
                                     30 ; 0x00-0x0f set lower nibble for column start address, page mode  
                                     31 ; 0x10-0x1f set high nibble for column start address, page mode 
                           000020    32 ADR_MODE=0X20 ; 0-> horz mode, 1-> vert mode, 2->page mode 
                           000021    33 COL_WND=0X21 ; set column window for horz and vert mode 
                           000022    34 PAG_WND=0X22 ; set page window for horz and vert mode 
                                     35 ; 0xb0-0xb7 set start page for page mode 
                           000040    36 START_LINE=0X40 ; 0x40-0x7f set display start line 
                           0000A0    37 MAP_SEG0_COL0=0XA0 ; map segment 0 to column 0 
                           0000A1    38 MAP_SEG0_COL128=0XA1 ; inverse mapping segment 0 to col 127   
                           0000A8    39 MUX_RATIO=0XA8 ; reset to 64 
                           0000C0    40 SCAN_TOP_DOWN=0XC0 ; scan from COM0 to COM63 
                           0000C8    41 SCAN_REVERSE=0XC8 ; scan from COM63 to COM0 
                           0000D3    42 DISP_OFFSET=0XD3 ; display offset to COMx 
                           0000DA    43 COM_CFG=0XDA ; set COM pins hardware configuration 
                                     44 ;Timing & Driving Scheme Setting Command Table
                           0000D5    45 CLK_FREQ_DIV=0xD5 ; clock frequency and divisor 
                           0000D9    46 PRE_CHARGE=0xD9 ; set pre-charge period 
                           0000DB    47 VCOMH_DSEL=0XDB ; set Vcomh deselect level 
                           0000E3    48 OLED_NOP=0xE3 
                                     49 
                                     50 ; memory addressing mode 
                           000000    51 HORZ_MODE=0 ; At each byte write column address pointer increase by 1 
                                     52             ; when reach end rollback to 0 and page pointer is increased by 1.
                           000001    53 VERT_MODE=1 ; At each byte write page pointer is increased by 1 and 
                                     54             ; when last page is reached rollback to page 0 and column pointer
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



                                     55             ; is increased by 1.
                           000002    56 PAGE_MODE=2 ; At each byte write column address pointer is increased by 1 
                                     57             ; when reach end rollback to 0 but page address pointer is not modified. 
                                     58 
                                     59 ; switch charge pump on/off 
                           000010    60 CP_OFF=0x10 
                           000014    61 CP_ON=0x14 
                                     62 
                                     63 ; co byte, first byte sent 
                                     64 ; after device address.
                           000080    65 OLED_CMD=0x80 
                           000040    66 OLED_DATA=0x40 
                                     67 
                                     68 
                                     69 ;--------------------------------
                                     70 ; command 0XDA parameter  
                                     71 ; COM pins hardware configuration
                                     72 ;--------------------------------
                           000000    73 COM_SEQUENTIAL=0 ; sequential pin scanning 0..63
                           000010    74 COM_ALTERNATE=0x10 ; alternate pin scanning 
                           000000    75 COM_DISABLE_REMAP=0  ; direct scanning 
                           000020    76 COM_ENABLE_REMAP=0x20 ; inverse scanning 
                                     77 
                                     78 ;------------------------
                                     79 ; command 0xD5 
                                     80 ; set display clock Divide
                                     81 ; and frequency 
                                     82 ;--------------------------
                           000004    83 CLK_FREQ=4; bit field 7:4 clok frequency (0..15)
                           000000    84 DISP_DIV=0 ; bit field 3:0 display clock divisor {0..15}
                                     85 
                                     86 ;--------------------------
                                     87 ; command 0xD9 
                                     88 ; set pre-charge period 
                                     89 ;-------------------------
                           000000    90 PHASE1_PERIOD=0 ; bit field 3:0 range {0..15}
                           000004    91 PHASE2_PERIOD=4 ; bit field 7:4 range {0..15}
                                     92 
                                     93 ;-------------------------
                                     94 ; command 0XDB 
                                     95 ; set Vcomh deslect level 
                                     96 ;------------------------
                           000000    97 VCOMH_DSEL_65=0
                           000020    98 VCOMH_DSEL_77=0X20 
                           000030    99 VCOMH_DSEL_83=0X30
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



                                     24 
                                     25 ;--------------------------------
                                     26 ; oled commands macros 
                                     27 ;----------------------------------
                                     28 
                                     29     ; initialize cmd_buffer 
                                     30     .macro _cmd_init 
                                     31         BUF_OFS=0
                                     32     .endm 
                                     33 
                                     34     ; set oled command buffer values 
                                     35     ; initialize BUF_OFS=0 
                                     36     ; before using it 
                                     37     .macro _set_cmd n
                                     38     BUF_OFS=BUF_OFS+1 
                                     39     mov cmd_buffer_BUF_OFS,#0x80
                                     40     BUF_OFS=BUF_OFS+1 
                                     41     mov cmd_buffer+BUF_OFS,#n 
                                     42     .endm 
                                     43 
                                     44     
                                     45     ; send command 
                                     46     .macro _send_cmd code 
                                     47     ld a,#code 
                                     48     call oled_cmd 
                                     49     .endm 
                                     50 
                                     51 ;----------------------------
                                     52 ; initialize OLED display
                                     53 ;----------------------------
      00835F                         54 oled_init:: 
                                     55 ; multiplex ratio to default 64 
      0002DF                         56     _send_cmd MUX_RATIO 
      00835F A6 A8            [ 1]    1     ld a,#MUX_RATIO 
      008361 CD 84 19         [ 4]    2     call oled_cmd 
      0002E4                         57     _send_cmd 63
      008364 A6 3F            [ 1]    1     ld a,#63 
      008366 CD 84 19         [ 4]    2     call oled_cmd 
                                     58 ; no display offset 
      0002E9                         59     _send_cmd DISP_OFFSET 
      008369 A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      00836B CD 84 19         [ 4]    2     call oled_cmd 
      0002EE                         60     _send_cmd 0 
      00836E A6 00            [ 1]    1     ld a,#0 
      008370 CD 84 19         [ 4]    2     call oled_cmd 
                                     61 ; no segment remap SEG0 -> COM0 
      0002F3                         62     _send_cmd MAP_SEG0_COL0   
      008373 A6 A0            [ 1]    1     ld a,#MAP_SEG0_COL0 
      008375 CD 84 19         [ 4]    2     call oled_cmd 
                                     63 ; COMMON scan direction top to bottom 
      0002F8                         64     _send_cmd SCAN_TOP_DOWN
      008378 A6 C0            [ 1]    1     ld a,#SCAN_TOP_DOWN 
      00837A CD 84 19         [ 4]    2     call oled_cmd 
                                     65 ; common pins config, bit 5=0, 4=1 
      0002FD                         66     _send_cmd COM_CFG 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      00837D A6 DA            [ 1]    1     ld a,#COM_CFG 
      00837F CD 84 19         [ 4]    2     call oled_cmd 
      000302                         67     _send_cmd COM_DISABLE_REMAP+COM_ALTERNATE
      008382 A6 10            [ 1]    1     ld a,#COM_DISABLE_REMAP+COM_ALTERNATE 
      008384 CD 84 19         [ 4]    2     call oled_cmd 
                                     68 ; constrast level 1, lowest 
      000307                         69     _send_cmd DISP_CONTRAST
      008387 A6 81            [ 1]    1     ld a,#DISP_CONTRAST 
      008389 CD 84 19         [ 4]    2     call oled_cmd 
      00030C                         70     _send_cmd 1
      00838C A6 01            [ 1]    1     ld a,#1 
      00838E CD 84 19         [ 4]    2     call oled_cmd 
                                     71 ; display RAM 
      000311                         72     _send_cmd DISP_RAM
      008391 A6 A4            [ 1]    1     ld a,#DISP_RAM 
      008393 CD 84 19         [ 4]    2     call oled_cmd 
                                     73 ; display normal 
      000316                         74     _send_cmd DISP_NORMAL
      008396 A6 A6            [ 1]    1     ld a,#DISP_NORMAL 
      008398 CD 84 19         [ 4]    2     call oled_cmd 
                                     75 ; clock frequency=maximum and display divisor=1 
      00031B                         76     _send_cmd CLK_FREQ_DIV
      00839B A6 D5            [ 1]    1     ld a,#CLK_FREQ_DIV 
      00839D CD 84 19         [ 4]    2     call oled_cmd 
      000320                         77     _send_cmd ((15<<CLK_FREQ)+(0<<DISP_DIV)) 
      0083A0 A6 F0            [ 1]    1     ld a,#((15<<CLK_FREQ)+(0<<DISP_DIV)) 
      0083A2 CD 84 19         [ 4]    2     call oled_cmd 
                                     78 ; pre-charge phase1=1 and phase2=15
                                     79 ; reducing phase2 value dim display  
      000325                         80     _send_cmd PRE_CHARGE
      0083A5 A6 D9            [ 1]    1     ld a,#PRE_CHARGE 
      0083A7 CD 84 19         [ 4]    2     call oled_cmd 
      00032A                         81     _send_cmd ((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD))
      0083AA A6 F1            [ 1]    1     ld a,#((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD)) 
      0083AC CD 84 19         [ 4]    2     call oled_cmd 
                                     82 ; RAM addressing mode       
      00032F                         83     _send_cmd ADR_MODE 
      0083AF A6 20            [ 1]    1     ld a,#ADR_MODE 
      0083B1 CD 84 19         [ 4]    2     call oled_cmd 
      000334                         84     _send_cmd HORZ_MODE
      0083B4 A6 00            [ 1]    1     ld a,#HORZ_MODE 
      0083B6 CD 84 19         [ 4]    2     call oled_cmd 
                                     85 ; Vcomh deselect level 0.83volt 
      000339                         86     _send_cmd VCOMH_DSEL 
      0083B9 A6 DB            [ 1]    1     ld a,#VCOMH_DSEL 
      0083BB CD 84 19         [ 4]    2     call oled_cmd 
      00033E                         87     _send_cmd VCOMH_DSEL_83
      0083BE A6 30            [ 1]    1     ld a,#VCOMH_DSEL_83 
      0083C0 CD 84 19         [ 4]    2     call oled_cmd 
                                     88 ; enable charge pump 
      000343                         89     _send_cmd DISP_CHARGE_PUMP
      0083C3 A6 8D            [ 1]    1     ld a,#DISP_CHARGE_PUMP 
      0083C5 CD 84 19         [ 4]    2     call oled_cmd 
      000348                         90     _send_cmd CP_ON 
      0083C8 A6 14            [ 1]    1     ld a,#CP_ON 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      0083CA CD 84 19         [ 4]    2     call oled_cmd 
                                     91 ; disable scrolling 
      00034D                         92     _send_cmd SCROLL_STOP
      0083CD A6 2E            [ 1]    1     ld a,#SCROLL_STOP 
      0083CF CD 84 19         [ 4]    2     call oled_cmd 
                                     93 ; diplay row from 0 
      000352                         94     _send_cmd START_LINE 
      0083D2 A6 40            [ 1]    1     ld a,#START_LINE 
      0083D4 CD 84 19         [ 4]    2     call oled_cmd 
                                     95 ; activate display 
      000357                         96     _send_cmd DISP_ON 
      0083D7 A6 AF            [ 1]    1     ld a,#DISP_ON 
      0083D9 CD 84 19         [ 4]    2     call oled_cmd 
      0083DC 81               [ 4]   97     ret 
                                     98 
                                     99 ;--------------------------------
                                    100 ; set column address to 0:127 
                                    101 ; set page address to 0:7 
                                    102 ;--------------------------------
      0083DD                        103 all_display:
                                    104 ; page window 0..7
      00035D                        105     _send_cmd PAG_WND 
      0083DD A6 22            [ 1]    1     ld a,#PAG_WND 
      0083DF CD 84 19         [ 4]    2     call oled_cmd 
      000362                        106     _send_cmd 0  
      0083E2 A6 00            [ 1]    1     ld a,#0 
      0083E4 CD 84 19         [ 4]    2     call oled_cmd 
      000367                        107     _send_cmd 7 
      0083E7 A6 07            [ 1]    1     ld a,#7 
      0083E9 CD 84 19         [ 4]    2     call oled_cmd 
                                    108 ; columns windows 0..127
      00036C                        109     _send_cmd COL_WND 
      0083EC A6 21            [ 1]    1     ld a,#COL_WND 
      0083EE CD 84 19         [ 4]    2     call oled_cmd 
      000371                        110     _send_cmd 0 
      0083F1 A6 00            [ 1]    1     ld a,#0 
      0083F3 CD 84 19         [ 4]    2     call oled_cmd 
      000376                        111     _send_cmd 127
      0083F6 A6 7F            [ 1]    1     ld a,#127 
      0083F8 CD 84 19         [ 4]    2     call oled_cmd 
      0083FB 81               [ 4]  112     ret 
                                    113 
                                    114 ;-----------------------
                                    115 ; set ram write window 
                                    116 ; input:
                                    117 ;     XH  col low  
                                    118 ;     XL  col high
                                    119 ;     YH  page low 
                                    120 ;     YL  page high 
                                    121 ;-----------------------
      0083FC                        122 set_window:
      0083FC 89               [ 2]  123     pushw x 
      0083FD 90 89            [ 2]  124     pushw y 
      00037F                        125     _send_cmd PAG_WND 
      0083FF A6 22            [ 1]    1     ld a,#PAG_WND 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



      008401 CD 84 19         [ 4]    2     call oled_cmd 
      008404 84               [ 1]  126     pop a 
      008405 CD 84 19         [ 4]  127     call oled_cmd 
      008408 84               [ 1]  128     pop a 
      008409 CD 84 19         [ 4]  129     call oled_cmd 
      00038C                        130     _send_cmd COL_WND 
      00840C A6 21            [ 1]    1     ld a,#COL_WND 
      00840E CD 84 19         [ 4]    2     call oled_cmd 
      008411 84               [ 1]  131     pop a 
      008412 CD 84 19         [ 4]  132     call oled_cmd 
      008415 84               [ 1]  133     pop a 
      008416 CC 84 19         [ 2]  134     jp oled_cmd 
                                    135 
                           000000   136 .if 0
                                    137 ;------------------------
                                    138 ; scroll display left|right  
                                    139 ; input:
                                    140 ;     A   SCROLL_LEFT|SCROLL_RIGHT 
                                    141 ;     XL  speed 
                                    142 ;------------------------
                                    143 scroll:
                                    144     pushw x 
                                    145     call oled_cmd 
                                    146     _send_cmd 0 ; dummy byte  
                                    147     _send_cmd 0 ; start page 0 
                                    148     pop a ; 
                                    149     pop a ; 
                                    150     call oled_cmd ;speed  
                                    151     _send_cmd 7 ; end page 
                                    152     _send_cmd 0 ; dummy 
                                    153     _send_cmd 255 ; dummy
                                    154     _send_cmd SCROLL_START 
                                    155     ret 
                                    156 
                                    157 ;---------------------------------
                                    158 ; enable/disable charge pump 
                                    159 ; parameters:
                                    160 ;    A    CP_OFF|CP_ON 
                                    161 ;---------------------------------
                                    162 charge_pump_switch:
                                    163     push a 
                                    164     _send_cmd DISP_CHARGE_PUMP
                                    165     pop a 
                                    166     jra oled_cmd 
                                    167 
                                    168 .endif 
                                    169 
                                    170 ;---------------------------------
                                    171 ; send command to OLED 
                                    172 ; parameters:
                                    173 ;     A     command code  
                                    174 ;---------------------------------
      008419                        175 oled_cmd:
      008419 89               [ 2]  176     pushw x 
      00039A                        177     _clrz i2c_count 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



      00841A 3F 17                    1     .byte 0x3f, i2c_count 
      00841C 35 02 00 18      [ 1]  178     mov i2c_count+1,#2
      008420 AE 01 00         [ 2]  179     ldw x,#co_code 
      008423 E7 01            [ 1]  180     ld (1,x),a 
      008425 A6 80            [ 1]  181     ld a,#OLED_CMD 
      008427 F7               [ 1]  182     ld (x),a   
      0003A8                        183     _strxz i2c_buf 
      008428 BF 15                    1     .byte 0xbf,i2c_buf 
      00842A 35 78 00 1C      [ 1]  184     mov i2c_devid,#OLED_DEVID 
      0003AE                        185     _clrz i2c_status
      00842E 3F 1B                    1     .byte 0x3f, i2c_status 
      008430 CD 82 EA         [ 4]  186     call i2c_write
      008433 85               [ 2]  187     popw x 
      008434 81               [ 4]  188     ret 
                                    189 
                                    190 ;---------------------------------
                                    191 ; send data to OLED GDDRAM
                                    192 ; parameters:
                                    193 ;     X     byte count  
                                    194 ;---------------------------------
      008435                        195 oled_data:
      008435 5C               [ 1]  196     incw x   
      0003B6                        197     _strxz i2c_count     
      008436 BF 17                    1     .byte 0xbf,i2c_count 
      008438 AE 01 00         [ 2]  198     ldw x,#co_code 
      00843B A6 40            [ 1]  199     ld a,#OLED_DATA 
      00843D F7               [ 1]  200     ld (x),a 
      0003BE                        201     _strxz i2c_buf
      00843E BF 15                    1     .byte 0xbf,i2c_buf 
      008440 35 78 00 1C      [ 1]  202     mov i2c_devid,#OLED_DEVID 
      0003C4                        203     _clrz i2c_status
      008444 3F 1B                    1     .byte 0x3f, i2c_status 
      008446 CD 82 EA         [ 4]  204     call i2c_write
      008449 81               [ 4]  205     ret 
                                    206 
                                    207 
                                    208 
                                    209 
                                    210 
                                    211 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



                                      1 ; rotated 6x8 pixels font to use with ssd1306 oled display
                                      2  
                                      3 ;
                                      4 ; Copyright Jacques Deschênes 2023 
                                      5 ; This file is part of stm8_ssd1306
                                      6 ;
                                      7 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      8 ;     it under the terms of the GNU General Public License as published by
                                      9 ;     the Free Software Foundation, either version 3 of the License, or
                                     10 ;     (at your option) any later version.
                                     11 ;
                                     12 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     13 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     14 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     15 ;     GNU General Public License for more details.
                                     16 ;
                                     17 ;     You should have received a copy of the GNU General Public License
                                     18 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     19 ;;
                                     20 
                                     21 ; ASCII font 6x8 
                           000008    22 OLED_FONT_HEIGHT=8 
                           000006    23 OLED_FONT_WIDTH=6 
      00844A                         24 oled_font_6x8: 
      00844A 00 00 00 00 00 00       25 .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; space ASCII 32
      008450 00 00 5F 00 00 00       26 .byte 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 ; !
      008456 00 07 00 07 00 00       27 .byte 0x00, 0x07, 0x00, 0x07, 0x00, 0x00 ; "
      00845C 14 7F 14 7F 14 00       28 .byte 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 ; #
      008462 24 2A 7F 2A 12 00       29 .byte 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 ; $
      008468 23 13 08 64 62 00       30 .byte 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 ; %
      00846E 36 49 55 22 50 00       31 .byte 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 ; &
      008474 00 05 03 00 00 00       32 .byte 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 ; '
      00847A 00 1C 22 41 00 00       33 .byte 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 ; (
      008480 00 41 22 1C 00 00       34 .byte 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 ; )
      008486 14 08 3E 08 14 00       35 .byte 0x14, 0x08, 0x3E, 0x08, 0x14, 0x00 ; *
      00848C 08 08 3E 08 08 00       36 .byte 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 ; +
      008492 00 D8 78 38 00 00       37 .byte 0x00, 0xD8, 0x78, 0x38, 0x00, 0x00 ; ,
      008498 08 08 08 08 00 00       38 .byte 0x08, 0x08, 0x08, 0x08, 0x00, 0x00 ; -
      00849E 00 60 60 60 00 00       39 .byte 0x00, 0x60, 0x60, 0x60, 0x00, 0x00 ; .
      0084A4 00 20 34 18 0C 06       40 .byte 0x00, 0x20, 0x34, 0x18, 0x0C, 0x06 ; /
      0084AA 3E 51 49 45 3E 00       41 .byte 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 ; 0
      0084B0 40 42 7F 40 40 00       42 .byte 0x40, 0x42, 0x7F, 0x40, 0x40, 0x00 ; 1
      0084B6 62 51 49 45 42 00       43 .byte 0x62, 0x51, 0x49, 0x45, 0x42, 0x00 ; 2
      0084BC 49 49 49 49 36 00       44 .byte 0x49, 0x49, 0x49, 0x49, 0x36, 0x00 ; 3
      0084C2 18 14 12 7F 10 00       45 .byte 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 ; 4
      0084C8 4F 49 49 49 31 00       46 .byte 0x4F, 0x49, 0x49, 0x49, 0x31, 0x00 ; 5
      0084CE 3C 4A 49 49 30 00       47 .byte 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 ; 6
      0084D4 01 71 09 05 03 00       48 .byte 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 ; 7
      0084DA 36 49 49 49 36 00       49 .byte 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 ; 8
      0084E0 06 49 49 49 36 00       50 .byte 0x06, 0x49, 0x49, 0x49, 0x36, 0x00 ; 9
      0084E6 00 36 36 36 00 00       51 .byte 0x00, 0x36, 0x36, 0x36, 0x00, 0x00 ; :
      0084EC 00 F6 76 36 00 00       52 .byte 0x00, 0xF6, 0x76, 0x36, 0x00, 0x00 ; ;
      0084F2 08 14 22 41 00 00       53 .byte 0x08, 0x14, 0x22, 0x41, 0x00, 0x00 ; <
      0084F8 14 14 14 14 14 00       54 .byte 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 ; =
      0084FE 00 41 22 14 08 00       55 .byte 0x00, 0x41, 0x22, 0x14, 0x08, 0x00 ; >
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



      008504 02 01 51 09 06 00       56 .byte 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 ; ?
      00850A 32 49 79 41 3E 00       57 .byte 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 ; @
      008510 7E 09 09 09 7E 00       58 .byte 0x7E, 0x09, 0x09, 0x09, 0x7E, 0x00 ; A
      008516 7F 49 49 49 36 00       59 .byte 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 ; B
      00851C 3E 41 41 41 41 00       60 .byte 0x3E, 0x41, 0x41, 0x41, 0x41, 0x00 ; C
      008522 7F 41 41 41 3E 00       61 .byte 0x7F, 0x41, 0x41, 0x41, 0x3E, 0x00 ; D
      008528 7F 49 49 49 49 00       62 .byte 0x7F, 0x49, 0x49, 0x49, 0x49, 0x00 ; E
      00852E 7F 09 09 09 09 00       63 .byte 0x7F, 0x09, 0x09, 0x09, 0x09, 0x00 ; F
      008534 3E 41 49 49 31 00       64 .byte 0x3E, 0x41, 0x49, 0x49, 0x31, 0x00 ; G
      00853A 7F 08 08 08 7F 00       65 .byte 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 ; H
      008540 00 41 7F 41 00 00       66 .byte 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 ; I
      008546 20 41 41 21 1F 00       67 .byte 0x20, 0x41, 0x41, 0x21, 0x1F, 0x00 ; J
      00854C 7F 08 14 22 41 00       68 .byte 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 ; K
      008552 7F 40 40 40 40 00       69 .byte 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 ; L
      008558 7F 02 04 02 7F 00       70 .byte 0x7F, 0x02, 0x04, 0x02, 0x7F, 0x00 ; M
      00855E 7F 04 08 10 7F 00       71 .byte 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 ; N
      008564 3E 41 41 41 3E 00       72 .byte 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 ; O
      00856A 7F 09 09 09 06 00       73 .byte 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 ; P
      008570 3E 41 51 61 7E 00       74 .byte 0x3E, 0x41, 0x51, 0x61, 0x7E, 0x00 ; Q
      008576 7F 09 19 29 46 00       75 .byte 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 ; R
      00857C 46 49 49 49 31 00       76 .byte 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 ; S
      008582 01 01 01 7F 01 01       77 .byte 0x01, 0x01, 0x01, 0x7F, 0x01, 0x01 ; T
      008588 3F 40 40 40 3F 00       78 .byte 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 ; U
      00858E 1F 20 40 20 1F 00       79 .byte 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 ; V
      008594 7F 20 18 20 7F 00       80 .byte 0x7F, 0x20, 0x18, 0x20, 0x7F, 0x00 ; W
      00859A 63 14 08 14 63 00       81 .byte 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 ; X
      0085A0 07 08 70 08 07 00       82 .byte 0x07, 0x08, 0x70, 0x08, 0x07, 0x00 ; Y
      0085A6 71 49 45 43 41 00       83 .byte 0x71, 0x49, 0x45, 0x43, 0x41, 0x00 ; Z
      0085AC 00 7F 41 00 00 00       84 .byte 0x00, 0x7F, 0x41, 0x00, 0x00, 0x00 ; [
      0085B2 02 04 08 10 20 00       85 .byte 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 ; '\'
      0085B8 00 00 00 41 7F 00       86 .byte 0x00, 0x00, 0x00, 0x41, 0x7F, 0x00 ; ]
      0085BE 04 02 01 02 04 00       87 .byte 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 ; ^
      0085C4 80 80 80 80 80 80       88 .byte 0x80, 0x80, 0x80, 0x80, 0x80, 0x80 ; _
      0085CA 00 01 02 04 00 00       89 .byte 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 ; `
      0085D0 20 54 54 54 78 00       90 .byte 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 ; a
      0085D6 7F 50 48 48 30 00       91 .byte 0x7F, 0x50, 0x48, 0x48, 0x30, 0x00 ; b
      0085DC 38 44 44 44 20 00       92 .byte 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 ; c
      0085E2 30 48 48 50 7F 00       93 .byte 0x30, 0x48, 0x48, 0x50, 0x7F, 0x00 ; d
      0085E8 38 54 54 54 18 00       94 .byte 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 ; e
      0085EE 08 7E 09 01 02 00       95 .byte 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 ; f
      0085F4 18 A4 A4 A4 7C 00       96 .byte 0x18, 0xA4, 0xA4, 0xA4, 0x7C, 0x00 ; g
      0085FA 7F 08 04 04 78 00       97 .byte 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 ; h
      008600 00 00 7A 00 00 00       98 .byte 0x00, 0x00, 0x7A, 0x00, 0x00, 0x00 ; i
      008606 20 40 44 3D 00 00       99 .byte 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 ; j
      00860C 7F 10 28 44 00 00      100 .byte 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00 ; k
      008612 00 41 7F 40 00 00      101 .byte 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 ; l
      008618 7C 04 18 04 78 00      102 .byte 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 ; m
      00861E 7C 08 04 04 78 00      103 .byte 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 ; n
      008624 38 44 44 44 38 00      104 .byte 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 ; o
      00862A FC 24 24 24 18 00      105 .byte 0xFC, 0x24, 0x24, 0x24, 0x18, 0x00 ; p
      008630 38 44 24 F8 84 00      106 .byte 0x38, 0x44, 0x24, 0xF8, 0x84, 0x00 ; q
      008636 7C 08 04 04 08 00      107 .byte 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 ; r
      00863C 48 54 54 54 20 00      108 .byte 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 ; s
      008642 04 3F 44 40 20 00      109 .byte 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 ; t
      008648 3C 40 40 20 7C 00      110 .byte 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 ; u
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      00864E 1C 20 40 20 1C 00      111 .byte 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 ; v
      008654 3C 40 30 40 3C 00      112 .byte 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 ; w
      00865A 44 28 10 28 44 00      113 .byte 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 ; x
      008660 1C A0 A0 A0 7C 00      114 .byte 0x1C, 0xA0, 0xA0, 0xA0, 0x7C, 0x00 ; y
      008666 44 64 54 4C 44 00      115 .byte 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 ; z
      00866C 08 36 41 00 00 00      116 .byte 0x08, 0x36, 0x41, 0x00, 0x00, 0x00 ; {
      008672 00 00 7F 00 00 00      117 .byte 0x00, 0x00, 0x7F, 0x00, 0x00, 0x00 ; |
      008678 00 41 36 08 00 00      118 .byte 0x00, 0x41, 0x36, 0x08, 0x00, 0x00 ; }
      00867E 08 04 08 10 08 00      119 .byte 0x08, 0x04, 0x08, 0x10, 0x08, 0x00 ; ~  ASCII 127 
      008684 FF FF FF FF FF FF      120 .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF ; 95 block cursor  127 
      00868A 08 49 2A 1C 08 00      121 .byte 0x08, 0x49, 0x2A, 0x1C, 0x08, 0x00 ; 96 flèche droite 128 
      008690 08 1C 2A 49 08 00      122 .byte 0x08, 0x1C, 0x2A, 0x49, 0x08, 0x00 ; 97 flèche gauche 129
      008696 04 02 3F 02 04 00      123 .byte 0x04, 0x02, 0x3F, 0x02, 0x04, 0x00 ; 98 flèche haut   130
      00869C 10 20 7E 20 10 00      124 .byte 0x10, 0x20, 0x7E, 0x20, 0x10, 0x00 ; 99 flèche bas    131
      0086A2 1C 3E 3E 3E 1C 00      125 .byte 0x1C, 0x3E, 0x3E, 0x3E, 0x1C, 0x00 ; 100 rond         132
      0086A8 00 00 00 80 80 80      126 .byte 0x00, 0x00, 0x00, 0x80, 0x80, 0x80 ; 101 underline cursor 133
      0086AE FF 00 00 00 00 00      127 .byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00 ; 102 insert cursor 134 
      0086B4 00 06 09 09 06 00      128 .byte 0x00, 0x06, 0x09, 0x09, 0x06, 0x00 ; 103 degree symbol 135 
      0086BA                        129 oled_font_end:
                           000087   130 DEGREE=135
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                                     19 ;-------------------------------
                                     20 ;  OLED diplay functions 
                                     21 ;
                                     22 ;  display buffer is 1024 bytes 
                                     23 ;  below stack 
                                     24 ;-------------------------------
                                     25 
                                     26 ; boolean flags  in 'disp_flags' 
                           000000    27 F_SCROLL=0 ; display scroll active 
                           000001    28 F_BIG=1 ; big font selected 
                                     29 
                                     30 ; small font display specifications
                           000015    31 SMALL_CPL=21  ; character per line
                           000008    32 SMALL_LINES=8 ; display lines 
                           000008    33 SMALL_FONT_HEIGHT=OLED_FONT_HEIGHT  
                           000006    34 SMALL_FONT_WIDTH=OLED_FONT_WIDTH 
                           000006    35 SMALL_FONT_SIZE=6 ; character font bytes  
                                     36 
                                     37 ; big font display specifications 
                           00000A    38 BIG_CPL=10   ; character per line 
                           000004    39 BIG_LINES=4  ; display lines 
                           000010    40 BIG_FONT_HEIGHT=2*OLED_FONT_HEIGHT 
                           00000C    41 BIG_FONT_WIDTH=2*OLED_FONT_WIDTH 
                           000018    42 BIG_FONT_SIZE=4*SMALL_FONT_SIZE ; character font bytes
                                     43 
                                     44 ; mega font specifications 
                           000005    45 MEGA_CPL=5 
                           000002    46 MEGA_LINES=2 
                           000020    47 MEGA_FONT_HEIGHT=4*OLED_FONT_HEIGHT 
                           000018    48 MEGA_FONT_WIDTH=4*OLED_FONT_WIDTH 
                           000060    49 MEGA_FONT_SIZE=16*SMALL_FONT_SIZE 
                                     50 
                                     51 ; zoom modes 
                           000000    52 SMALL=0 ; select small font 
                           000001    53 BIG=1 ; select big font  
                                     54 
                                     55 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



                                     56 ;--------------------------
                                     57 ; select font 
                                     58 ; input:
                                     59 ;    A   {SMALL,BIG}
                                     60 ;--------------------------
      0086BA                         61 select_font:
      0086BA 4D               [ 1]   62     tnz a 
      0086BB 26 21            [ 1]   63     jrne 2$ 
                                     64 ; small font 
      0086BD A6 15            [ 1]   65     ld a,#SMALL_CPL 
      00063F                         66     _straz cpl 
      0086BF B7 1F                    1     .byte 0xb7,cpl 
      0086C1 A6 08            [ 1]   67     ld a,#SMALL_LINES 
      000643                         68     _straz disp_lines 
      0086C3 B7 20                    1     .byte 0xb7,disp_lines 
      0086C5 A6 08            [ 1]   69     ld a,#SMALL_FONT_HEIGHT
      000647                         70     _straz font_height
      0086C7 B7 22                    1     .byte 0xb7,font_height 
      0086C9 A6 06            [ 1]   71     ld a,#SMALL_FONT_WIDTH
      00064B                         72     _straz font_width
      0086CB B7 21                    1     .byte 0xb7,font_width 
      0086CD A6 06            [ 1]   73     ld a,#SMALL_FONT_SIZE
      00064F                         74     _straz to_send
      0086CF B7 23                    1     .byte 0xb7,to_send 
      0086D1 72 58 00 1D      [ 1]   75     sll line 
      0086D5 72 58 00 1E      [ 1]   76     sll col
      0086D9 72 13 00 24      [ 1]   77     bres disp_flags,#F_BIG    
      0086DD 81               [ 4]   78     ret 
      0086DE                         79 2$: ; big font
      00065E                         80     _ldaz col 
      0086DE B6 1E                    1     .byte 0xb6,col 
      0086E0 A1 13            [ 1]   81     cp a,#19
      0086E2 2A 30            [ 1]   82     jrpl 9$  ; request rejected 
      000664                         83     _ldaz line 
      0086E4 B6 1D                    1     .byte 0xb6,line 
      0086E6 A1 07            [ 1]   84     cp a,#7
      0086E8 27 2A            [ 1]   85     jreq 9$  ; request rejected
      0086EA A6 0A            [ 1]   86     ld a,#BIG_CPL 
      00066C                         87     _straz cpl 
      0086EC B7 1F                    1     .byte 0xb7,cpl 
      0086EE A6 04            [ 1]   88     ld a,#BIG_LINES 
      000670                         89     _straz disp_lines 
      0086F0 B7 20                    1     .byte 0xb7,disp_lines 
      0086F2 A6 10            [ 1]   90     ld a,#BIG_FONT_HEIGHT
      000674                         91     _straz font_height
      0086F4 B7 22                    1     .byte 0xb7,font_height 
      0086F6 A6 0C            [ 1]   92     ld a,#BIG_FONT_WIDTH
      000678                         93     _straz font_width
      0086F8 B7 21                    1     .byte 0xb7,font_width 
      0086FA A6 18            [ 1]   94     ld a,#BIG_FONT_SIZE
      00067C                         95     _straz to_send
      0086FC B7 23                    1     .byte 0xb7,to_send 
      0086FE 72 01 00 1D 02   [ 2]   96     btjf line,#0,4$
      000683                         97     _incz line ; big font is lock step to even line  
      008703 3C 1D                    1     .byte 0x3c, line 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



      008705                         98 4$:
      008705 72 54 00 1D      [ 1]   99     srl line 
      008709 72 01 00 1E 02   [ 2]  100     btjf col,#0,6$ 
      00068E                        101     _incz col  ; big font is lock step to even column
      00870E 3C 1E                    1     .byte 0x3c, col 
      008710                        102 6$:
      008710 72 54 00 1E      [ 1]  103     srl col
      008714                        104 9$:
      008714 72 12 00 24      [ 1]  105     bset disp_flags,#F_BIG    
      008718 81               [ 4]  106     ret 
                                    107 
                                    108 
                                    109 ;------------------------
                                    110 ; set RAM window for 
                                    111 ; current line 
                                    112 ;-----------------------
      008719                        113 line_window:
      008719 89               [ 2]  114     pushw x 
      00871A 90 89            [ 2]  115     pushw y 
      00871C AE 00 7F         [ 2]  116     ldw x,#0x7f ; columms: 0..127
      00069F                        117     _ldaz line 
      00871F B6 1D                    1     .byte 0xb6,line 
      008721 72 03 00 24 06   [ 2]  118     btjf disp_flags,#F_BIG,1$ 
      008726 48               [ 1]  119     sll a 
      008727 90 95            [ 1]  120     ld yh,a 
      008729 4C               [ 1]  121     inc a 
      00872A 90 97            [ 1]  122     ld yl,a 
      00872C CD 83 FC         [ 4]  123 1$: call set_window 
      00872F 90 85            [ 2]  124     popw y 
      008731 85               [ 2]  125     popw x
      008732 81               [ 4]  126     ret 
                                    127 
                                    128 
                                    129 ;---------------------------
                                    130 ;  clear current line 
                                    131 ;---------------------------
      008733                        132 line_clear:
      008733 CD 87 19         [ 4]  133     call line_window 
      008736 CD 87 4B         [ 4]  134     call clear_disp_buffer
      008739 AE 00 80         [ 2]  135     ldw x,#DISPLAY_BUFFER_SIZE 
      00873C CD 84 35         [ 4]  136     call oled_data
      00873F 72 03 00 24 06   [ 2]  137     btjf disp_flags,#F_BIG,9$
      008744 AE 00 80         [ 2]  138     ldw x,#DISPLAY_BUFFER_SIZE
      008747 CD 84 35         [ 4]  139     call oled_data 
      00874A 81               [ 4]  140 9$: ret 
                                    141 
                                    142 ;----------------------
                                    143 ; zero's display buffer 
                                    144 ; input: 
                                    145 ;   none 
                                    146 ;----------------------
      00874B                        147 clear_disp_buffer:
      00874B 89               [ 2]  148     pushw x 
      00874C 88               [ 1]  149     push a 
      00874D AE 01 01         [ 2]  150     ldw x,#disp_buffer 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



      008750 A6 80            [ 1]  151     ld a,#DISPLAY_BUFFER_SIZE
      008752 7F               [ 1]  152 1$: clr(x)
      008753 5C               [ 1]  153     incw x 
      008754 4A               [ 1]  154     dec a 
      008755 26 FB            [ 1]  155     jrne 1$
      008757 84               [ 1]  156     pop a 
      008758 85               [ 2]  157     popw x 
      008759 81               [ 4]  158     ret 
                                    159 
                                    160 ;--------------------------
                                    161 ;  zero's SSD1306 RAM 
                                    162 ;--------------------------
      00875A                        163 display_clear:
      00875A 88               [ 1]  164     push a 
      00875B 89               [ 2]  165     pushw x 
      00875C CD 83 DD         [ 4]  166     call all_display 
      00875F CD 87 4B         [ 4]  167     call clear_disp_buffer
      008762 4B 08            [ 1]  168     push #8
      008764 AE 00 80         [ 2]  169 1$: ldw x,#DISPLAY_BUFFER_SIZE
      008767 CD 84 35         [ 4]  170     call oled_data
      00876A 0A 01            [ 1]  171     dec (1,sp)
      00876C 26 F6            [ 1]  172     jrne 1$ 
      0006EE                        173     _drop 1 
      00876E 5B 01            [ 2]    1     addw sp,#1 
      0006F0                        174     _clrz line 
      008770 3F 1D                    1     .byte 0x3f, line 
      0006F2                        175     _clrz col
      008772 3F 1E                    1     .byte 0x3f, col 
      008774 72 11 00 24      [ 1]  176     bres disp_flags,#F_SCROLL  
      008778 85               [ 2]  177     popw x
      008779 84               [ 1]  178     pop a 
      00877A 81               [ 4]  179     ret 
                                    180 
                                    181 ;---------------------------
                                    182 ; set display start line 
                                    183 ;----------------------------
      00877B                        184 scroll_up:
      00877B CD 87 33         [ 4]  185     call line_clear 
      0006FE                        186     _ldaz line 
      00877E B6 1D                    1     .byte 0xb6,line 
      008780 97               [ 1]  187     ld xl,a 
      008781 C6 00 22         [ 1]  188     ld a,font_height 
      008784 42               [ 4]  189     mul x,a 
      008785 9F               [ 1]  190     ld a,xl 
      008786 88               [ 1]  191     push a 
      000707                        192     _send_cmd DISP_OFFSET
      008787 A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      008789 CD 84 19         [ 4]    2     call oled_cmd 
      00878C 84               [ 1]  193     pop a  
      00878D CD 84 19         [ 4]  194     call oled_cmd
      008790 81               [ 4]  195     ret 
                                    196 
                                    197 ;-----------------------
                                    198 ; send text cursor 
                                    199 ; at next line 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



                                    200 ;------------------------
      008791                        201 crlf:
      000711                        202     _clrz col 
      008791 3F 1E                    1     .byte 0x3f, col 
      008793 72 00 00 24 11   [ 2]  203     btjt disp_flags,#F_SCROLL,2$
      000718                        204     _ldaz line
      008798 B6 1D                    1     .byte 0xb6,line 
      00879A 4C               [ 1]  205     inc a
      00879B C1 00 20         [ 1]  206     cp a,disp_lines 
      00879E 2A 03            [ 1]  207     jrpl 1$
      000720                        208     _straz line
      0087A0 B7 1D                    1     .byte 0xb7,line 
      0087A2 81               [ 4]  209     ret
      0087A3 72 10 00 24      [ 1]  210 1$: bset disp_flags,#F_SCROLL
      000727                        211     _clrz line       
      0087A7 3F 1D                    1     .byte 0x3f, line 
      0087A9                        212 2$:
      0087A9 CC 87 7B         [ 2]  213     jp scroll_up     
                                    214  
                                    215 
                                    216 
                                    217 ;-----------------------
                                    218 ; move cursor right 
                                    219 ; 1 character position
                                    220 ; scroll up if needed 
                                    221 ;-----------------------
      0087AC                        222 cursor_right:
      00072C                        223     _ldaz col 
      0087AC B6 1E                    1     .byte 0xb6,col 
      0087AE AB 01            [ 1]  224     add a,#1  
      000730                        225     _straz col 
      0087B0 B7 1E                    1     .byte 0xb7,col 
      0087B2 C1 00 1F         [ 1]  226     cp a,cpl  
      0087B5 2B 03            [ 1]  227     jrmi 9$
      0087B7 CD 87 91         [ 4]  228     call crlf 
      0087BA 81               [ 4]  229 9$: ret 
                                    230 
                                    231 ;----------------------------
                                    232 ; put char using rotated font 
                                    233 ; input:
                                    234 ;    A    character 
                                    235 ;-----------------------------
      0087BB                        236 put_char:
      0087BB 89               [ 2]  237     pushw x
      0087BC 90 89            [ 2]  238     pushw y 
      0087BE 88               [ 1]  239     push a 
      00073F                        240     _ldaz line
      0087BF B6 1D                    1     .byte 0xb6,line 
      0087C1 72 03 00 24 08   [ 2]  241     btjf disp_flags,#F_BIG,0$ 
      0087C6 48               [ 1]  242     sll a
      0087C7 90 95            [ 1]  243     ld yh,a 
      0087C9 4C               [ 1]  244     inc a 
      0087CA 90 97            [ 1]  245     ld yl,a
      0087CC 20 04            [ 2]  246     jra 1$  
      0087CE                        247 0$: 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



      0087CE 90 97            [ 1]  248     ld yl,a 
      0087D0 90 95            [ 1]  249     ld yh,a 
      0087D2                        250 1$:
      000752                        251     _ldaz col 
      0087D2 B6 1E                    1     .byte 0xb6,col 
      0087D4 97               [ 1]  252     ld xl,a 
      000755                        253     _ldaz font_width
      0087D5 B6 21                    1     .byte 0xb6,font_width 
      0087D7 42               [ 4]  254     mul x,a 
      0087D8 9F               [ 1]  255     ld a,xl 
      0087D9 95               [ 1]  256     ld xh,a 
      0087DA CB 00 21         [ 1]  257     add a,font_width 
      0087DD 4A               [ 1]  258     dec a 
      0087DE 97               [ 1]  259     ld xl,a 
      0087DF CD 83 FC         [ 4]  260     call set_window
      0087E2 84               [ 1]  261     pop a 
      0087E3 A0 20            [ 1]  262  	sub a,#SPACE 
      0087E5 90 97            [ 1]  263 	ld yl,a  
      0087E7 A6 06            [ 1]  264     ld a,#OLED_FONT_WIDTH  
      0087E9 90 42            [ 4]  265 	mul y,a 
      0087EB 72 A9 84 4A      [ 2]  266 	addw y,#oled_font_6x8
      0087EF 72 03 00 24 05   [ 2]  267     btjf disp_flags,#F_BIG,2$ 
      0087F4 CD 88 84         [ 4]  268     call zoom_char
      0087F7 20 08            [ 2]  269     jra 3$  
      0087F9                        270 2$:
      0087F9 AE 01 01         [ 2]  271     ldw x,#disp_buffer
      00077C                        272     _ldaz to_send  
      0087FC B6 23                    1     .byte 0xb6,to_send 
      0087FE CD 88 73         [ 4]  273     call cmove 
      008801 5F               [ 1]  274 3$: clrw x 
      000782                        275     _ldaz to_send  
      008802 B6 23                    1     .byte 0xb6,to_send 
      008804 97               [ 1]  276     ld xl,a 
      008805 CD 84 35         [ 4]  277     call oled_data 
      008808 CD 87 AC         [ 4]  278     call cursor_right 
      00880B 90 85            [ 2]  279     popw y
      00880D 85               [ 2]  280     popw x 
      00880E 81               [ 4]  281     ret 
                                    282 
                                    283 
                                    284 ;----------------------
                                    285 ; put string in display 
                                    286 ; buffer 
                                    287 ; input:
                                    288 ;    y  .asciz  
                                    289 ;----------------------
      00880F                        290 put_string:
      00880F 90 F6            [ 1]  291 1$: ld a,(y)
      008811 27 10            [ 1]  292     jreq 9$
      008813 A1 0A            [ 1]  293     cp a,#'\n'
      008815 26 05            [ 1]  294     jrne 2$
      008817 CD 87 91         [ 4]  295     call crlf 
      00881A 20 03            [ 2]  296     jra 4$
      00881C                        297 2$:
      00881C CD 87 BB         [ 4]  298     call put_char 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



      00881F                        299 4$:
      00881F 90 5C            [ 1]  300     incw y 
      008821 20 EC            [ 2]  301     jra 1$
                                    302 
      008823                        303 9$:  
      008823 81               [ 4]  304     ret 
                                    305 
                                    306 ;-----------------------
                                    307 ; convert integer to 
                                    308 ; ASCII string 
                                    309 ; input:
                                    310 ;   X    integer 
                                    311 ; output:
                                    312 ;   Y     *string 
                                    313 ;------------------------
                           000001   314     SIGN=1
      008824                        315 itoa:
      008824 4B 00            [ 1]  316     push #0 
      008826 5D               [ 2]  317     tnzw x 
      008827 2A 03            [ 1]  318     jrpl 1$ 
      008829 03 01            [ 1]  319     cpl (SIGN,SP)
      00882B 50               [ 2]  320     negw x 
      00882C 90 AE 01 89      [ 2]  321 1$: ldw y,#free_ram+8
      008830 90 7F            [ 1]  322     clr(y)
      008832                        323 2$:
      008832 90 5A            [ 2]  324     decw y 
      008834 A6 0A            [ 1]  325     ld a,#10 
      008836 62               [ 2]  326     div x,a 
      008837 AB 30            [ 1]  327     add a,#'0 
      008839 90 F7            [ 1]  328     ld (y),a 
      00883B 5D               [ 2]  329     tnzw x 
      00883C 26 F4            [ 1]  330     jrne 2$
      00883E 0D 01            [ 1]  331     tnz (SIGN,sp)
      008840 2A 06            [ 1]  332     jrpl 4$
      008842 90 5A            [ 2]  333     decw y 
      008844 A6 2D            [ 1]  334     ld a,#'-
      008846 90 F7            [ 1]  335     ld (y),a 
      0007C8                        336 4$: _drop 1 
      008848 5B 01            [ 2]    1     addw sp,#1 
      00884A 81               [ 4]  337     ret 
                                    338 
                                    339 ;--------------------------
                                    340 ; put integer to display
                                    341 ; input:
                                    342 ;    X   integer 
                                    343 ;------------------------
      00884B                        344 put_int:
      00884B 90 89            [ 2]  345     pushw y 
      00884D CD 88 24         [ 4]  346     call itoa 
      008850 CD 88 0F         [ 4]  347     call put_string 
      008853 90 85            [ 2]  348     popw y 
      008855 81               [ 4]  349     ret 
                                    350 
                                    351 ;-------------------
                                    352 ; put byte in hex 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



                                    353 ; input:
                                    354 ;   A 
                                    355 ;------------------
      008856                        356 put_byte:
      008856 88               [ 1]  357     push a 
      008857 4E               [ 1]  358     swap a 
      008858 CD 88 5C         [ 4]  359     call put_hex 
      00885B 84               [ 1]  360     pop a 
      00885C                        361 put_hex:    
      00885C A4 0F            [ 1]  362     and a,#0xf 
      00885E AB 30            [ 1]  363     add a,#'0 
      008860 A1 3A            [ 1]  364     cp a,#'9+1 
      008862 2B 02            [ 1]  365     jrmi 2$ 
      008864 AB 07            [ 1]  366     add a,#7 
      008866 CD 87 BB         [ 4]  367 2$: call put_char 
      008869 81               [ 4]  368     ret 
                                    369 
                                    370 ;----------------------------
                                    371 ; put hexadecimal integer 
                                    372 ; in display 
                                    373 ; buffer 
                                    374 ; input:
                                    375 ;    X    integer to display 
                                    376 ;---------------------------
      00886A                        377 put_hex_int:
      00886A 9E               [ 1]  378     ld a,xh 
      00886B CD 88 56         [ 4]  379     call put_byte 
      00886E 9F               [ 1]  380     ld a,xl 
      00886F CD 88 56         [ 4]  381     call put_byte 
      008872 81               [ 4]  382     ret 
                                    383 
                                    384 
                                    385 ;----------------------------
                                    386 ; copy bytes from (y) to (x)
                                    387 ; input:
                                    388 ;   a    count 
                                    389 ;   x    destination 
                                    390 ;   y    source 
                                    391 ;---------------------------
      008873                        392 cmove:
      008873 4D               [ 1]  393     tnz a  
      008874 27 0D            [ 1]  394     jreq 9$ 
      008876 88               [ 1]  395     push a 
      008877 90 F6            [ 1]  396 1$: ld a,(y)
      008879 F7               [ 1]  397     ld (x),a 
      00887A 90 5C            [ 1]  398     incw y 
      00887C 5C               [ 1]  399     incw x 
      00887D 0A 01            [ 1]  400     dec(1,sp)
      00887F 26 F6            [ 1]  401     jrne 1$
      000801                        402     _drop 1 
      008881 5B 01            [ 2]    1     addw sp,#1 
      008883                        403 9$:    
      008883 81               [ 4]  404     ret 
                                    405 
                                    406 ;---------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



                                    407 ; zoom 6x8 character 
                                    408 ; to 12x16 pixel 
                                    409 ; put data in disp_buffer 
                                    410 ; input:
                                    411 ;    Y   character font address  
                                    412 ;----------------------
                           000001   413     BIT_CNT=1 
                           000002   414     BYTE_CNT=2
                           000002   415     VAR_SIZE=2
      008884                        416 zoom_char:
      000804                        417     _vars VAR_SIZE 
      008884 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      008886 A6 06            [ 1]  418     ld a,#OLED_FONT_WIDTH
      008888 6B 02            [ 1]  419     ld (BYTE_CNT,sp),a
      00888A AE 01 01         [ 2]  420     ldw x,#disp_buffer 
      00888D                        421 1$: ; byte loop 
      00888D A6 08            [ 1]  422     ld a,#8 
      00888F 6B 01            [ 1]  423     ld (BIT_CNT,sp),a 
      008891 90 F6            [ 1]  424     ld a,(y)
      008893 90 5C            [ 1]  425     incw y
      008895                        426 2$:    
      008895 72 54 00 10      [ 1]  427     srl acc16 
      008899 72 56 00 11      [ 1]  428     rrc acc8 
      00889D 72 54 00 10      [ 1]  429     srl acc16
      0088A1 72 56 00 11      [ 1]  430     rrc acc8 
      0088A5 44               [ 1]  431     srl a 
      0088A6 90 1F 00 10      [ 1]  432     bccm acc16,#7 
      0088AA 90 1D 00 10      [ 1]  433     bccm acc16,#6 
      0088AE 0A 01            [ 1]  434     dec (BIT_CNT,sp)
      0088B0 26 E3            [ 1]  435     jrne 2$ 
      000832                        436     _ldaz acc8 
      0088B2 B6 11                    1     .byte 0xb6,acc8 
      0088B4 F7               [ 1]  437     ld (x),a
      0088B5 E7 01            [ 1]  438     ld (1,x),a  
      000837                        439     _ldaz acc16 
      0088B7 B6 10                    1     .byte 0xb6,acc16 
      0088B9 E7 0C            [ 1]  440     ld (2*OLED_FONT_WIDTH,x),a
      0088BB E7 0D            [ 1]  441     ld (2*OLED_FONT_WIDTH+1,x),a 
      0088BD 1C 00 02         [ 2]  442     addw x,#2 
      0088C0 0A 02            [ 1]  443     dec (BYTE_CNT,sp)
      0088C2 26 C9            [ 1]  444     jrne 1$
      000844                        445     _drop VAR_SIZE 
      0088C4 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      0088C6 81               [ 4]  446     ret 
                                    447 
                                    448 ;------------------------------
                                    449 ; magnify character 4X 
                                    450 ; resulting in 24x32 pixels font  
                                    451 ; font size 96 bytes 
                                    452 ; input:
                                    453 ;    A   character 
                                    454 ;    XH  page 
                                    455 ;    XL  column 
                                    456 ;------------------------------
                           000001   457     BIT_CNT=1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



                           000002   458     BYTE_CNT=2
                           000003   459     SHIFT_CNT=3 
                           000004   460     CHAR=4
                           000005   461     BYTE=5
                           000006   462     YSAVE=6
                           000007   463     VAR_SIZE=7
      0088C7                        464 put_mega_char:
      000847                        465     _vars VAR_SIZE
      0088C7 52 07            [ 2]    1     sub sp,#VAR_SIZE 
      0088C9 17 06            [ 2]  466     ldw (YSAVE,sp),y
      0088CB 6B 04            [ 1]  467     ld (CHAR,sp),a  
                                    468 ; set character window 
      0088CD 9E               [ 1]  469     ld a,xh 
      0088CE 90 95            [ 1]  470     ld yh,a 
      0088D0 AB 03            [ 1]  471     add a,#MEGA_FONT_HEIGHT/8-1
      0088D2 90 97            [ 1]  472     ld yl,a 
      0088D4 5E               [ 1]  473     swapw x 
      0088D5 9E               [ 1]  474     ld a,xh 
      0088D6 AB 17            [ 1]  475     add a,#MEGA_FONT_WIDTH-1
      0088D8 97               [ 1]  476     ld xl,a 
      0088D9 CD 83 FC         [ 4]  477     call set_window 
      0088DC 7B 04            [ 1]  478     ld a,(CHAR,sp)
      0088DE A0 20            [ 1]  479     sub a,#SPACE 
      0088E0 90 97            [ 1]  480     ld yl,a 
      0088E2 A6 06            [ 1]  481     ld a,#OLED_FONT_WIDTH
      0088E4 6B 02            [ 1]  482     ld (BYTE_CNT,sp),a 
      0088E6 90 42            [ 4]  483     mul y,a 
      0088E8 72 A9 84 4A      [ 2]  484     addw y,#oled_font_6x8
      0088EC AE 01 01         [ 2]  485     ldw x,#disp_buffer 
      0088EF                        486 1$: ; byte loop 
      0088EF A6 08            [ 1]  487     ld a,#8 
      0088F1 6B 01            [ 1]  488     ld (BIT_CNT,sp),a 
      0088F3 90 F6            [ 1]  489     ld a,(y)
      0088F5 6B 05            [ 1]  490     ld (BYTE,sp),a 
      0088F7 90 5C            [ 1]  491     incw y
      0088F9                        492 2$: ; bit loop 
      0088F9 A6 03            [ 1]  493     ld a,#3 
      0088FB 6B 03            [ 1]  494     ld (SHIFT_CNT,sp),a
      0088FD 04 05            [ 1]  495     srl (BYTE,sp)
      0088FF 66 48            [ 1]  496     rrc (72,x)  
      008901 66 30            [ 1]  497     rrc (48,x)
      008903 66 18            [ 1]  498     rrc (24,x)
      008905 76               [ 1]  499     rrc (x)
      008906                        500 3$: ; shift loop     
      008906 67 48            [ 1]  501     sra (72,x) 
      008908 66 30            [ 1]  502     rrc (48,x)
      00890A 66 18            [ 1]  503     rrc (24,x)
      00890C 76               [ 1]  504     rrc (x)
      00890D 0A 03            [ 1]  505     dec (SHIFT_CNT,sp)
      00890F 26 F5            [ 1]  506     jrne 3$ 
      008911 0A 01            [ 1]  507     dec (BIT_CNT,sp)
      008913 26 E4            [ 1]  508     jrne 2$ 
      008915 A6 03            [ 1]  509     ld a,#3
      008917 6B 03            [ 1]  510     ld (SHIFT_CNT,sp),a 
      008919                        511 4$: ; copy bytes in width 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      008919 F6               [ 1]  512     ld a,(x)
      00891A E7 01            [ 1]  513     ld (1,x),a 
      00891C E6 18            [ 1]  514     ld a,(24,x)
      00891E E7 19            [ 1]  515     ld (25,x),a 
      008920 E6 30            [ 1]  516     ld a,(48,x)
      008922 E7 31            [ 1]  517     ld (49,x),a 
      008924 E6 48            [ 1]  518     ld a,(72,x)
      008926 E7 49            [ 1]  519     ld (73,x),a 
      008928 5C               [ 1]  520     incw x 
      008929 0A 03            [ 1]  521     dec (SHIFT_CNT,sp)
      00892B 26 EC            [ 1]  522     jrne 4$ 
      00892D 0A 02            [ 1]  523     dec (BYTE_CNT,sp)
      00892F 26 BE            [ 1]  524     jrne 1$
      008931 AE 00 60         [ 2]  525     ldw x,#MEGA_FONT_SIZE
      008934 CD 84 35         [ 4]  526     call oled_data 
      008937 16 06            [ 2]  527     ldw y,(YSAVE,sp)
      0008B9                        528     _drop VAR_SIZE 
      008939 5B 07            [ 2]    1     addw sp,#VAR_SIZE 
      00893B 81               [ 4]  529     ret 
                                    530 
                                    531 ;--------------------
                                    532 ; put mega character 
                                    533 ; string 
                                    534 ;     XH   top page   
                                    535 ;     XL   left column  
                                    536 ;     Y    *string 
                                    537 ;--------------------
                           000001   538     PAGE=1 
                           000002   539     COL=2 
                           000002   540     VAR_SIZE=2 
      00893C                        541 put_mega_string:
      0008BC                        542     _vars VAR_SIZE 
      00893C 52 02            [ 2]    1     sub sp,#VAR_SIZE 
      00893E 1F 01            [ 2]  543     ldw (PAGE,sp),x 
      008940                        544 1$:
      008940 90 7D            [ 1]  545     tnz (y)
      008942 27 11            [ 1]  546     jreq 9$ 
      008944 1E 01            [ 2]  547     ldw x,(PAGE,sp)
      008946 90 F6            [ 1]  548     ld a,(y)
      008948 90 5C            [ 1]  549     incw y 
      00894A CD 88 C7         [ 4]  550     call put_mega_char
      00894D 7B 02            [ 1]  551     ld a,(COL,sp)
      00894F AB 18            [ 1]  552     add a,#MEGA_FONT_WIDTH
      008951 6B 02            [ 1]  553     LD (COL,sp),a 
      008953 20 EB            [ 2]  554     jra 1$
      008955                        555 9$:
      0008D5                        556     _drop VAR_SIZE 
      008955 5B 02            [ 2]    1     addw sp,#VAR_SIZE 
      008957 81               [ 4]  557     ret 
                                    558 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022  
                                      3 ; This file is part of stm8_ssd1306 
                                      4 ;
                                      5 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           000001    19 .if DEBUG 
                                     20     .module STM8_MON 
                                     21 
                                     22 ;--------------------------------------
                                     23     .area DATA
      000001                         24 mode: .blkb 1 ; command mode 
      000002                         25 xamadr: .blkw 1 ; examine address 
      000004                         26 storadr: .blkw 1 ; store address 
      000006                         27 last: .blkw 1   ; last address parsed from input 
                                     28 
                                     29     .area  CODE
                                     30 
                                     31 ;----------------------------------------------------------------------------------------
                                     32 ; command line interface
                                     33 ; input formats:
                                     34 ;       hex_number  -> display byte at that address 
                                     35 ;       hex_number.hex_number -> display bytes in that range 
                                     36 ;       hex_number: hex_byte [hex_byte]*  -> modify content of RAM or peripheral registers 
                                     37 ;       R  -> run binary code at xamadr address  
                                     38 ;------------------------------------------------------------------------------------------
                                     39 ; operatiing modes 
                           000000    40     NOP=0
                           000001    41     READ=1 ; single address or block
                           000002    42     STORE=2 
                                     43 
                                     44     ; get next character from input buffer 
                                     45     .macro _next_char 
                                     46     ld a,(y)
                                     47     incw y 
                                     48     .endm ; 4 bytes, 2 cy 
                                     49 
      008958                         50 cli: 
      008958 A6 0D            [ 1]   51     ld a,#CR 
      00895A CD 8A 7B         [ 4]   52     call putchar 
      00895D A6 23            [ 1]   53     ld a,#'# 
      00895F CD 8A 7B         [ 4]   54     call putchar ; prompt character 
      008962 CD 8A 84         [ 4]   55     call getline
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



                                     56 ; analyze input line      
      008965 90 AE 00 37      [ 2]   57     ldw y,#tib  
      0008E9                         58     _clrz mode 
      008969 3F 01                    1     .byte 0x3f, mode 
      00896B                         59 next_char:     
      0008EB                         60     _next_char
      00896B 90 F6            [ 1]    1     ld a,(y)
      00896D 90 5C            [ 1]    2     incw y 
      00896F 4D               [ 1]   61     tnz a     
      008970 26 0B            [ 1]   62     jrne parse01
                                     63 ; at end of line 
      008972 72 5D 00 01      [ 1]   64     tnz mode 
      008976 27 E0            [ 1]   65     jreq cli 
      008978 CD 89 D0         [ 4]   66     call exam_block 
      00897B 20 DB            [ 2]   67     jra cli 
      00897D                         68 parse01:
      00897D A1 52            [ 1]   69     cp a,#'R 
      00897F 26 03            [ 1]   70     jrne 4$
      000901                         71     _ldxz xamadr   
      008981 BE 02                    1     .byte 0xbe,xamadr 
      008983 FD               [ 4]   72     call (x) ; run program 
      008984 A1 3A            [ 1]   73 4$: cp a,#':
      008986 26 05            [ 1]   74     jrne 5$ 
      008988 CD 89 B6         [ 4]   75     call modify 
      00898B 20 CB            [ 2]   76     jra cli     
      00898D                         77 5$:
      00898D A1 2E            [ 1]   78     cp a,#'. 
      00898F 26 08            [ 1]   79     jrne 8$ 
      008991 72 5D 00 01      [ 1]   80     tnz mode 
      008995 27 C1            [ 1]   81     jreq cli ; here mode should be set to 1 
      008997 20 D2            [ 2]   82     jra next_char 
      008999                         83 8$: 
      008999 A1 20            [ 1]   84     cp a,#SPACE 
      00899B 2B CE            [ 1]   85     jrmi next_char ; skip separator and invalids characters  
      00899D CD 89 F7         [ 4]   86     call parse_hex ; maybe an hexadecimal number 
      0089A0 4D               [ 1]   87     tnz a ; unknown token ignore rest of line
      0089A1 27 B5            [ 1]   88     jreq cli 
      0089A3 72 5D 00 01      [ 1]   89     tnz mode 
      0089A7 27 05            [ 1]   90     jreq 9$
      0089A9 CD 89 D0         [ 4]   91     call exam_block
      0089AC 20 BD            [ 2]   92     jra next_char
      0089AE                         93 9$:
      00092E                         94     _strxz xamadr 
      0089AE BF 02                    1     .byte 0xbf,xamadr 
      000930                         95     _strxz storadr
      0089B0 BF 04                    1     .byte 0xbf,storadr 
      000932                         96     _incz mode
      0089B2 3C 01                    1     .byte 0x3c, mode 
      0089B4 20 B5            [ 2]   97     jra next_char 
                                     98 
                                     99 ;-------------------------------------
                                    100 ; modify RAM or peripheral register 
                                    101 ; read byte list from input buffer
                                    102 ;--------------------------------------
      0089B6                        103 modify:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



      0089B6                        104 1$: 
                                    105 ; skip spaces 
      000936                        106     _next_char 
      0089B6 90 F6            [ 1]    1     ld a,(y)
      0089B8 90 5C            [ 1]    2     incw y 
      0089BA A1 20            [ 1]  107     cp a,#SPACE 
      0089BC 27 F8            [ 1]  108     jreq 1$ 
      0089BE CD 89 F7         [ 4]  109     call parse_hex
      0089C1 4D               [ 1]  110     tnz a 
      0089C2 27 09            [ 1]  111     jreq 9$ 
      0089C4 9F               [ 1]  112     ld a,xl 
      000945                        113     _ldxz storadr 
      0089C5 BE 04                    1     .byte 0xbe,storadr 
      0089C7 F7               [ 1]  114     ld (x),a 
      0089C8 5C               [ 1]  115     incw x 
      000949                        116     _strxz storadr
      0089C9 BF 04                    1     .byte 0xbf,storadr 
      0089CB 20 E9            [ 2]  117     jra 1$ 
      00094D                        118 9$: _clrz mode 
      0089CD 3F 01                    1     .byte 0x3f, mode 
      0089CF 81               [ 4]  119     ret 
                                    120 
                                    121 ;-------------------------------------------
                                    122 ; display memory in range 'xamadr'...'last' 
                                    123 ;-------------------------------------------    
                           000001   124     ROW_SIZE=1
                           000001   125     VSIZE=1
      0089D0                        126 exam_block:
      000950                        127     _vars VSIZE
      0089D0 52 01            [ 2]    1     sub sp,#VSIZE 
      000952                        128     _ldxz xamadr
      0089D2 BE 02                    1     .byte 0xbe,xamadr 
      0089D4                        129 new_row: 
      0089D4 A6 08            [ 1]  130     ld a,#8
      0089D6 6B 01            [ 1]  131     ld (ROW_SIZE,sp),a ; bytes per row 
      0089D8 A6 0D            [ 1]  132     ld a,#CR 
      0089DA CD 8A 7B         [ 4]  133     call putchar 
      0089DD CD 8A 22         [ 4]  134     call print_adr ; display address and first byte of row 
      0089E0 CD 8A 2A         [ 4]  135     call print_mem ; display byte at address  
      0089E3                        136 row:
      0089E3 5C               [ 1]  137     incw x 
      0089E4 C3 00 06         [ 2]  138     cpw x,last 
      0089E7 22 09            [ 1]  139     jrugt 9$ 
      0089E9 0A 01            [ 1]  140     dec (ROW_SIZE,sp)
      0089EB 27 E7            [ 1]  141     jreq new_row  
      0089ED CD 8A 2A         [ 4]  142     call print_mem  
      0089F0 20 F1            [ 2]  143     jra row 
      0089F2                        144 9$:
      000972                        145     _clrz mode 
      0089F2 3F 01                    1     .byte 0x3f, mode 
      000974                        146     _drop VSIZE 
      0089F4 5B 01            [ 2]    1     addw sp,#VSIZE 
      0089F6 81               [ 4]  147     ret  
                                    148 
                                    149 ;----------------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



                                    150 ; parse hexadecimal number 
                                    151 ; from input buffer 
                                    152 ; input:
                                    153 ;    A   first character 
                                    154 ;    Y   pointer to TIB 
                                    155 ; output: 
                                    156 ;    X     number 
                                    157 ;    Y     point after number 
                                    158 ;-----------------------------      
      0089F7                        159 parse_hex:
      0089F7 4B 00            [ 1]  160     push #0 ; digits count 
      0089F9 5F               [ 1]  161     clrw x
      0089FA                        162 1$:    
      0089FA A8 30            [ 1]  163     xor a,#0x30
      0089FC A1 0A            [ 1]  164     cp a,#10 
      0089FE 2B 06            [ 1]  165     jrmi 2$   ; 0..9 
      008A00 A1 71            [ 1]  166     cp a,#0x71
      008A02 2B 15            [ 1]  167     jrmi 9$
      008A04 A0 67            [ 1]  168     sub a,#0x67  
      008A06 4B 04            [ 1]  169 2$: push #4
      008A08 4E               [ 1]  170     swap a 
      008A09                        171 3$:
      008A09 48               [ 1]  172     sll a 
      008A0A 59               [ 2]  173     rlcw x 
      008A0B 0A 01            [ 1]  174     dec (1,sp)
      008A0D 26 FA            [ 1]  175     jrne 3$
      008A0F 84               [ 1]  176     pop a
      008A10 0C 01            [ 1]  177     inc (1,sp) ; digits count  
      000992                        178     _next_char 
      008A12 90 F6            [ 1]    1     ld a,(y)
      008A14 90 5C            [ 1]    2     incw y 
      008A16 4D               [ 1]  179     tnz a 
      008A17 26 E1            [ 1]  180     jrne 1$
      008A19                        181 9$: ; end of hex number
      008A19 90 5A            [ 2]  182     decw y  ; put back last character  
      008A1B 84               [ 1]  183     pop a 
      008A1C 4D               [ 1]  184     tnz a 
      008A1D 27 02            [ 1]  185     jreq 10$
      00099F                        186     _strxz last 
      008A1F BF 06                    1     .byte 0xbf,last 
      008A21                        187 10$:
      008A21 81               [ 4]  188     ret 
                                    189 
                                    190 ;-----------------------------------
                                    191 ;  print address in xamadr variable
                                    192 ;  followed by ': '  
                                    193 ;  input: 
                                    194 ;    X     address to print 
                                    195 ;  output:
                                    196 ;   X      not modified 
                                    197 ;-------------------------------------
      008A22                        198 print_adr: 
      008A22 AD 0F            [ 4]  199     callr print_word 
      008A24 A6 3A            [ 1]  200     ld a,#': 
      008A26 AD 53            [ 4]  201     callr putchar 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



      008A28 20 04            [ 2]  202     jra space
                                    203 
                                    204 ;-------------------------------------
                                    205 ;  print byte at memory location 
                                    206 ;  pointed by X followed by ' ' 
                                    207 ;  input:
                                    208 ;     X     memory address 
                                    209 ;  output:
                                    210 ;    X      not modified 
                                    211 ;-------------------------------------
      008A2A                        212 print_mem:
      008A2A F6               [ 1]  213     ld a,(x) 
      008A2B CD 8A 3C         [ 4]  214     call print_byte 
                                    215     
                                    216 
                                    217 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    218 ;;     TERMIO 
                                    219 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    220 
                                    221 ;--------------------------------
                                    222 ; print blank space 
                                    223 ;-------------------------------
      008A2E                        224 space:
      008A2E A6 20            [ 1]  225     ld a,#SPACE 
      008A30 AD 49            [ 4]  226     callr putchar 
      008A32 81               [ 4]  227     ret 
                                    228 
                                    229 ;-------------------------------
                                    230 ;  print hexadecimal number 
                                    231 ; input:
                                    232 ;    X  number to print 
                                    233 ; output:
                                    234 ;    none 
                                    235 ;--------------------------------
      008A33                        236 print_word: 
      008A33 9E               [ 1]  237     ld a,xh
      008A34 CD 8A 3C         [ 4]  238     call print_byte 
      008A37 9F               [ 1]  239     ld a,xl 
      008A38 CD 8A 3C         [ 4]  240     call print_byte 
      008A3B 81               [ 4]  241     ret 
                                    242 
                                    243 ;---------------------
                                    244 ; print byte value 
                                    245 ; in hexadecimal 
                                    246 ; input:
                                    247 ;    A   value to print 
                                    248 ; output:
                                    249 ;    none 
                                    250 ;-----------------------
      008A3C                        251 print_byte:
      008A3C 88               [ 1]  252     push a 
      008A3D 4E               [ 1]  253     swap a 
      008A3E CD 8A 42         [ 4]  254     call print_digit 
      008A41 84               [ 1]  255     pop a 
                                    256 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



                                    257 ;-------------------------
                                    258 ; print lower nibble 
                                    259 ; as digit 
                                    260 ; input:
                                    261 ;    A     hex digit to print
                                    262 ; output:
                                    263 ;   none:
                                    264 ;---------------------------
      008A42                        265 print_digit: 
      008A42 A4 0F            [ 1]  266     and a,#15 
      008A44 AB 30            [ 1]  267     add a,#'0 
      008A46 A1 3A            [ 1]  268     cp a,#'9+1 
      008A48 2B 02            [ 1]  269     jrmi 1$
      008A4A AB 07            [ 1]  270     add a,#7 
      008A4C                        271 1$:
      008A4C CD 8A 7B         [ 4]  272     call putchar 
      008A4F                        273 9$:
      008A4F 81               [ 4]  274     ret 
                                    275 
                                    276 
                                    277 ;---------------------------------
                                    278 ; Query for character in rx1_queue
                                    279 ; input:
                                    280 ;   none 
                                    281 ; output:
                                    282 ;   A     0 no charcter available
                                    283 ;   Z     1 no character available
                                    284 ;---------------------------------
      008A50                        285 uart_qgetc:
      0009D0                        286 	_ldaz rx1_head 
      008A50 B6 35                    1     .byte 0xb6,rx1_head 
      008A52 C0 00 36         [ 1]  287 	sub a,rx1_tail 
      008A55 81               [ 4]  288 	ret 
                                    289 
                                    290 ;---------------------------------
                                    291 ; wait character from UART 
                                    292 ; input:
                                    293 ;   none
                                    294 ; output:
                                    295 ;   A 			char  
                                    296 ;--------------------------------	
      008A56                        297 uart_getc::
      008A56 CD 8A 50         [ 4]  298 	call uart_qgetc
      008A59 27 FB            [ 1]  299 	jreq uart_getc 
      008A5B 89               [ 2]  300 	pushw x 
      0009DC                        301 	_clrz acc16 
      008A5C 3F 10                    1     .byte 0x3f, acc16 
      0009DE                        302     _movz acc8,rx1_head 
      008A5E 45 35 11                 1     .byte 0x45,rx1_head,acc8 
      008A61 AE 00 25         [ 2]  303     ldw x,#rx1_queue
      0009E4                        304 	_ldaz rx1_head 
      008A64 B6 35                    1     .byte 0xb6,rx1_head 
      008A66 4C               [ 1]  305 	inc a 
      008A67 A4 0F            [ 1]  306 	and a,#RX_QUEUE_SIZE-1
      0009E9                        307 	_straz rx1_head 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



      008A69 B7 35                    1     .byte 0xb7,rx1_head 
      008A6B 72 D6 00 10      [ 4]  308 	ld a,([acc16],x)
      008A6F A1 61            [ 1]  309 	cp a,#'a 
      008A71 2B 06            [ 1]  310     jrmi 2$ 
      008A73 A1 7B            [ 1]  311     cp a,#'z+1 
      008A75 2A 02            [ 1]  312     jrpl 2$
      008A77 A4 DF            [ 1]  313 	and a,#0xDF ; uppercase letter 
      008A79                        314 2$:
      008A79 85               [ 2]  315 	popw x
      008A7A 81               [ 4]  316 	ret 
                                    317 
                                    318 
                                    319 ;---------------------------------------
                                    320 ; send character to terminal 
                                    321 ; input:
                                    322 ;    A    character to send 
                                    323 ; output:
                                    324 ;    none 
                                    325 ;----------------------------------------    
      008A7B                        326 putchar:
      008A7B 72 0F 52 30 FB   [ 2]  327     btjf UART_SR,#UART_SR_TXE,. 
      008A80 C7 52 31         [ 1]  328     ld UART_DR,a 
      008A83 81               [ 4]  329     ret 
                                    330 
                                    331 ;------------------------------------
                                    332 ;  read text line from terminal 
                                    333 ;  put it in tib buffer 
                                    334 ;  CR to terminale input.
                                    335 ;  BS to deleter character left 
                                    336 ;  input:
                                    337 ;   none 
                                    338 ;  output:
                                    339 ;    tib      input line ASCIZ no CR  
                                    340 ;-------------------------------------
      008A84                        341 getline:
      008A84 90 AE 00 37      [ 2]  342     ldw y,#tib 
      008A88                        343 1$:
      008A88 90 7F            [ 1]  344     clr (y) 
      008A8A AD CA            [ 4]  345     callr uart_getc 
      008A8C A1 0D            [ 1]  346     cp a,#CR 
      008A8E 27 1F            [ 1]  347     jreq 9$ 
      008A90 A1 08            [ 1]  348     cp a,#BS 
      008A92 26 04            [ 1]  349     jrne 2$
      008A94 AD 1C            [ 4]  350     callr delback 
      008A96 20 F0            [ 2]  351     jra 1$ 
      008A98                        352 2$: 
      008A98 A1 1B            [ 1]  353     cp a,#ESC 
      008A9A 26 07            [ 1]  354     jrne 3$
      008A9C 90 AE 00 37      [ 2]  355     ldw y,#tib
      008AA0 90 7F            [ 1]  356     clr(y)
      008AA2 81               [ 4]  357     ret 
      008AA3                        358 3$:    
      008AA3 A1 20            [ 1]  359     cp a,#SPACE 
      008AA5 2B E1            [ 1]  360     jrmi 1$  ; ignore others control char 
      008AA7 AD D2            [ 4]  361     callr putchar
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



      008AA9 90 F7            [ 1]  362     ld (y),a 
      008AAB 90 5C            [ 1]  363     incw y 
      008AAD 20 D9            [ 2]  364     jra 1$
      008AAF AD CA            [ 4]  365 9$: callr putchar 
      008AB1 81               [ 4]  366     ret 
                                    367 
                                    368 ;-----------------------------------
                                    369 ; delete character left of cursor 
                                    370 ; decrement Y 
                                    371 ; input:
                                    372 ;   none 
                                    373 ; output:
                                    374 ;   none 
                                    375 ;-----------------------------------
      008AB2                        376 delback:
      008AB2 90 A3 00 37      [ 2]  377     cpw y,#tib 
      008AB6 27 0C            [ 1]  378     jreq 9$     
      008AB8 AD C1            [ 4]  379     callr putchar ; backspace 
      008ABA A6 20            [ 1]  380     ld a,#SPACE    
      008ABC AD BD            [ 4]  381     callr putchar ; overwrite with space 
      008ABE A6 08            [ 1]  382     ld a,#BS 
      008AC0 AD B9            [ 4]  383     callr putchar ;  backspace
      008AC2 90 5A            [ 2]  384     decw y
      008AC4                        385 9$:
      008AC4 81               [ 4]  386     ret 
                                    387 
                                    388 
                                    389 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    390 ;;   UART subroutines
                                    391 ;;   used for user interface 
                                    392 ;;   communication channel.
                                    393 ;;   settings: 
                                    394 ;;		115200 8N1 no flow control
                                    395 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    396 
                                    397 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    398 ;;; Uart intterrupt handler 
                                    399 ;;; on receive character 
                                    400 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    401 ;--------------------------
                                    402 ; UART receive character
                                    403 ; in a FIFO buffer 
                                    404 ; CTRL+X reboot system 
                                    405 ;--------------------------
      008AC5                        406 UartRxHandler: ; console receive char 
      008AC5 72 0B 52 30 2B   [ 2]  407 	btjf UART_SR,#UART_SR_RXNE,5$ 
      008ACA C6 52 31         [ 1]  408 	ld a,UART_DR 
      008ACD A1 03            [ 1]  409 	cp a,#CTRL_C 
      008ACF 26 09            [ 1]  410 	jrne 2$ 
      008AD1 AE 89 58         [ 2]  411 	ldw x,#cli  
      008AD4 0F 07            [ 1]  412 	clr (7,sp)
      008AD6 1F 08            [ 2]  413 	ldw (8,sp),x 
      008AD8 20 1B            [ 2]  414 	jra 5$
      008ADA                        415 2$:
      008ADA A1 18            [ 1]  416 	cp a,#CAN ; CTRL_X 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



      008ADC 26 04            [ 1]  417 	jrne 3$
      000A5E                        418 	_swreset 	
      008ADE 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
      008AE2 88               [ 1]  419 3$:	push a 
      008AE3 A6 25            [ 1]  420 	ld a,#rx1_queue 
      008AE5 CB 00 36         [ 1]  421 	add a,rx1_tail 
      008AE8 5F               [ 1]  422 	clrw x 
      008AE9 97               [ 1]  423 	ld xl,a 
      008AEA 84               [ 1]  424 	pop a 
      008AEB F7               [ 1]  425 	ld (x),a 
      008AEC C6 00 36         [ 1]  426 	ld a,rx1_tail 
      008AEF 4C               [ 1]  427 	inc a 
      008AF0 A4 0F            [ 1]  428 	and a,#RX_QUEUE_SIZE-1
      008AF2 C7 00 36         [ 1]  429 	ld rx1_tail,a 
      008AF5 80               [11]  430 5$:	iret 
                                    431 
                                    432 
                                    433 ;---------------------------------------------
                                    434 ; initialize UART, 115200 8N1
                                    435 ; called from cold_start in hardware_init.asm 
                                    436 ; input:
                                    437 ;	none
                                    438 ; output:
                                    439 ;   none
                                    440 ;---------------------------------------------
      008AF6                        441 uart_init:
                                    442 ; enable UART clock
      008AF6 72 16 50 C7      [ 1]  443 	bset CLK_PCKENR1,#UART_PCKEN 	
      008AFA 72 11 52 30      [ 1]  444 	bres UART,#UART_CR1_PIEN
                                    445 ; baud rate 115200
                                    446 ; BRR value = 16Mhz/115200 ; 139 (0x8b) 
      008AFE A6 0B            [ 1]  447 	ld a,#0xb
      008B00 C7 52 33         [ 1]  448 	ld UART_BRR2,a 
      008B03 A6 08            [ 1]  449 	ld a,#0x8 
      008B05 C7 52 32         [ 1]  450 	ld UART_BRR1,a 
      008B08                        451 3$:
      008B08 72 5F 52 31      [ 1]  452     clr UART_DR
      008B0C 35 2C 52 35      [ 1]  453 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
      008B10 72 10 52 35      [ 1]  454 	bset UART_CR2,#UART_CR2_SBK
      008B14 72 0D 52 30 FB   [ 2]  455     btjf UART_SR,#UART_SR_TC,.
      008B19 72 5F 00 35      [ 1]  456     clr rx1_head 
      008B1D 72 5F 00 36      [ 1]  457 	clr rx1_tail
      008B21 72 10 52 30      [ 1]  458 	bset UART,#UART_CR1_PIEN
      008B25 81               [ 4]  459 	ret
                                    460 
                                    461 .endif ; DEBUG
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]



                                      1 
                                      2 ;-------------------------
                                      3 ; temperature sensor demo 
                                      4 ; using MCP9701-E/TO 
                                      5 ;-------------------------
                           000190     6 ZERO_OFS=400 ; Vout offset at 0 degr.  400mV 
                           0000C3     7 SLOPE10=195 ; 10x19.5mv/degr. C sensor slope   
                           000021     8 VREF10=33 ; ADC Vref*10 
                                      9 
                           000001    10     XSAVE=1
                           000003    11     REPCNT=3
                           000003    12     VAR_SIZE=3
      008B26                         13 app:
      000AA6                         14     _vars VAR_SIZE 
      008B26 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      000AA8                         15     _led_on 
      008B28 72 14 50 0F      [ 1]    1     bset LED_PORT+GPIO_ODR,#LED_BIT 
      008B2C CD 81 31         [ 4]   16     call beep
      000AAF                         17     _led_off 
      008B2F 72 15 50 0F      [ 1]    1     bres LED_PORT+GPIO_ODR,#LED_BIT
      008B33 CD 83 5F         [ 4]   18     call oled_init 
      008B36 CD 87 5A         [ 4]   19     call display_clear 
      008B39 A6 00            [ 1]   20     ld a,#SMALL  
      008B3B CD 86 BA         [ 4]   21     call select_font 
      008B3E 90 AE 8B F7      [ 2]   22     ldw y,#prompt 
      008B42 CD 88 0F         [ 4]   23     call put_string 
      008B45 A6 01            [ 1]   24     ld a,#BIG 
      008B47 CD 86 BA         [ 4]   25     call select_font 
      008B4A 72 16 54 02      [ 1]   26     bset ADC_CR2,#ADC_CR2_ALIGN 
      008B4E 72 10 54 01      [ 1]   27     bset ADC_CR1,#ADC_CR1_ADON 
      008B52 A6 0A            [ 1]   28     ld a,#10 ; ADC wake up delay  
      008B54 CD 80 E2         [ 4]   29     call pause 
      008B57 35 04 54 00      [ 1]   30     mov ADC_CSR,#ADC_CHANNEL
      008B5B                         31 1$: ; start conversion 
      008B5B 72 10 54 01      [ 1]   32     bset ADC_CR1,#ADC_CR1_ADON 
      008B5F 72 0F 54 00 FB   [ 2]   33     btjf ADC_CSR,#ADC_CSR_EOC,. 
      008B64 72 1F 54 00      [ 1]   34     bres ADC_CSR,#ADC_CSR_EOC
      008B68 A6 03            [ 1]   35     ld a,#3
      008B6A 6B 03            [ 1]   36     ld (REPCNT,sp),a 
      008B6C C6 54 05         [ 1]   37     ld a,ADC_DRL
      008B6F 97               [ 1]   38     ld xl,a 
      008B70 C6 54 04         [ 1]   39     ld a,ADC_DRH 
      008B73 95               [ 1]   40     ld xh,a 
      008B74 A6 21            [ 1]   41     ld a,#VREF10 ; 3.3*10 ref. voltage 
      008B76 CD 8B E7         [ 4]   42     call mul16x8
      008B79 90 AE 04 00      [ 2]   43     ldw y,#1024 
      008B7D 65               [ 2]   44     divw x,y
      008B7E                         45 2$:
      008B7E A6 0A            [ 1]   46     ld a,#10
      008B80 CD 8B E7         [ 4]   47     call mul16x8  
      008B83 1F 01            [ 2]   48     ldw (XSAVE,sp),x
      008B85 0A 03            [ 1]   49     dec (REPCNT,sp)
      008B87 27 10            [ 1]   50     jreq 4$    
      008B89 93               [ 1]   51     ldw x,y
      008B8A A6 0A            [ 1]   52     ld a,#10 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]



      008B8C CD 8B E7         [ 4]   53     call mul16x8  
      008B8F 90 AE 04 00      [ 2]   54     ldw y,#1024 
      008B93 65               [ 2]   55     divw x,y
      008B94 72 FB 01         [ 2]   56     addw x,(XSAVE,sp)
      008B97 20 E5            [ 2]   57     jra 2$ 
      008B99                         58 4$:  
      008B99 1E 01            [ 2]   59     ldw x,(XSAVE,sp)
      008B9B 1D 0F A0         [ 2]   60     subw x,#ZERO_OFS*10      
      008B9E A6 C3            [ 1]   61     ld a,#SLOPE10 
      008BA0 62               [ 2]   62     div x,a
      008BA1 90 58            [ 2]   63     sllw y 
      008BA3 90 A3 00 C3      [ 2]   64     cpw y,#SLOPE10 
      008BA7 2B 01            [ 1]   65     jrmi 5$
      008BA9 5C               [ 1]   66     incw x
      008BAA                         67 5$:
                           000000    68 MEGA_FONT=0
                           000000    69 .if MEGA_FONT
                                     70     call itoa
                                     71     ldw x,#0x304
                                     72     call put_mega_string
                                     73     ldw y,#celcius 
                                     74     ldw x,#0x0334
                                     75     call put_mega_string  
                           000001    76 .else 
      008BAA 89               [ 2]   77     pushw x  
      008BAB CD 88 24         [ 4]   78     call itoa
      008BAE A6 02            [ 1]   79     ld a,#2 
      000B30                         80     _straz line
      008BB0 B7 1D                    1     .byte 0xb7,line 
      008BB2 A6 02            [ 1]   81     ld a,#2 
      000B34                         82     _straz col  
      008BB4 B7 1E                    1     .byte 0xb7,col 
      008BB6 CD 88 0F         [ 4]   83     call put_string 
      008BB9 90 AE 8C 1C      [ 2]   84     ldw y,#celcius 
      008BBD CD 88 0F         [ 4]   85     call put_string 
      008BC0 85               [ 2]   86     popw x 
      008BC1 A6 09            [ 1]   87     ld a,#9
      008BC3 42               [ 4]   88     mul x,a 
      008BC4 A6 05            [ 1]   89     ld a,#5 
      008BC6 62               [ 2]   90     div x,a 
      008BC7 1C 00 20         [ 2]   91     addw x,#32
      008BCA CD 88 24         [ 4]   92     call itoa 
      008BCD A6 03            [ 1]   93     ld a,#3 
      000B4F                         94     _straz line
      008BCF B7 1D                    1     .byte 0xb7,line 
      008BD1 A6 02            [ 1]   95     ld a,#2 
      000B53                         96     _straz col  
      008BD3 B7 1E                    1     .byte 0xb7,col 
      008BD5 CD 88 0F         [ 4]   97     call put_string 
      008BD8 90 AE 8C 1F      [ 2]   98     ldw y,#fahrenheit
      008BDC CD 88 0F         [ 4]   99     call put_string 
                                    100 .endif 
      008BDF A6 32            [ 1]  101     ld a,#50 
      008BE1 CD 80 E2         [ 4]  102     call pause 
      008BE4 CC 8B 5B         [ 2]  103     jp 1$  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]



                                    104 
                                    105 
                                    106 ;------------------------
                                    107 ; input:
                                    108 ;    x   
                                    109 ;    a 
                                    110 ; output:
                                    111 ;    X   X*A 
                                    112 ;------------------------
      008BE7                        113 mul16x8:
      000B67                        114     _strxz acc16 
      008BE7 BF 10                    1     .byte 0xbf,acc16 
      008BE9 42               [ 4]  115     mul x,a 
      008BEA 89               [ 2]  116     pushw x 
      000B6B                        117     _ldxz acc16 
      008BEB BE 10                    1     .byte 0xbe,acc16 
      008BED 5E               [ 1]  118     swapw x 
      008BEE 42               [ 4]  119     mul x,a 
      008BEF 4F               [ 1]  120     clr a 
      008BF0 02               [ 1]  121     rlwa x 
      008BF1 72 FB 01         [ 2]  122     addw x,(1,sp)
      000B74                        123     _drop 2 
      008BF4 5B 02            [ 2]    1     addw sp,#2 
      008BF6 81               [ 4]  124     ret 
                                    125 
      008BF7 64 65 6D 6F 20 4D 43   126 prompt: .asciz "demo MCP9701 sensor\nroom temperature"
             50 39 37 30 31 20 73
             65 6E 73 6F 72 0A 72
             6F 6F 6D 20 74 65 6D
             70 65 72 61 74 75 72
             65 00
      008C1C 87 43 00               127 celcius: .byte DEGREE,'C',0  
      008C1F 87 46 00               128 fahrenheit: .byte DEGREE,'F',0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ACK     =  000006     |     ADC1_AWC=  00540E 
    ADC1_AWC=  00540F     |     ADC1_AWS=  00540C     |     ADC1_AWS=  00540D 
    ADC1_CR1=  005401     |     ADC1_CR1=  000000     |     ADC1_CR1=  000001 
    ADC1_CR1=  000004     |     ADC1_CR1=  000005     |     ADC1_CR1=  000006 
    ADC1_CR2=  005402     |     ADC1_CR2=  000003     |     ADC1_CR2=  000004 
    ADC1_CR2=  000005     |     ADC1_CR2=  000006     |     ADC1_CR2=  000001 
    ADC1_CR3=  005403     |     ADC1_CR3=  000007     |     ADC1_CR3=  000006 
    ADC1_CSR=  005400     |     ADC1_CSR=  000006     |     ADC1_CSR=  000004 
    ADC1_CSR=  000000     |     ADC1_CSR=  000001     |     ADC1_CSR=  000002 
    ADC1_CSR=  000003     |     ADC1_CSR=  000007     |     ADC1_CSR=  000005 
    ADC1_DB0=  0053E0     |     ADC1_DB0=  0053E1     |     ADC1_DB1=  0053E2 
    ADC1_DB1=  0053E3     |     ADC1_DB2=  0053E4     |     ADC1_DB2=  0053E5 
    ADC1_DB3=  0053E6     |     ADC1_DB3=  0053E7     |     ADC1_DB4=  0053E8 
    ADC1_DB4=  0053E9     |     ADC1_DB5=  0053EA     |     ADC1_DB5=  0053EB 
    ADC1_DB6=  0053EC     |     ADC1_DB6=  0053ED     |     ADC1_DB7=  0053EE 
    ADC1_DB7=  0053EF     |     ADC1_DB8=  0053F0     |     ADC1_DB8=  0053F1 
    ADC1_DB9=  0053F2     |     ADC1_DB9=  0053F3     |     ADC1_DRH=  005404 
    ADC1_DRL=  005405     |     ADC1_HTR=  005408     |     ADC1_HTR=  005409 
    ADC1_LTR=  00540A     |     ADC1_LTR=  00540B     |     ADC1_TDR=  005406 
    ADC1_TDR=  005407     |     ADC_CHAN=  000004     |     ADC_CR1 =  005401 
    ADC_CR1_=  000000     |     ADC_CR2 =  005402     |     ADC_CR2_=  000003 
    ADC_CR3 =  005403     |     ADC_CSR =  005400     |     ADC_CSR_=  000007 
    ADC_DRH =  005404     |     ADC_DRL =  005405     |     ADR_MODE=  000020 
    AFR     =  004803     |     AFR0    =  000000     |     AFR1    =  000001 
    AFR2    =  000002     |     AFR3    =  000003     |     AFR4    =  000004 
    AFR5    =  000005     |     AFR6    =  000006     |     AFR7    =  000007 
    ALL_KEY_=  0000BE     |     AWU_APR =  0050F1     |     AWU_CSR1=  0050F0 
    AWU_TBR =  0050F2     |     B115200 =  000006     |     B19200  =  000003 
    B230400 =  000007     |     B2400   =  000000     |     B38400  =  000004 
    B460800 =  000008     |     B4800   =  000001     |     B57600  =  000005 
    B921600 =  000009     |     B9600   =  000002     |     BEEP_CSR=  0050F3 
    BELL    =  000007     |     BIG     =  000001     |     BIG_CPL =  00000A 
    BIG_FONT=  000010     |     BIG_FONT=  000018     |     BIG_FONT=  00000C 
    BIG_LINE=  000004     |     BIT0    =  000000     |     BIT1    =  000001 
    BIT2    =  000002     |     BIT3    =  000003     |     BIT4    =  000004 
    BIT5    =  000005     |     BIT6    =  000006     |     BIT7    =  000007 
    BIT_CNT =  000001     |     BLOCK_SI=  000040     |     BS      =  000008 
    BTN_A   =  000001     |     BTN_B   =  000002     |     BTN_DOWN=  000005 
    BTN_IDR =  00500B     |     BTN_LEFT=  000007     |     BTN_PORT=  00500A 
    BTN_RIGH=  000004     |     BTN_UP  =  000003     |     BYTE    =  000005 
    BYTE_CNT=  000002     |     CAN     =  000018     |     CFG_GCR =  007F60 
    CHAR    =  000004     |     CLKOPT  =  004807     |     CLKOPT_C=  000002 
    CLKOPT_E=  000003     |     CLKOPT_P=  000000     |     CLKOPT_P=  000001 
    CLK_CCOR=  0050C9     |     CLK_CKDI=  0050C6     |     CLK_CKDI=  000000 
    CLK_CKDI=  000001     |     CLK_CKDI=  000002     |     CLK_CKDI=  000003 
    CLK_CKDI=  000004     |     CLK_CMSR=  0050C3     |     CLK_CSSR=  0050C8 
    CLK_ECKR=  0050C1     |     CLK_ECKR=  000000     |     CLK_ECKR=  000001 
    CLK_FREQ=  000004     |     CLK_FREQ=  0000D5     |     CLK_HSIT=  0050CC 
    CLK_ICKR=  0050C0     |     CLK_ICKR=  000002     |     CLK_ICKR=  000000 
    CLK_ICKR=  000001     |     CLK_ICKR=  000003     |     CLK_ICKR=  000004 
    CLK_ICKR=  000005     |     CLK_PCKE=  0050C7     |     CLK_PCKE=  000000 
    CLK_PCKE=  000001     |     CLK_PCKE=  000007     |     CLK_PCKE=  000005 
    CLK_PCKE=  000004     |     CLK_PCKE=  000003     |     CLK_PCKE=  0050CA 
    CLK_PCKE=  000003     |     CLK_PCKE=  000002     |     CLK_SWCR=  0050C5 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal [24-Bits]

Symbol Table

    CLK_SWCR=  000000     |     CLK_SWCR=  000001     |     CLK_SWCR=  000002 
    CLK_SWCR=  000003     |     CLK_SWIM=  0050CD     |     CLK_SWR =  0050C4 
    CLK_SWR_=  0000B4     |     CLK_SWR_=  0000E1     |     CLK_SWR_=  0000D2 
    COL     =  000002     |     COLON   =  00003A     |     COL_WND =  000021 
    COMMA   =  00002C     |     COM_ALTE=  000010     |     COM_CFG =  0000DA 
    COM_DISA=  000000     |     COM_ENAB=  000020     |     COM_SEQU=  000000 
    CPU_A   =  007F00     |     CPU_CCR =  007F0A     |     CPU_PCE =  007F01 
    CPU_PCH =  007F02     |     CPU_PCL =  007F03     |     CPU_SPH =  007F08 
    CPU_SPL =  007F09     |     CPU_XH  =  007F04     |     CPU_XL  =  007F05 
    CPU_YH  =  007F06     |     CPU_YL  =  007F07     |     CP_OFF  =  000010 
    CP_ON   =  000014     |     CR      =  00000D     |     CTRL_A  =  000001 
    CTRL_B  =  000002     |     CTRL_C  =  000003     |     CTRL_D  =  000004 
    CTRL_E  =  000005     |     CTRL_F  =  000006     |     CTRL_G  =  000007 
    CTRL_H  =  000008     |     CTRL_I  =  000009     |     CTRL_J  =  00000A 
    CTRL_K  =  00000B     |     CTRL_L  =  00000C     |     CTRL_M  =  00000D 
    CTRL_N  =  00000E     |     CTRL_O  =  00000F     |     CTRL_P  =  000010 
    CTRL_Q  =  000011     |     CTRL_R  =  000012     |     CTRL_S  =  000013 
    CTRL_T  =  000014     |     CTRL_U  =  000015     |     CTRL_V  =  000016 
    CTRL_W  =  000017     |     CTRL_X  =  000018     |     CTRL_Y  =  000019 
    CTRL_Z  =  00001A     |     DC1     =  000011     |     DC2     =  000012 
    DC3     =  000013     |     DC4     =  000014     |     DEBUG   =  000001 
    DEGREE  =  000087     |     DEVID_BA=  004865     |     DEVID_EN=  004870 
    DEVID_LO=  0048D2     |     DEVID_LO=  0048D3     |     DEVID_LO=  0048D4 
    DEVID_LO=  0048D5     |     DEVID_LO=  0048D6     |     DEVID_LO=  0048D7 
    DEVID_LO=  0048D8     |     DEVID_WA=  0048D1     |     DEVID_XH=  0048CE 
    DEVID_XL=  0048CD     |     DEVID_YH=  0048D0     |     DEVID_YL=  0048CF 
    DISPLAY_=  000080     |     DISP_ALL=  0000A5     |     DISP_CHA=  00008D 
    DISP_CON=  000081     |     DISP_DIV=  000000     |     DISP_HEI=  000040 
    DISP_INV=  0000A7     |     DISP_NOR=  0000A6     |     DISP_OFF=  0000AE 
    DISP_OFF=  0000D3     |     DISP_ON =  0000AF     |     DISP_RAM=  0000A4 
    DISP_WID=  000080     |     DLE     =  000010     |     DM_BK1RE=  007F90 
    DM_BK1RH=  007F91     |     DM_BK1RL=  007F92     |     DM_BK2RE=  007F93 
    DM_BK2RH=  007F94     |     DM_BK2RL=  007F95     |     DM_CR1  =  007F96 
    DM_CR2  =  007F97     |     DM_CSR1 =  007F98     |     DM_CSR2 =  007F99 
    DM_ENFCT=  007F9A     |     EEPROM_B=  004000     |     EEPROM_E=  00427F 
    EEPROM_S=  000280     |     EM      =  000019     |     ENQ     =  000005 
    EOF     =  00001A     |     EOT     =  000004     |     ESC     =  00001B 
    ETB     =  000017     |     ETX     =  000003     |     EXTI_CR1=  0050A0 
    EXTI_CR2=  0050A1     |     FF      =  00000C     |     FLASH_BA=  008000 
    FLASH_CR=  00505A     |     FLASH_CR=  000002     |     FLASH_CR=  000000 
    FLASH_CR=  000003     |     FLASH_CR=  000001     |     FLASH_CR=  00505B 
    FLASH_CR=  000005     |     FLASH_CR=  000004     |     FLASH_CR=  000007 
    FLASH_CR=  000000     |     FLASH_CR=  000006     |     FLASH_DU=  005064 
    FLASH_DU=  0000AE     |     FLASH_DU=  000056     |     FLASH_FP=  00505D 
    FLASH_FP=  000000     |     FLASH_FP=  000001     |     FLASH_FP=  000002 
    FLASH_FP=  000003     |     FLASH_FP=  000004     |     FLASH_FP=  000005 
    FLASH_IA=  00505F     |     FLASH_IA=  000003     |     FLASH_IA=  000002 
    FLASH_IA=  000006     |     FLASH_IA=  000001     |     FLASH_IA=  000000 
    FLASH_NC=  00505C     |     FLASH_NF=  00505E     |     FLASH_NF=  000000 
    FLASH_NF=  000001     |     FLASH_NF=  000002     |     FLASH_NF=  000003 
    FLASH_NF=  000004     |     FLASH_NF=  000005     |     FLASH_PU=  005062 
    FLASH_PU=  000056     |     FLASH_PU=  0000AE     |     FLASH_SI=  002000 
    FMSTR   =  000010     |     FR_T2_CL=  00F424     |     FS      =  00001C 
    F_BIG   =  000001     |     F_DISP_M=  000005     |     F_GAME_T=  000007 
    F_SCROLL=  000000     |     F_SOUND_=  000006     |     GPIO_BAS=  004000 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal [24-Bits]

Symbol Table

    GPIO_CR1=  000003     |     GPIO_CR2=  000004     |     GPIO_DDR=  000002 
    GPIO_END=  0057FF     |     GPIO_IDR=  000001     |     GPIO_ODR=  000000 
    GS      =  00001D     |     HORZ_MOD=  000000     |     HSECNT  =  004809 
    I2C_CCRH=  00521C     |     I2C_CCRH=  000080     |     I2C_CCRH=  0000C0 
    I2C_CCRH=  000080     |     I2C_CCRH=  000000     |     I2C_CCRH=  000001 
    I2C_CCRH=  000000     |     I2C_CCRL=  00521B     |     I2C_CCRL=  00001A 
    I2C_CCRL=  000002     |     I2C_CCRL=  00000D     |     I2C_CCRL=  000050 
    I2C_CCRL=  000090     |     I2C_CCRL=  0000A0     |     I2C_CR1 =  005210 
    I2C_CR1_=  000006     |     I2C_CR1_=  000007     |     I2C_CR1_=  000000 
    I2C_CR2 =  005211     |     I2C_CR2_=  000002     |     I2C_CR2_=  000003 
    I2C_CR2_=  000000     |     I2C_CR2_=  000001     |     I2C_CR2_=  000007 
    I2C_DR  =  005216     |     I2C_ERR_=  000003     |     I2C_ERR_=  000004 
    I2C_ERR_=  000000     |     I2C_ERR_=  000001     |     I2C_ERR_=  000002 
    I2C_ERR_=  000005     |     I2C_FAST=  000001     |     I2C_FREQ=  005212 
    I2C_ITR =  00521A     |     I2C_ITR_=  000002     |     I2C_ITR_=  000000 
    I2C_ITR_=  000001     |     I2C_OARH=  005214     |     I2C_OARH=  000001 
    I2C_OARH=  000002     |     I2C_OARH=  000006     |     I2C_OARH=  000007 
    I2C_OARL=  005213     |     I2C_OARL=  000000     |     I2C_OAR_=  000813 
    I2C_OAR_=  000009     |     I2C_PECR=  00521E     |     I2C_PORT=  005005 
    I2C_READ=  000001     |     I2C_SR1 =  005217     |     I2C_SR1_=  000003 
    I2C_SR1_=  000001     |     I2C_SR1_=  000002     |     I2C_SR1_=  000006 
    I2C_SR1_=  000000     |     I2C_SR1_=  000004     |     I2C_SR1_=  000007 
    I2C_SR2 =  005218     |     I2C_SR2_=  000002     |     I2C_SR2_=  000001 
    I2C_SR2_=  000000     |     I2C_SR2_=  000003     |     I2C_SR2_=  000005 
    I2C_SR3 =  005219     |     I2C_SR3_=  000001     |     I2C_SR3_=  000007 
    I2C_SR3_=  000004     |     I2C_SR3_=  000000     |     I2C_SR3_=  000002 
    I2C_STAT=  000007     |     I2C_STAT=  000006     |     I2C_STD =  000000 
    I2C_TRIS=  00521D     |     I2C_TRIS=  000005     |     I2C_TRIS=  000005 
    I2C_TRIS=  000005     |     I2C_TRIS=  000011     |     I2C_TRIS=  000011 
    I2C_TRIS=  000011     |     I2C_WRIT=  000000     |   7 I2cIntHa   00018B R
    INPUT_DI=  000000     |     INPUT_EI=  000001     |     INPUT_FL=  000000 
    INPUT_PU=  000001     |     INT_ADC1=  000016     |     INT_AWU =  000001 
    INT_CLK =  000002     |     INT_EXTI=  000003     |     INT_EXTI=  000004 
    INT_EXTI=  000005     |     INT_EXTI=  000006     |     INT_EXTI=  000007 
    INT_FLAS=  000018     |     INT_I2C =  000013     |     INT_RES1=  000008 
    INT_RES2=  000009     |     INT_RES3=  00000F     |     INT_RES4=  000010 
    INT_RES5=  000014     |     INT_RES6=  000015     |     INT_SPI =  00000A 
    INT_TIM1=  00000C     |     INT_TIM1=  00000B     |     INT_TIM2=  00000E 
    INT_TIM2=  00000D     |     INT_TIM4=  000017     |     INT_TLI =  000000 
    INT_UART=  000012     |     INT_UART=  000011     |     INT_VECT=  008060 
    INT_VECT=  00800C     |     INT_VECT=  008010     |     INT_VECT=  008014 
    INT_VECT=  008018     |     INT_VECT=  00801C     |     INT_VECT=  008020 
    INT_VECT=  008024     |     INT_VECT=  008068     |     INT_VECT=  008054 
    INT_VECT=  008000     |     INT_VECT=  008030     |     INT_VECT=  008038 
    INT_VECT=  008034     |     INT_VECT=  008040     |     INT_VECT=  00803C 
    INT_VECT=  008064     |     INT_VECT=  008008     |     INT_VECT=  008004 
    INT_VECT=  008050     |     INT_VECT=  00804C     |     IPR0    =  000002 
    IPR1    =  000001     |     IPR2    =  000000     |     IPR3    =  000003 
    IPR_MASK=  000003     |     ITC_SPR1=  007F70     |     ITC_SPR2=  007F71 
    ITC_SPR3=  007F72     |     ITC_SPR4=  007F73     |     ITC_SPR5=  007F74 
    ITC_SPR6=  007F75     |     ITC_SPR7=  007F76     |     ITC_SPR8=  007F77 
    ITC_SPR_=  000001     |     ITC_SPR_=  000000     |     ITC_SPR_=  000003 
    IWDG_KR =  0050E0     |     IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2 
    KPAD    =  000001     |     LED_BIT =  000002     |     LED_PORT=  00500F 
    LF      =  00000A     |     MAJOR   =  000001     |     MAP_SEG0=  0000A0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]

Symbol Table

    MAP_SEG0=  0000A1     |     MEGA_CPL=  000005     |     MEGA_FON=  000000 
    MEGA_FON=  000020     |     MEGA_FON=  000060     |     MEGA_FON=  000018 
    MEGA_LIN=  000002     |     MINOR   =  000001     |     MISCOPT =  004805 
    MISCOPT_=  000004     |     MISCOPT_=  000002     |     MISCOPT_=  000003 
    MISCOPT_=  000000     |     MISCOPT_=  000001     |     MUX_RATI=  0000A8 
    NAFR    =  004804     |     NAK     =  000015     |     NCLKOPT =  004808 
    NHSECNT =  00480A     |     NMISCOPT=  004806     |     NMISCOPT=  FFFFFFFB 
    NMISCOPT=  FFFFFFFD     |     NMISCOPT=  FFFFFFFC     |     NMISCOPT=  FFFFFFFF 
    NMISCOPT=  FFFFFFFE     |     NOP     =  000000     |     NOPT1   =  004802 
    NOPT2   =  004804     |     NOPT3   =  004806     |     NOPT4   =  004808 
    NOPT5   =  00480A     |     NUBC    =  004802     |   7 NonHandl   000000 R
    OLED_CMD=  000080     |     OLED_DAT=  000040     |     OLED_DEV=  000078 
    OLED_FON=  000008     |     OLED_FON=  000006     |     OLED_NOP=  0000E3 
    OPT0    =  004800     |     OPT1    =  004801     |     OPT2    =  004803 
    OPT3    =  004805     |     OPT4    =  004807     |     OPT5    =  004809 
    OPTION_B=  004800     |     OPTION_E=  00480A     |     OUTPUT_F=  000001 
    OUTPUT_O=  000000     |     OUTPUT_P=  000001     |     OUTPUT_S=  000000 
    PA      =  005000     |     PAGE    =  000001     |     PAGE_MOD=  000002 
    PAG_WND =  000022     |     PA_BASE =  005000     |     PA_CR1  =  005003 
    PA_CR2  =  005004     |     PA_DDR  =  005002     |     PA_IDR  =  005001 
    PA_ODR  =  005000     |     PB      =  005005     |     PB_BASE =  005005 
    PB_CR1  =  005008     |     PB_CR2  =  005009     |     PB_DDR  =  005007 
    PB_IDR  =  005006     |     PB_ODR  =  005005     |     PC      =  00500A 
    PC_BASE =  00500A     |     PC_CR1  =  00500D     |     PC_CR2  =  00500E 
    PC_DDR  =  00500C     |     PC_IDR  =  00500B     |     PC_ODR  =  00500A 
    PD      =  00500F     |     PD_BASE =  00500F     |     PD_CR1  =  005012 
    PD_CR2  =  005013     |     PD_DDR  =  005011     |     PD_IDR  =  005010 
    PD_ODR  =  00500F     |     PE      =  005014     |     PE_BASE =  005014 
    PE_CR1  =  005017     |     PE_CR2  =  005018     |     PE_DDR  =  005016 
    PE_IDR  =  005015     |     PE_ODR  =  005014     |     PF      =  005019 
    PF_BASE =  005019     |     PF_CR1  =  00501C     |     PF_CR2  =  00501D 
    PF_DDR  =  00501B     |     PF_IDR  =  00501A     |     PF_ODR  =  005019 
    PHASE1_P=  000000     |     PHASE2_P=  000004     |     PIN0    =  000000 
    PIN1    =  000001     |     PIN2    =  000002     |     PIN3    =  000003 
    PIN4    =  000004     |     PIN5    =  000005     |     PIN6    =  000006 
    PIN7    =  000007     |     PRE_CHAR=  0000D9     |     RAM_BASE=  000000 
    RAM_END =  0003FF     |     RAM_SIZE=  000400     |     READ    =  000001 
    REPCNT  =  000003     |     REV     =  000000     |     ROP     =  004800 
    ROW_SIZE=  000001     |     RS      =  00001E     |     RST_SR  =  0050B3 
    RX_QUEUE=  000010     |     S103    =  000001     |     S207    =  000000 
    SCAN_REV=  0000C8     |     SCAN_TOP=  0000C0     |     SCL_BIT =  000004 
    SCROLL_L=  000027     |     SCROLL_R=  000026     |     SCROLL_S=  00002F 
    SCROLL_S=  00002E     |     SCROLL_V=  00002A     |     SCROLL_V=  000029 
    SDA_BIT =  000005     |     SEMIC   =  00003B     |     SFR_BASE=  005000 
    SFR_END =  0057FF     |     SHARP   =  000023     |     SHIFT_CN=  000003 
    SI      =  00000F     |     SIGN    =  000001     |     SLOPE10 =  0000C3 
    SMALL   =  000000     |     SMALL_CP=  000015     |     SMALL_FO=  000008 
    SMALL_FO=  000006     |     SMALL_FO=  000006     |     SMALL_LI=  000008 
    SO      =  00000E     |     SOH     =  000001     |     SOUND_BI=  000004 
    SOUND_PO=  00500F     |     SPACE   =  000020     |     SPI_CR1 =  005200 
    SPI_CR2 =  005201     |     SPI_CRCP=  005205     |     SPI_DR  =  005204 
    SPI_ICR =  005202     |     SPI_RXCR=  005206     |     SPI_SR  =  005203 
    SPI_TXCR=  005207     |     STACK_EM=  0003FF     |     STACK_SI=  000080 
    START_LI=  000040     |     STORE   =  000002     |     STX     =  000002 
    SUB     =  00001A     |     SWIM_CSR=  007F80     |     SYN     =  000016 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal [24-Bits]

Symbol Table

    TAB     =  000009     |     TIB_SIZE=  000028     |     TICK    =  000027 
    TIM1_ARR=  005262     |     TIM1_ARR=  005263     |     TIM1_BKR=  00526D 
    TIM1_BKR=  000006     |     TIM1_BKR=  000004     |     TIM1_BKR=  000005 
    TIM1_BKR=  000000     |     TIM1_BKR=  000007     |     TIM1_BKR=  000002 
    TIM1_BKR=  000003     |     TIM1_CCE=  00525C     |     TIM1_CCE=  00525D 
    TIM1_CCM=  005258     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000003 
    TIM1_CCM=  005259     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000003 
    TIM1_CCM=  00525A     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000003 
    TIM1_CCM=  00525B     |     TIM1_CCM=  000000     |     TIM1_CCM=  000001 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000003 
    TIM1_CCM=  000007     |     TIM1_CCM=  000002     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000003 
    TIM1_CCR=  005265     |     TIM1_CCR=  005266     |     TIM1_CCR=  005267 
    TIM1_CCR=  005268     |     TIM1_CCR=  005269     |     TIM1_CCR=  00526A 
    TIM1_CCR=  00526B     |     TIM1_CCR=  00526C     |     TIM1_CNT=  00525E 
    TIM1_CNT=  00525F     |     TIM1_CR1=  005250     |     TIM1_CR2=  005251 
    TIM1_CR2=  000000     |     TIM1_CR2=  000002     |     TIM1_CR2=  000004 
    TIM1_CR2=  000005     |     TIM1_CR2=  000006     |     TIM1_DTR=  00526E 
    TIM1_EGR=  005257     |     TIM1_ETR=  005253     |     TIM1_ETR=  000006 
    TIM1_ETR=  000000     |     TIM1_ETR=  000001     |     TIM1_ETR=  000002 
    TIM1_ETR=  000003     |     TIM1_ETR=  000007     |     TIM1_ETR=  000004 
    TIM1_ETR=  000005     |     TIM1_IER=  005254     |     TIM1_IER=  000007 
    TIM1_IER=  000001     |     TIM1_IER=  000002     |     TIM1_IER=  000003 
    TIM1_IER=  000004     |     TIM1_IER=  000005     |     TIM1_IER=  000006 
    TIM1_IER=  000000     |     TIM1_OIS=  00526F     |     TIM1_OIS=  000000 
    TIM1_OIS=  000002     |     TIM1_OIS=  000004     |     TIM1_OIS=  000006 
    TIM1_OIS=  000001     |     TIM1_OIS=  000003     |     TIM1_OIS=  000005 
    TIM1_OIS=  000007     |     TIM1_PSC=  005260     |     TIM1_PSC=  005261 
    TIM1_RCR=  005264     |     TIM1_SMC=  005252     |     TIM1_SMC=  000007 
    TIM1_SMC=  000000     |     TIM1_SMC=  000001     |     TIM1_SMC=  000002 
    TIM1_SMC=  000004     |     TIM1_SMC=  000005     |     TIM1_SMC=  000006 
    TIM1_SR1=  005255     |     TIM1_SR1=  000007     |     TIM1_SR1=  000001 
    TIM1_SR1=  000002     |     TIM1_SR1=  000003     |     TIM1_SR1=  000004 
    TIM1_SR1=  000005     |     TIM1_SR1=  000006     |     TIM1_SR1=  000000 
    TIM1_SR2=  005256     |     TIM1_SR2=  000001     |     TIM1_SR2=  000002 
    TIM1_SR2=  000003     |     TIM1_SR2=  000004     |     TIM2_ARR=  00530F 
    TIM2_ARR=  005310     |     TIM2_CCE=  00530A     |     TIM2_CCE=  000000 
    TIM2_CCE=  000001     |     TIM2_CCE=  000004     |     TIM2_CCE=  000005 
    TIM2_CCE=  00530B     |     TIM2_CCM=  005307     |     TIM2_CCM=  005308 
    TIM2_CCM=  005309     |     TIM2_CCM=  000000     |     TIM2_CCM=  000004 
    TIM2_CCM=  000003     |     TIM2_CCR=  005311     |     TIM2_CCR=  005312 
    TIM2_CCR=  005313     |     TIM2_CCR=  005314     |     TIM2_CCR=  005315 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
Hexadecimal [24-Bits]

Symbol Table

    TIM2_CCR=  005316     |     TIM2_CLK=  00F424     |     TIM2_CNT=  00530C 
    TIM2_CNT=  00530D     |     TIM2_CR1=  005300     |     TIM2_CR1=  000007 
    TIM2_CR1=  000000     |     TIM2_CR1=  000003     |     TIM2_CR1=  000001 
    TIM2_CR1=  000002     |     TIM2_EGR=  005306     |     TIM2_EGR=  000001 
    TIM2_EGR=  000002     |     TIM2_EGR=  000003     |     TIM2_EGR=  000006 
    TIM2_EGR=  000000     |     TIM2_IER=  005303     |     TIM2_PSC=  00530E 
    TIM2_SR1=  005304     |     TIM2_SR2=  005305     |     TIM4_ARR=  005348 
    TIM4_CNT=  005346     |     TIM4_CR1=  005340     |     TIM4_CR1=  000007 
    TIM4_CR1=  000000     |     TIM4_CR1=  000003     |     TIM4_CR1=  000001 
    TIM4_CR1=  000002     |     TIM4_EGR=  005345     |     TIM4_EGR=  000000 
    TIM4_IER=  005343     |     TIM4_IER=  000000     |     TIM4_PSC=  005347 
    TIM4_PSC=  000000     |     TIM4_PSC=  000007     |     TIM4_PSC=  000004 
    TIM4_PSC=  000001     |     TIM4_PSC=  000005     |     TIM4_PSC=  000002 
    TIM4_PSC=  000006     |     TIM4_PSC=  000003     |     TIM4_PSC=  000000 
    TIM4_PSC=  000001     |     TIM4_PSC=  000002     |     TIM4_SR =  005344 
    TIM4_SR_=  000000     |     TIM_CCER=  000000     |     TIM_CCER=  000002 
    TIM_CCER=  000001     |     TIM_CCER=  000004     |     TIM_CCER=  000006 
    TIM_CCER=  000007     |     TIM_CCER=  000005     |     TIM_CCER=  000002 
    TIM_CCER=  000003     |     TIM_CCER=  000000     |     TIM_CCER=  000001 
    TIM_CCER=  000004     |     TIM_CCER=  000005     |     TIM_CR1_=  000007 
    TIM_CR1_=  000000     |     TIM_CR1_=  000006     |     TIM_CR1_=  000005 
    TIM_CR1_=  000004     |     TIM_CR1_=  000003     |     TIM_CR1_=  000001 
    TIM_CR1_=  000002     |     TIM_EGR_=  000007     |     TIM_EGR_=  000001 
    TIM_EGR_=  000002     |     TIM_EGR_=  000003     |     TIM_EGR_=  000004 
    TIM_EGR_=  000005     |     TIM_EGR_=  000006     |     TIM_EGR_=  000000 
    TIMx_CCR=  000000     |     TIMx_CCR=  000004     |     TIMx_CCR=  000003 
  7 Timer4Up   000001 R   |     UART    =  005230     |     UART1   =  005230 
    UART1_BR=  005232     |     UART1_BR=  005233     |     UART1_CR=  005234 
    UART1_CR=  005235     |     UART1_CR=  005236     |     UART1_CR=  005237 
    UART1_CR=  005238     |     UART1_DR=  005231     |     UART1_GT=  005239 
    UART1_PO=  00900F     |     UART1_PS=  00523A     |     UART1_RX=  000003 
    UART1_SR=  005230     |     UART1_TX=  000002     |     UART_BRR=  005232 
    UART_BRR=  005233     |     UART_CR1=  000004     |     UART_CR1=  000002 
    UART_CR1=  000000     |     UART_CR1=  000001     |     UART_CR1=  000007 
    UART_CR1=  000006     |     UART_CR1=  000005     |     UART_CR1=  000003 
    UART_CR2=  005235     |     UART_CR2=  000004     |     UART_CR2=  000002 
    UART_CR2=  000005     |     UART_CR2=  000001     |     UART_CR2=  000000 
    UART_CR2=  000006     |     UART_CR2=  000003     |     UART_CR2=  000007 
    UART_CR3=  000003     |     UART_CR3=  000001     |     UART_CR3=  000002 
    UART_CR3=  000000     |     UART_CR3=  000006     |     UART_CR3=  000004 
    UART_CR3=  000005     |     UART_CR4=  000000     |     UART_CR4=  000001 
    UART_CR4=  000002     |     UART_CR4=  000003     |     UART_CR4=  000004 
    UART_CR4=  000006     |     UART_CR4=  000005     |     UART_CR5=  000003 
    UART_CR5=  000001     |     UART_CR5=  000002     |     UART_CR5=  000004 
    UART_CR5=  000005     |     UART_DR =  005231     |     UART_PCK=  000003 
    UART_SR =  005230     |     UART_SR_=  000001     |     UART_SR_=  000004 
    UART_SR_=  000002     |     UART_SR_=  000003     |     UART_SR_=  000000 
    UART_SR_=  000005     |     UART_SR_=  000006     |     UART_SR_=  000007 
    UBC     =  004801     |     US      =  00001F     |   7 UartRxHa   000A45 R
    VAR_SIZE=  000003     |     VCOMH_DS=  0000DB     |     VCOMH_DS=  000000 
    VCOMH_DS=  000020     |     VCOMH_DS=  000030     |     VERT_MOD=  000001 
    VERT_SCR=  0000A3     |     VREF10  =  000021     |     VSIZE   =  000001 
    VT      =  00000B     |     WANT_TER=  000001     |     WWDG_CR =  0050D1 
    WWDG_WR =  0050D2     |     XOFF    =  000013     |     XON     =  000011 
    XSAVE   =  000001     |     YSAVE   =  000006     |     ZERO_OFS=  000190 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 90.
Hexadecimal [24-Bits]

Symbol Table

  5 acc16      000010 GR  |   5 acc8       000011 GR  |   7 all_disp   00035D R
  7 app        000AA6 R   |   7 beep       0000B1 R   |   7 blink      00024F R
  7 blink0     000247 R   |   7 blink1     00024C R   |   7 celcius    000B9C R
  7 clear_di   0006CB R   |   7 cli        0008D8 R   |   7 clock_in   00002F R
  7 cmove      0007F3 R   |   6 co_code    000100 R   |   5 col        00001E R
  7 cold_sta   000146 R   |   5 count      00005F R   |   5 cpl        00001F R
  7 crlf       000711 R   |   7 cursor_r   00072C R   |   5 delay_ti   00000A R
  7 delback    000A32 R   |   6 disp_buf   000101 R   |   5 disp_fla   000024 R
  5 disp_lin   000020 R   |   7 display_   0006DA R   |   7 end_of_t   0001F8 R
  7 evt_addr   0001D1 R   |   7 evt_btf    0001EC R   |   7 evt_rxne   000205 R
  7 evt_sb     0001CB R   |   7 evt_stop   000220 R   |   7 evt_txe    0001D7 R
  7 evt_txe_   0001DC R   |   7 exam_blo   000950 R   |   7 fahrenhe   000B9F R
  7 fast       000298 R   |   5 flags      000014 GR  |   5 font_hei   000022 R
  5 font_wid   000021 R   |   6 free_ram   000181 R   |   2 free_ram   00037E R
  7 getline    000A04 R   |   5 i2c_buf    000015 R   |   5 i2c_coun   000017 R
  5 i2c_devi   00001C R   |   7 i2c_erro   000234 R   |   5 i2c_idx    000019 R
  7 i2c_init   0002A9 R   |   7 i2c_scl_   000282 R   |   7 i2c_scl_   0002A4 R
  7 i2c_star   0002C8 R   |   5 i2c_stat   00001B R   |   7 i2c_writ   00026A R
  7 itoa       0007A4 R   |   7 key        00011B R   |   4 last       000005 R
  5 line       00001D R   |   7 line_cle   0006B3 R   |   7 line_win   000699 R
  4 mode       000000 R   |   7 modify     000936 R   |   7 mul16x8    000B67 R
  7 new_row    000954 R   |   7 next_cha   0008EB R   |   7 nibble_l   00023C R
  7 oled_cmd   000399 R   |   7 oled_dat   0003B5 R   |   7 oled_fon   0003CA R
  7 oled_fon   00063A R   |   7 oled_ini   0002DF GR  |   7 parse01    0008FD R
  7 parse_he   000977 R   |   7 pause      000062 R   |   7 print_ad   0009A2 R
  7 print_by   0009BC R   |   7 print_di   0009C2 R   |   7 print_me   0009AA R
  7 print_wo   0009B3 R   |   7 prng       0000E4 GR  |   7 prompt     000B77 R
  5 ptr16      000012 GR  |   5 ptr8       000013 R   |   7 put_byte   0007D6 R
  7 put_char   00073B R   |   7 put_hex    0007DC R   |   7 put_hex_   0007EA R
  7 put_int    0007CB R   |   7 put_mega   000847 R   |   7 put_mega   0008BC R
  7 put_stri   00078F R   |   7 putchar    0009FB R   |   7 row        000963 R
  5 rx1_head   000035 R   |   5 rx1_queu   000025 R   |   5 rx1_tail   000036 R
  7 scroll_u   0006FB R   |   5 seedx      00000C R   |   5 seedy      00000E R
  7 select_f   00063A R   |   7 set_seed   000106 R   |   7 set_wind   00037C R
  7 sll_xy_3   0000D6 R   |   7 sound_pa   00006F R   |   5 sound_ti   00000B R
  7 space      0009AE R   |   7 srl_xy_3   0000DD R   |   2 stack_fu   00037E R
  2 stack_un   0003FE R   |   7 std        00028A R   |   4 storadr    000003 R
  5 tib        000037 R   |   5 ticks      000008 R   |   7 timer2_i   00004D R
  7 timer4_i   000034 R   |   5 to_send    000023 R   |   7 tone       000088 R
  7 uart_get   0009D6 GR  |   7 uart_ini   000A76 R   |   7 uart_qge   0009D0 R
  7 wait_key   000121 R   |   4 xamadr     000001 R   |   7 xor_seed   0000BA R
  7 zoom_cha   000804 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 91.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      7   flags    8
   5 DATA1      size     58   flags    8
   6 DATA2      size     81   flags    8
   7 CODE       size    BA2   flags    0

