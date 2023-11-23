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
                           000000    10 	MINOR=0
                           000000    11 	REV=0
                                     12 
                                     13 ; master clock frequency in Mhz 
                           000010    14 	FMSTR=16 
                                     15 
                           000000    16 DEBUG=0 ; set to 0 for final version 
                                     17 
                           000001    18 WANT_TERMINAL=1 ; to have support for usart terminal  
                                     19 
                           000010    20 RX_QUEUE_SIZE=16
                           000028    21 TIB_SIZE=40
                                     22 
                           00500F    23 SOUND_PORT=PD_BASE 
                           000004    24 SOUND_BIT=4 
                                     25 
                           00500A    26 BTN_PORT=PC_BASE 
                           00500B    27 BTN_IDR=PC_IDR
                           000001    28 BTN_A=1
                           000002    29 BTN_B=2
                           000003    30 BTN_UP=3 
                           000004    31 BTN_RIGHT=4
                           000005    32 BTN_DOWN=5
                           000007    33 BTN_LEFT=7
                                     34 
                           0000BE    35 ALL_KEY_UP=(1<<BTN_A)|(1<<BTN_B)|(1<<BTN_UP)|(1<<BTN_DOWN)|(1<<BTN_LEFT)|(1<<BTN_RIGHT)
                                     36 
                                     37 ;------------------------
                                     38 ; beep on pin CN3:13 
                                     39 ; use TIM2_CH1 
                                     40 ;-------------------------
                                     41 
                                     42 ; I2C port on pin 11,12 
                           000005    43 	I2C_PORT=PB 
                           000004    44 	SCL_BIT=4
                           000005    45 	SDA_BIT=5
                                     46 
                                     47 ; ss1306 device ID 
                           000078    48 	OLED_DEVID = 0x78 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 3.
Hexadecimal [24-Bits]



                                     49 	.include "inc/ascii.inc"
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



                                     50     .include "inc/stm8s207.inc"
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022 
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
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; 2022/11/14
                                     20 ; STM8S207K8 µC registers map
                                     21 ; sdas source file
                                     22 ; author: Jacques Deschênes, copyright 2018,2019,2022
                                     23 ; licence: GPLv3
                                     24 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     25 
                                     26 ;;;;;;;;;;;
                                     27 ; bits
                                     28 ;;;;;;;;;;;;
                           000000    29  BIT0 = 0
                           000001    30  BIT1 = 1
                           000002    31  BIT2 = 2
                           000003    32  BIT3 = 3
                           000004    33  BIT4 = 4
                           000005    34  BIT5 = 5
                           000006    35  BIT6 = 6
                           000007    36  BIT7 = 7
                                     37  	
                                     38 ;;;;;;;;;;;;
                                     39 ; bits masks
                                     40 ;;;;;;;;;;;;
                           000001    41  B0_MASK = (1<<0)
                           000002    42  B1_MASK = (1<<1)
                           000004    43  B2_MASK = (1<<2)
                           000008    44  B3_MASK = (1<<3)
                           000010    45  B4_MASK = (1<<4)
                           000020    46  B5_MASK = (1<<5)
                           000040    47  B6_MASK = (1<<6)
                           000080    48  B7_MASK = (1<<7)
                                     49 
                                     50 ; HSI oscillator frequency 16Mhz
                           F42400    51  FHSI = 16000000
                                     52 ; LSI oscillator frequency 128Khz
                           01F400    53  FLSI = 128000 
                                     54 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 6.
Hexadecimal [24-Bits]



                                     55 ; controller memory regions
                           001800    56  RAM_SIZE = (0x1800) ; 6KB 
                           000400    57  EEPROM_SIZE = (0x400) ; 1KB
                                     58 ; STM8S207K8 have 64K flash
                           010000    59  FLASH_SIZE = (0x10000)
                                     60 ; erase block size 
                           000080    61 BLOCK_SIZE=128 ; bytes 
                                     62 
                           000000    63  RAM_BASE = (0)
                           0017FF    64  RAM_END = (RAM_BASE+RAM_SIZE-1)
                           004000    65  EEPROM_BASE = (0x4000)
                           0043FF    66  EEPROM_END = (EEPROM_BASE+EEPROM_SIZE-1)
                           005000    67  SFR_BASE = (0x5000)
                           0057FF    68  SFR_END = (0x57FF)
                           006000    69  BOOT_ROM_BASE = (0x6000)
                           007FFF    70  BOOT_ROM_END = (0x7fff)
                           008000    71  FLASH_BASE = (0x8000)
                           017FFF    72  FLASH_END = (FLASH_BASE+FLASH_SIZE-1)
                           004800    73  OPTION_BASE = (0x4800)
                           000080    74  OPTION_SIZE = (0x80)
                           00487F    75  OPTION_END = (OPTION_BASE+OPTION_SIZE-1)
                           0048CD    76  DEVID_BASE = (0x48CD)
                           0048D8    77  DEVID_END = (0x48D8)
                           007F00    78  DEBUG_BASE = (0X7F00)
                           007FFF    79  DEBUG_END = (0X7FFF)
                                     80 
                                     81 ; options bytes
                                     82 ; this one can be programmed only from SWIM  (ICP)
                           004800    83  OPT0  = (0x4800)
                                     84 ; these can be programmed at runtime (IAP)
                           004801    85  OPT1  = (0x4801)
                           004802    86  NOPT1  = (0x4802)
                           004803    87  OPT2  = (0x4803)
                           004804    88  NOPT2  = (0x4804)
                           004805    89  OPT3  = (0x4805)
                           004806    90  NOPT3  = (0x4806)
                           004807    91  OPT4  = (0x4807)
                           004808    92  NOPT4  = (0x4808)
                           004809    93  OPT5  = (0x4809)
                           00480A    94  NOPT5  = (0x480A)
                           00480B    95  OPT6  = (0x480B)
                           00480C    96  NOPT6 = (0x480C)
                           00480D    97  OPT7 = (0x480D)
                           00480E    98  NOPT7 = (0x480E)
                           00487E    99  OPTBL  = (0x487E)
                           00487F   100  NOPTBL  = (0x487F)
                                    101 ; option registers usage
                                    102 ; read out protection, value 0xAA enable ROP
                           004800   103  ROP = OPT0  
                                    104 ; user boot code, {0..0x3e} 512 bytes row
                           004801   105  UBC = OPT1
                           004802   106  NUBC = NOPT1
                                    107 ; alternate function register
                           004803   108  AFR = OPT2
                           004804   109  NAFR = NOPT2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 7.
Hexadecimal [24-Bits]



                                    110 ; miscelinous options
                           004805   111  WDGOPT = OPT3
                           004806   112  NWDGOPT = NOPT3
                                    113 ; clock options
                           004807   114  CLKOPT = OPT4
                           004808   115  NCLKOPT = NOPT4
                                    116 ; HSE clock startup delay
                           004809   117  HSECNT = OPT5
                           00480A   118  NHSECNT = NOPT5
                                    119 ; flash wait state
                           00480D   120 FLASH_WS = OPT7
                           00480E   121 NFLASH_WS = NOPT7
                                    122 
                                    123 ; watchdog options bits
                           000003   124   WDGOPT_LSIEN   =  BIT3
                           000002   125   WDGOPT_IWDG_HW =  BIT2
                           000001   126   WDGOPT_WWDG_HW =  BIT1
                           000000   127   WDGOPT_WWDG_HALT = BIT0
                                    128 ; NWDGOPT bits
                           FFFFFFFC   129   NWDGOPT_LSIEN    = ~BIT3
                           FFFFFFFD   130   NWDGOPT_IWDG_HW  = ~BIT2
                           FFFFFFFE   131   NWDGOPT_WWDG_HW  = ~BIT1
                           FFFFFFFF   132   NWDGOPT_WWDG_HALT = ~BIT0
                                    133 
                                    134 ; CLKOPT bits
                           000003   135  CLKOPT_EXT_CLK  = BIT3
                           000002   136  CLKOPT_CKAWUSEL = BIT2
                           000001   137  CLKOPT_PRS_C1   = BIT1
                           000000   138  CLKOPT_PRS_C0   = BIT0
                                    139 
                                    140 ; AFR option, remapable functions
                           000007   141  AFR7_BEEP    = BIT7
                           000006   142  AFR6_I2C     = BIT6
                           000005   143  AFR5_TIM1    = BIT5
                           000004   144  AFR4_TIM1    = BIT4
                           000003   145  AFR3_TIM1    = BIT3
                           000002   146  AFR2_CCO     = BIT2
                           000001   147  AFR1_TIM2    = BIT1
                           000000   148  AFR0_ADC     = BIT0
                                    149 
                                    150 ; device ID = (read only)
                           0048CD   151  DEVID_XL  = (0x48CD)
                           0048CE   152  DEVID_XH  = (0x48CE)
                           0048CF   153  DEVID_YL  = (0x48CF)
                           0048D0   154  DEVID_YH  = (0x48D0)
                           0048D1   155  DEVID_WAF  = (0x48D1)
                           0048D2   156  DEVID_LOT0  = (0x48D2)
                           0048D3   157  DEVID_LOT1  = (0x48D3)
                           0048D4   158  DEVID_LOT2  = (0x48D4)
                           0048D5   159  DEVID_LOT3  = (0x48D5)
                           0048D6   160  DEVID_LOT4  = (0x48D6)
                           0048D7   161  DEVID_LOT5  = (0x48D7)
                           0048D8   162  DEVID_LOT6  = (0x48D8)
                                    163 
                                    164 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 8.
Hexadecimal [24-Bits]



                           005000   165 GPIO_BASE = (0x5000)
                           000005   166 GPIO_SIZE = (5)
                                    167 ; PORTS SFR OFFSET
                           000000   168 PA = 0
                           000005   169 PB = 5
                           00000A   170 PC = 10
                           00000F   171 PD = 15
                           000014   172 PE = 20
                           000019   173 PF = 25
                           00001E   174 PG = 30
                           000023   175 PH = 35 
                           000028   176 PI = 40 
                                    177 
                                    178 ; GPIO
                                    179 ; gpio register offset to base
                           000000   180  GPIO_ODR = 0
                           000001   181  GPIO_IDR = 1
                           000002   182  GPIO_DDR = 2
                           000003   183  GPIO_CR1 = 3
                           000004   184  GPIO_CR2 = 4
                           005000   185  GPIO_BASE=(0X5000)
                                    186  
                                    187 ; port A
                           005000   188  PA_BASE = (0X5000)
                           005000   189  PA_ODR  = (0x5000)
                           005001   190  PA_IDR  = (0x5001)
                           005002   191  PA_DDR  = (0x5002)
                           005003   192  PA_CR1  = (0x5003)
                           005004   193  PA_CR2  = (0x5004)
                                    194 ; port B
                           005005   195  PB_BASE = (0X5005)
                           005005   196  PB_ODR  = (0x5005)
                           005006   197  PB_IDR  = (0x5006)
                           005007   198  PB_DDR  = (0x5007)
                           005008   199  PB_CR1  = (0x5008)
                           005009   200  PB_CR2  = (0x5009)
                                    201 ; port C
                           00500A   202  PC_BASE = (0X500A)
                           00500A   203  PC_ODR  = (0x500A)
                           00500B   204  PC_IDR  = (0x500B)
                           00500C   205  PC_DDR  = (0x500C)
                           00500D   206  PC_CR1  = (0x500D)
                           00500E   207  PC_CR2  = (0x500E)
                                    208 ; port D
                           00500F   209  PD_BASE = (0X500F)
                           00500F   210  PD_ODR  = (0x500F)
                           005010   211  PD_IDR  = (0x5010)
                           005011   212  PD_DDR  = (0x5011)
                           005012   213  PD_CR1  = (0x5012)
                           005013   214  PD_CR2  = (0x5013)
                                    215 ; port E
                           005014   216  PE_BASE = (0X5014)
                           005014   217  PE_ODR  = (0x5014)
                           005015   218  PE_IDR  = (0x5015)
                           005016   219  PE_DDR  = (0x5016)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 9.
Hexadecimal [24-Bits]



                           005017   220  PE_CR1  = (0x5017)
                           005018   221  PE_CR2  = (0x5018)
                                    222 ; port F
                           005019   223  PF_BASE = (0X5019)
                           005019   224  PF_ODR  = (0x5019)
                           00501A   225  PF_IDR  = (0x501A)
                           00501B   226  PF_DDR  = (0x501B)
                           00501C   227  PF_CR1  = (0x501C)
                           00501D   228  PF_CR2  = (0x501D)
                                    229 ; port G
                           00501E   230  PG_BASE = (0X501E)
                           00501E   231  PG_ODR  = (0x501E)
                           00501F   232  PG_IDR  = (0x501F)
                           005020   233  PG_DDR  = (0x5020)
                           005021   234  PG_CR1  = (0x5021)
                           005022   235  PG_CR2  = (0x5022)
                                    236 ; port H not present on LQFP48/LQFP64 package
                           005023   237  PH_BASE = (0X5023)
                           005023   238  PH_ODR  = (0x5023)
                           005024   239  PH_IDR  = (0x5024)
                           005025   240  PH_DDR  = (0x5025)
                           005026   241  PH_CR1  = (0x5026)
                           005027   242  PH_CR2  = (0x5027)
                                    243 ; port I ; only bit 0 on LQFP64 package, not present on LQFP48
                           005028   244  PI_BASE = (0X5028)
                           005028   245  PI_ODR  = (0x5028)
                           005029   246  PI_IDR  = (0x5029)
                           00502A   247  PI_DDR  = (0x502a)
                           00502B   248  PI_CR1  = (0x502b)
                           00502C   249  PI_CR2  = (0x502c)
                                    250 
                                    251 ; input modes CR1
                           000000   252  INPUT_FLOAT = (0) ; no pullup resistor
                           000001   253  INPUT_PULLUP = (1)
                                    254 ; output mode CR1
                           000000   255  OUTPUT_OD = (0) ; open drain
                           000001   256  OUTPUT_PP = (1) ; push pull
                                    257 ; input modes CR2
                           000000   258  INPUT_DI = (0)
                           000001   259  INPUT_EI = (1)
                                    260 ; output speed CR2
                           000000   261  OUTPUT_SLOW = (0)
                           000001   262  OUTPUT_FAST = (1)
                                    263 
                                    264 
                                    265 ; Flash memory
                           000080   266  BLOCK_SIZE=128 
                           00505A   267  FLASH_CR1  = (0x505A)
                           00505B   268  FLASH_CR2  = (0x505B)
                           00505C   269  FLASH_NCR2  = (0x505C)
                           00505D   270  FLASH_FPR  = (0x505D)
                           00505E   271  FLASH_NFPR  = (0x505E)
                           00505F   272  FLASH_IAPSR  = (0x505F)
                           005062   273  FLASH_PUKR  = (0x5062)
                           005064   274  FLASH_DUKR  = (0x5064)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 10.
Hexadecimal [24-Bits]



                                    275 ; data memory unlock keys
                           0000AE   276  FLASH_DUKR_KEY1 = (0xae)
                           000056   277  FLASH_DUKR_KEY2 = (0x56)
                                    278 ; flash memory unlock keys
                           000056   279  FLASH_PUKR_KEY1 = (0x56)
                           0000AE   280  FLASH_PUKR_KEY2 = (0xae)
                                    281 ; FLASH_CR1 bits
                           000003   282  FLASH_CR1_HALT = BIT3
                           000002   283  FLASH_CR1_AHALT = BIT2
                           000001   284  FLASH_CR1_IE = BIT1
                           000000   285  FLASH_CR1_FIX = BIT0
                                    286 ; FLASH_CR2 bits
                           000007   287  FLASH_CR2_OPT = BIT7
                           000006   288  FLASH_CR2_WPRG = BIT6
                           000005   289  FLASH_CR2_ERASE = BIT5
                           000004   290  FLASH_CR2_FPRG = BIT4
                           000000   291  FLASH_CR2_PRG = BIT0
                                    292 ; FLASH_FPR bits
                           000005   293  FLASH_FPR_WPB5 = BIT5
                           000004   294  FLASH_FPR_WPB4 = BIT4
                           000003   295  FLASH_FPR_WPB3 = BIT3
                           000002   296  FLASH_FPR_WPB2 = BIT2
                           000001   297  FLASH_FPR_WPB1 = BIT1
                           000000   298  FLASH_FPR_WPB0 = BIT0
                                    299 ; FLASH_NFPR bits
                           000005   300  FLASH_NFPR_NWPB5 = BIT5
                           000004   301  FLASH_NFPR_NWPB4 = BIT4
                           000003   302  FLASH_NFPR_NWPB3 = BIT3
                           000002   303  FLASH_NFPR_NWPB2 = BIT2
                           000001   304  FLASH_NFPR_NWPB1 = BIT1
                           000000   305  FLASH_NFPR_NWPB0 = BIT0
                                    306 ; FLASH_IAPSR bits
                           000006   307  FLASH_IAPSR_HVOFF = BIT6
                           000003   308  FLASH_IAPSR_DUL = BIT3
                           000002   309  FLASH_IAPSR_EOP = BIT2
                           000001   310  FLASH_IAPSR_PUL = BIT1
                           000000   311  FLASH_IAPSR_WR_PG_DIS = BIT0
                                    312 
                                    313 ; Interrupt control
                           0050A0   314  EXTI_CR1  = (0x50A0)
                           0050A1   315  EXTI_CR2  = (0x50A1)
                                    316 
                                    317 ; Reset Status
                           0050B3   318  RST_SR  = (0x50B3)
                                    319 
                                    320 ; Clock Registers
                           0050C0   321  CLK_ICKR  = (0x50c0)
                           0050C1   322  CLK_ECKR  = (0x50c1)
                           0050C3   323  CLK_CMSR  = (0x50C3)
                           0050C4   324  CLK_SWR  = (0x50C4)
                           0050C5   325  CLK_SWCR  = (0x50C5)
                           0050C6   326  CLK_CKDIVR  = (0x50C6)
                           0050C7   327  CLK_PCKENR1  = (0x50C7)
                           0050C8   328  CLK_CSSR  = (0x50C8)
                           0050C9   329  CLK_CCOR  = (0x50C9)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 11.
Hexadecimal [24-Bits]



                           0050CA   330  CLK_PCKENR2  = (0x50CA)
                           0050CC   331  CLK_HSITRIMR  = (0x50CC)
                           0050CD   332  CLK_SWIMCCR  = (0x50CD)
                                    333 
                                    334 ; Peripherals clock gating
                                    335 ; CLK_PCKENR1 
                           000007   336  CLK_PCKENR1_TIM1 = (7)
                           000006   337  CLK_PCKENR1_TIM3 = (6)
                           000005   338  CLK_PCKENR1_TIM2 = (5)
                           000004   339  CLK_PCKENR1_TIM4 = (4)
                           000003   340  CLK_PCKENR1_UART3 = (3)
                           000002   341  CLK_PCKENR1_UART1 = (2)
                           000001   342  CLK_PCKENR1_SPI = (1)
                           000000   343  CLK_PCKENR1_I2C = (0)
                                    344 ; CLK_PCKENR2
                           000007   345  CLK_PCKENR2_CAN = (7)
                           000003   346  CLK_PCKENR2_ADC = (3)
                           000002   347  CLK_PCKENR2_AWU = (2)
                                    348 
                                    349 ; Clock bits
                           000005   350  CLK_ICKR_REGAH = (5)
                           000004   351  CLK_ICKR_LSIRDY = (4)
                           000003   352  CLK_ICKR_LSIEN = (3)
                           000002   353  CLK_ICKR_FHW = (2)
                           000001   354  CLK_ICKR_HSIRDY = (1)
                           000000   355  CLK_ICKR_HSIEN = (0)
                                    356 
                           000001   357  CLK_ECKR_HSERDY = (1)
                           000000   358  CLK_ECKR_HSEEN = (0)
                                    359 ; clock source
                           0000E1   360  CLK_SWR_HSI = 0xE1
                           0000D2   361  CLK_SWR_LSI = 0xD2
                           0000B4   362  CLK_SWR_HSE = 0xB4
                                    363 
                           000003   364  CLK_SWCR_SWIF = (3)
                           000002   365  CLK_SWCR_SWIEN = (2)
                           000001   366  CLK_SWCR_SWEN = (1)
                           000000   367  CLK_SWCR_SWBSY = (0)
                                    368 
                           000004   369  CLK_CKDIVR_HSIDIV1 = (4)
                           000003   370  CLK_CKDIVR_HSIDIV0 = (3)
                           000002   371  CLK_CKDIVR_CPUDIV2 = (2)
                           000001   372  CLK_CKDIVR_CPUDIV1 = (1)
                           000000   373  CLK_CKDIVR_CPUDIV0 = (0)
                                    374 
                                    375 ; Watchdog
                           0050D1   376  WWDG_CR  = (0x50D1)
                           0050D2   377  WWDG_WR  = (0x50D2)
                           0050E0   378  IWDG_KR  = (0x50E0)
                           0050E1   379  IWDG_PR  = (0x50E1)
                           0050E2   380  IWDG_RLR  = (0x50E2)
                           0000CC   381  IWDG_KEY_ENABLE = 0xCC  ; enable IWDG key 
                           0000AA   382  IWDG_KEY_REFRESH = 0xAA ; refresh counter key 
                           000055   383  IWDG_KEY_ACCESS = 0x55 ; write register key 
                                    384  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 12.
Hexadecimal [24-Bits]



                           0050F0   385  AWU_CSR  = (0x50F0)
                           0050F1   386  AWU_APR  = (0x50F1)
                           0050F2   387  AWU_TBR  = (0x50F2)
                           000004   388  AWU_CSR_AWUEN = 4
                                    389 
                                    390 
                                    391 
                                    392 ; Beeper
                                    393 ; beeper output is alternate function AFR7 on PD4
                           0050F3   394  BEEP_CSR  = (0x50F3)
                           00000F   395  BEEP_PORT = PD
                           000004   396  BEEP_BIT = 4
                           000010   397  BEEP_MASK = B4_MASK
                                    398 
                                    399 ; SPI
                           005200   400  SPI_CR1  = (0x5200)
                           005201   401  SPI_CR2  = (0x5201)
                           005202   402  SPI_ICR  = (0x5202)
                           005203   403  SPI_SR  = (0x5203)
                           005204   404  SPI_DR  = (0x5204)
                           005205   405  SPI_CRCPR  = (0x5205)
                           005206   406  SPI_RXCRCR  = (0x5206)
                           005207   407  SPI_TXCRCR  = (0x5207)
                                    408 
                                    409 ; SPI_CR1 bit fields 
                           000000   410   SPI_CR1_CPHA=0
                           000001   411   SPI_CR1_CPOL=1
                           000002   412   SPI_CR1_MSTR=2
                           000003   413   SPI_CR1_BR=3
                           000006   414   SPI_CR1_SPE=6
                           000007   415   SPI_CR1_LSBFIRST=7
                                    416   
                                    417 ; SPI_CR2 bit fields 
                           000000   418   SPI_CR2_SSI=0
                           000001   419   SPI_CR2_SSM=1
                           000002   420   SPI_CR2_RXONLY=2
                           000004   421   SPI_CR2_CRCNEXT=4
                           000005   422   SPI_CR2_CRCEN=5
                           000006   423   SPI_CR2_BDOE=6
                           000007   424   SPI_CR2_BDM=7  
                                    425 
                                    426 ; SPI_SR bit fields 
                           000000   427   SPI_SR_RXNE=0
                           000001   428   SPI_SR_TXE=1
                           000003   429   SPI_SR_WKUP=3
                           000004   430   SPI_SR_CRCERR=4
                           000005   431   SPI_SR_MODF=5
                           000006   432   SPI_SR_OVR=6
                           000007   433   SPI_SR_BSY=7
                                    434 
                                    435 ; I2C
                           005210   436  I2C_BASE_ADDR = 0x5210 
                           005210   437  I2C_CR1  = (0x5210)
                           005211   438  I2C_CR2  = (0x5211)
                           005212   439  I2C_FREQR  = (0x5212)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 13.
Hexadecimal [24-Bits]



                           005213   440  I2C_OARL  = (0x5213)
                           005214   441  I2C_OARH  = (0x5214)
                           005216   442  I2C_DR  = (0x5216)
                           005217   443  I2C_SR1  = (0x5217)
                           005218   444  I2C_SR2  = (0x5218)
                           005219   445  I2C_SR3  = (0x5219)
                           00521A   446  I2C_ITR  = (0x521A)
                           00521B   447  I2C_CCRL  = (0x521B)
                           00521C   448  I2C_CCRH  = (0x521C)
                           00521D   449  I2C_TRISER  = (0x521D)
                           00521E   450  I2C_PECR  = (0x521E)
                                    451 
                           000007   452  I2C_CR1_NOSTRETCH = (7)
                           000006   453  I2C_CR1_ENGC = (6)
                           000000   454  I2C_CR1_PE = (0)
                                    455 
                           000007   456  I2C_CR2_SWRST = (7)
                           000003   457  I2C_CR2_POS = (3)
                           000002   458  I2C_CR2_ACK = (2)
                           000001   459  I2C_CR2_STOP = (1)
                           000000   460  I2C_CR2_START = (0)
                                    461 
                           000000   462  I2C_OARL_ADD0 = (0)
                                    463 
                           000009   464  I2C_OAR_ADDR_7BIT = ((I2C_OARL & 0xFE) >> 1)
                           000813   465  I2C_OAR_ADDR_10BIT = (((I2C_OARH & 0x06) << 9) | (I2C_OARL & 0xFF))
                                    466 
                           000007   467  I2C_OARH_ADDMODE = (7)
                           000006   468  I2C_OARH_ADDCONF = (6)
                           000002   469  I2C_OARH_ADD9 = (2)
                           000001   470  I2C_OARH_ADD8 = (1)
                                    471 
                           000007   472  I2C_SR1_TXE = (7)
                           000006   473  I2C_SR1_RXNE = (6)
                           000004   474  I2C_SR1_STOPF = (4)
                           000003   475  I2C_SR1_ADD10 = (3)
                           000002   476  I2C_SR1_BTF = (2)
                           000001   477  I2C_SR1_ADDR = (1)
                           000000   478  I2C_SR1_SB = (0)
                                    479 
                           000005   480  I2C_SR2_WUFH = (5)
                           000003   481  I2C_SR2_OVR = (3)
                           000002   482  I2C_SR2_AF = (2)
                           000001   483  I2C_SR2_ARLO = (1)
                           000000   484  I2C_SR2_BERR = (0)
                                    485 
                           000007   486  I2C_SR3_DUALF = (7)
                           000004   487  I2C_SR3_GENCALL = (4)
                           000002   488  I2C_SR3_TRA = (2)
                           000001   489  I2C_SR3_BUSY = (1)
                           000000   490  I2C_SR3_MSL = (0)
                                    491 
                           000002   492  I2C_ITR_ITBUFEN = (2)
                           000001   493  I2C_ITR_ITEVTEN = (1)
                           000000   494  I2C_ITR_ITERREN = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 14.
Hexadecimal [24-Bits]



                                    495 
                           000007   496  I2C_CCRH_FAST = 7 
                           000006   497  I2C_CCRH_DUTY = 6 
                                    498  
                                    499 ; Precalculated values, all in KHz
                           000080   500  I2C_CCRH_16MHZ_FAST_400 = 0x80
                           00000D   501  I2C_CCRL_16MHZ_FAST_400 = 0x0D
                                    502 ;
                                    503 ; Fast I2C mode max rise time = 300ns
                                    504 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    505 ; TRISER = = (300/62.5) + 1 = floor(4.8) + 1 = 5.
                                    506 
                           000005   507  I2C_TRISER_16MHZ_FAST_400 = 0x05
                                    508 
                           0000C0   509  I2C_CCRH_16MHZ_FAST_320 = 0xC0
                           000002   510  I2C_CCRL_16MHZ_FAST_320 = 0x02
                           000005   511  I2C_TRISER_16MHZ_FAST_320 = 0x05
                                    512 
                           000080   513  I2C_CCRH_16MHZ_FAST_200 = 0x80
                           00001A   514  I2C_CCRL_16MHZ_FAST_200 = 0x1A
                           000005   515  I2C_TRISER_16MHZ_FAST_200 = 0x05
                                    516 
                           000000   517  I2C_CCRH_16MHZ_STD_100 = 0x00
                           000050   518  I2C_CCRL_16MHZ_STD_100 = 0x50
                                    519 
                           000000   520  I2C_STD = 0 
                           000001   521  I2C_FAST = 1 
                                    522 
                                    523 ; Standard I2C mode max rise time = 1000ns
                                    524 ; I2C_FREQR = 16 = (MHz) => tMASTER = 1/16 = 62.5 ns
                                    525 ; TRISER = = (1000/62.5) + 1 = floor(16) + 1 = 17.
                                    526 
                           000011   527  I2C_TRISER_16MHZ_STD_100 = 0x11
                                    528 
                           000000   529  I2C_CCRH_16MHZ_STD_50 = 0x00
                           0000A0   530  I2C_CCRL_16MHZ_STD_50 = 0xA0
                           000011   531  I2C_TRISER_16MHZ_STD_50 = 0x11
                                    532 
                           000001   533  I2C_CCRH_16MHZ_STD_20 = 0x01
                           000090   534  I2C_CCRL_16MHZ_STD_20 = 0x90
                           000011   535  I2C_TRISER_16MHZ_STD_20 = 0x11;
                                    536 
                           000001   537  I2C_READ = 1
                           000000   538  I2C_WRITE = 0
                                    539 
                                    540 ; baudrate constant for brr_value table access
                                    541 ; to be used by uart_init 
                           000000   542 B2400=0
                           000001   543 B4800=1
                           000002   544 B9600=2
                           000003   545 B19200=3
                           000004   546 B38400=4
                           000005   547 B57600=5
                           000006   548 B115200=6
                           000007   549 B230400=7
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 15.
Hexadecimal [24-Bits]



                           000008   550 B460800=8
                           000009   551 B921600=9
                                    552 
                                    553 ; UART registers offset from
                                    554 ; base address 
                           000000   555 OFS_UART_SR=0
                           000001   556 OFS_UART_DR=1
                           000002   557 OFS_UART_BRR1=2
                           000003   558 OFS_UART_BRR2=3
                           000004   559 OFS_UART_CR1=4
                           000005   560 OFS_UART_CR2=5
                           000006   561 OFS_UART_CR3=6
                           000007   562 OFS_UART_CR4=7
                           000008   563 OFS_UART_CR5=8
                           000009   564 OFS_UART_CR6=9
                           000009   565 OFS_UART_GTR=9
                           00000A   566 OFS_UART_PSCR=10
                                    567 
                                    568 ; uart identifier
                           000000   569  UART1 = 0 
                           000001   570  UART2 = 1
                           000002   571  UART3 = 2
                                    572 
                                    573 ; pins used by uart 
                           000005   574 UART1_TX_PIN=BIT5
                           000004   575 UART1_RX_PIN=BIT4
                           000005   576 UART3_TX_PIN=BIT5
                           000006   577 UART3_RX_PIN=BIT6
                                    578 ; uart port base address 
                           000000   579 UART1_PORT=PA 
                           00000F   580 UART3_PORT=PD
                                    581 
                                    582 ; UART1 
                           005230   583  UART1_BASE  = (0x5230)
                           005230   584  UART1_SR    = (0x5230)
                           005231   585  UART1_DR    = (0x5231)
                           005232   586  UART1_BRR1  = (0x5232)
                           005233   587  UART1_BRR2  = (0x5233)
                           005234   588  UART1_CR1   = (0x5234)
                           005235   589  UART1_CR2   = (0x5235)
                           005236   590  UART1_CR3   = (0x5236)
                           005237   591  UART1_CR4   = (0x5237)
                           005238   592  UART1_CR5   = (0x5238)
                           005239   593  UART1_GTR   = (0x5239)
                           00523A   594  UART1_PSCR  = (0x523A)
                                    595 
                                    596 ; UART3
                           005240   597  UART3_BASE  = (0x5240)
                           005240   598  UART3_SR    = (0x5240)
                           005241   599  UART3_DR    = (0x5241)
                           005242   600  UART3_BRR1  = (0x5242)
                           005243   601  UART3_BRR2  = (0x5243)
                           005244   602  UART3_CR1   = (0x5244)
                           005245   603  UART3_CR2   = (0x5245)
                           005246   604  UART3_CR3   = (0x5246)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 16.
Hexadecimal [24-Bits]



                           005247   605  UART3_CR4   = (0x5247)
                           004249   606  UART3_CR6   = (0x4249)
                                    607 
                                    608 ; UART Status Register bits
                           000007   609  UART_SR_TXE = (7)
                           000006   610  UART_SR_TC = (6)
                           000005   611  UART_SR_RXNE = (5)
                           000004   612  UART_SR_IDLE = (4)
                           000003   613  UART_SR_OR = (3)
                           000002   614  UART_SR_NF = (2)
                           000001   615  UART_SR_FE = (1)
                           000000   616  UART_SR_PE = (0)
                                    617 
                                    618 ; Uart Control Register bits
                           000007   619  UART_CR1_R8 = (7)
                           000006   620  UART_CR1_T8 = (6)
                           000005   621  UART_CR1_UARTD = (5)
                           000004   622  UART_CR1_M = (4)
                           000003   623  UART_CR1_WAKE = (3)
                           000002   624  UART_CR1_PCEN = (2)
                           000001   625  UART_CR1_PS = (1)
                           000000   626  UART_CR1_PIEN = (0)
                                    627 
                           000007   628  UART_CR2_TIEN = (7)
                           000006   629  UART_CR2_TCIEN = (6)
                           000005   630  UART_CR2_RIEN = (5)
                           000004   631  UART_CR2_ILIEN = (4)
                           000003   632  UART_CR2_TEN = (3)
                           000002   633  UART_CR2_REN = (2)
                           000001   634  UART_CR2_RWU = (1)
                           000000   635  UART_CR2_SBK = (0)
                                    636 
                           000006   637  UART_CR3_LINEN = (6)
                           000005   638  UART_CR3_STOP1 = (5)
                           000004   639  UART_CR3_STOP0 = (4)
                           000003   640  UART_CR3_CLKEN = (3)
                           000002   641  UART_CR3_CPOL = (2)
                           000001   642  UART_CR3_CPHA = (1)
                           000000   643  UART_CR3_LBCL = (0)
                                    644 
                           000006   645  UART_CR4_LBDIEN = (6)
                           000005   646  UART_CR4_LBDL = (5)
                           000004   647  UART_CR4_LBDF = (4)
                           000003   648  UART_CR4_ADD3 = (3)
                           000002   649  UART_CR4_ADD2 = (2)
                           000001   650  UART_CR4_ADD1 = (1)
                           000000   651  UART_CR4_ADD0 = (0)
                                    652 
                           000005   653  UART_CR5_SCEN = (5)
                           000004   654  UART_CR5_NACK = (4)
                           000003   655  UART_CR5_HDSEL = (3)
                           000002   656  UART_CR5_IRLP = (2)
                           000001   657  UART_CR5_IREN = (1)
                                    658 ; LIN mode config register
                           000007   659  UART_CR6_LDUM = (7)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 17.
Hexadecimal [24-Bits]



                           000005   660  UART_CR6_LSLV = (5)
                           000004   661  UART_CR6_LASE = (4)
                           000002   662  UART_CR6_LHDIEN = (2) 
                           000001   663  UART_CR6_LHDF = (1)
                           000000   664  UART_CR6_LSF = (0)
                                    665 
                                    666 ; TIMERS
                                    667 ; Timer 1 - 16-bit timer with complementary PWM outputs
                           005250   668  TIM1_CR1  = (0x5250)
                           005251   669  TIM1_CR2  = (0x5251)
                           005252   670  TIM1_SMCR  = (0x5252)
                           005253   671  TIM1_ETR  = (0x5253)
                           005254   672  TIM1_IER  = (0x5254)
                           005255   673  TIM1_SR1  = (0x5255)
                           005256   674  TIM1_SR2  = (0x5256)
                           005257   675  TIM1_EGR  = (0x5257)
                           005258   676  TIM1_CCMR1  = (0x5258)
                           005259   677  TIM1_CCMR2  = (0x5259)
                           00525A   678  TIM1_CCMR3  = (0x525A)
                           00525B   679  TIM1_CCMR4  = (0x525B)
                           00525C   680  TIM1_CCER1  = (0x525C)
                           00525D   681  TIM1_CCER2  = (0x525D)
                           00525E   682  TIM1_CNTRH  = (0x525E)
                           00525F   683  TIM1_CNTRL  = (0x525F)
                           005260   684  TIM1_PSCRH  = (0x5260)
                           005261   685  TIM1_PSCRL  = (0x5261)
                           005262   686  TIM1_ARRH  = (0x5262)
                           005263   687  TIM1_ARRL  = (0x5263)
                           005264   688  TIM1_RCR  = (0x5264)
                           005265   689  TIM1_CCR1H  = (0x5265)
                           005266   690  TIM1_CCR1L  = (0x5266)
                           005267   691  TIM1_CCR2H  = (0x5267)
                           005268   692  TIM1_CCR2L  = (0x5268)
                           005269   693  TIM1_CCR3H  = (0x5269)
                           00526A   694  TIM1_CCR3L  = (0x526A)
                           00526B   695  TIM1_CCR4H  = (0x526B)
                           00526C   696  TIM1_CCR4L  = (0x526C)
                           00526D   697  TIM1_BKR  = (0x526D)
                           00526E   698  TIM1_DTR  = (0x526E)
                           00526F   699  TIM1_OISR  = (0x526F)
                                    700 
                                    701 ; Timer Control Register bits
                           000007   702  TIM_CR1_ARPE = (7)
                           000006   703  TIM_CR1_CMSH = (6)
                           000005   704  TIM_CR1_CMSL = (5)
                           000004   705  TIM_CR1_DIR = (4)
                           000003   706  TIM_CR1_OPM = (3)
                           000002   707  TIM_CR1_URS = (2)
                           000001   708  TIM_CR1_UDIS = (1)
                           000000   709  TIM_CR1_CEN = (0)
                                    710 
                           000006   711  TIM1_CR2_MMS2 = (6)
                           000005   712  TIM1_CR2_MMS1 = (5)
                           000004   713  TIM1_CR2_MMS0 = (4)
                           000002   714  TIM1_CR2_COMS = (2)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 18.
Hexadecimal [24-Bits]



                           000000   715  TIM1_CR2_CCPC = (0)
                                    716 
                                    717 ; Timer Slave Mode Control bits
                           000007   718  TIM1_SMCR_MSM = (7)
                           000006   719  TIM1_SMCR_TS2 = (6)
                           000005   720  TIM1_SMCR_TS1 = (5)
                           000004   721  TIM1_SMCR_TS0 = (4)
                           000002   722  TIM1_SMCR_SMS2 = (2)
                           000001   723  TIM1_SMCR_SMS1 = (1)
                           000000   724  TIM1_SMCR_SMS0 = (0)
                                    725 
                                    726 ; Timer External Trigger Enable bits
                           000007   727  TIM1_ETR_ETP = (7)
                           000006   728  TIM1_ETR_ECE = (6)
                           000005   729  TIM1_ETR_ETPS1 = (5)
                           000004   730  TIM1_ETR_ETPS0 = (4)
                           000003   731  TIM1_ETR_ETF3 = (3)
                           000002   732  TIM1_ETR_ETF2 = (2)
                           000001   733  TIM1_ETR_ETF1 = (1)
                           000000   734  TIM1_ETR_ETF0 = (0)
                                    735 
                                    736 ; Timer Interrupt Enable bits
                           000007   737  TIM1_IER_BIE = (7)
                           000006   738  TIM1_IER_TIE = (6)
                           000005   739  TIM1_IER_COMIE = (5)
                           000004   740  TIM1_IER_CC4IE = (4)
                           000003   741  TIM1_IER_CC3IE = (3)
                           000002   742  TIM1_IER_CC2IE = (2)
                           000001   743  TIM1_IER_CC1IE = (1)
                           000000   744  TIM1_IER_UIE = (0)
                                    745 
                                    746 ; Timer Status Register bits
                           000007   747  TIM1_SR1_BIF = (7)
                           000006   748  TIM1_SR1_TIF = (6)
                           000005   749  TIM1_SR1_COMIF = (5)
                           000004   750  TIM1_SR1_CC4IF = (4)
                           000003   751  TIM1_SR1_CC3IF = (3)
                           000002   752  TIM1_SR1_CC2IF = (2)
                           000001   753  TIM1_SR1_CC1IF = (1)
                           000000   754  TIM1_SR1_UIF = (0)
                                    755 
                           000004   756  TIM1_SR2_CC4OF = (4)
                           000003   757  TIM1_SR2_CC3OF = (3)
                           000002   758  TIM1_SR2_CC2OF = (2)
                           000001   759  TIM1_SR2_CC1OF = (1)
                                    760 
                                    761 ; Timer Event Generation Register bits
                           000007   762  TIM1_EGR_BG = (7)
                           000006   763  TIM1_EGR_TG = (6)
                           000005   764  TIM1_EGR_COMG = (5)
                           000004   765  TIM1_EGR_CC4G = (4)
                           000003   766  TIM1_EGR_CC3G = (3)
                           000002   767  TIM1_EGR_CC2G = (2)
                           000001   768  TIM1_EGR_CC1G = (1)
                           000000   769  TIM1_EGR_UG = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 19.
Hexadecimal [24-Bits]



                                    770 
                                    771 ; Capture/Compare Mode Register 1 - channel configured in output
                           000007   772  TIM1_CCMR1_OC1CE = (7)
                           000006   773  TIM1_CCMR1_OC1M2 = (6)
                           000005   774  TIM1_CCMR1_OC1M1 = (5)
                           000004   775  TIM1_CCMR1_OC1M0 = (4)
                           000003   776  TIM1_CCMR1_OC1PE = (3)
                           000002   777  TIM1_CCMR1_OC1FE = (2)
                           000001   778  TIM1_CCMR1_CC1S1 = (1)
                           000000   779  TIM1_CCMR1_CC1S0 = (0)
                                    780 
                                    781 ; Capture/Compare Mode Register 1 - channel configured in input
                           000007   782  TIM1_CCMR1_IC1F3 = (7)
                           000006   783  TIM1_CCMR1_IC1F2 = (6)
                           000005   784  TIM1_CCMR1_IC1F1 = (5)
                           000004   785  TIM1_CCMR1_IC1F0 = (4)
                           000003   786  TIM1_CCMR1_IC1PSC1 = (3)
                           000002   787  TIM1_CCMR1_IC1PSC0 = (2)
                                    788 ;  TIM1_CCMR1_CC1S1 = (1)
                           000000   789  TIM1_CCMR1_CC1S0 = (0)
                                    790 
                                    791 ; Capture/Compare Mode Register 2 - channel configured in output
                           000007   792  TIM1_CCMR2_OC2CE = (7)
                           000006   793  TIM1_CCMR2_OC2M2 = (6)
                           000005   794  TIM1_CCMR2_OC2M1 = (5)
                           000004   795  TIM1_CCMR2_OC2M0 = (4)
                           000003   796  TIM1_CCMR2_OC2PE = (3)
                           000002   797  TIM1_CCMR2_OC2FE = (2)
                           000001   798  TIM1_CCMR2_CC2S1 = (1)
                           000000   799  TIM1_CCMR2_CC2S0 = (0)
                                    800 
                                    801 ; Capture/Compare Mode Register 2 - channel configured in input
                           000007   802  TIM1_CCMR2_IC2F3 = (7)
                           000006   803  TIM1_CCMR2_IC2F2 = (6)
                           000005   804  TIM1_CCMR2_IC2F1 = (5)
                           000004   805  TIM1_CCMR2_IC2F0 = (4)
                           000003   806  TIM1_CCMR2_IC2PSC1 = (3)
                           000002   807  TIM1_CCMR2_IC2PSC0 = (2)
                                    808 ;  TIM1_CCMR2_CC2S1 = (1)
                           000000   809  TIM1_CCMR2_CC2S0 = (0)
                                    810 
                                    811 ; Capture/Compare Mode Register 3 - channel configured in output
                           000007   812  TIM1_CCMR3_OC3CE = (7)
                           000006   813  TIM1_CCMR3_OC3M2 = (6)
                           000005   814  TIM1_CCMR3_OC3M1 = (5)
                           000004   815  TIM1_CCMR3_OC3M0 = (4)
                           000003   816  TIM1_CCMR3_OC3PE = (3)
                           000002   817  TIM1_CCMR3_OC3FE = (2)
                           000001   818  TIM1_CCMR3_CC3S1 = (1)
                           000000   819  TIM1_CCMR3_CC3S0 = (0)
                                    820 
                                    821 ; Capture/Compare Mode Register 3 - channel configured in input
                           000007   822  TIM1_CCMR3_IC3F3 = (7)
                           000006   823  TIM1_CCMR3_IC3F2 = (6)
                           000005   824  TIM1_CCMR3_IC3F1 = (5)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 20.
Hexadecimal [24-Bits]



                           000004   825  TIM1_CCMR3_IC3F0 = (4)
                           000003   826  TIM1_CCMR3_IC3PSC1 = (3)
                           000002   827  TIM1_CCMR3_IC3PSC0 = (2)
                                    828 ;  TIM1_CCMR3_CC3S1 = (1)
                           000000   829  TIM1_CCMR3_CC3S0 = (0)
                                    830 
                                    831 ; Capture/Compare Mode Register 4 - channel configured in output
                           000007   832  TIM1_CCMR4_OC4CE = (7)
                           000006   833  TIM1_CCMR4_OC4M2 = (6)
                           000005   834  TIM1_CCMR4_OC4M1 = (5)
                           000004   835  TIM1_CCMR4_OC4M0 = (4)
                           000003   836  TIM1_CCMR4_OC4PE = (3)
                           000002   837  TIM1_CCMR4_OC4FE = (2)
                           000001   838  TIM1_CCMR4_CC4S1 = (1)
                           000000   839  TIM1_CCMR4_CC4S0 = (0)
                                    840 
                                    841 ; Capture/Compare Mode Register 4 - channel configured in input
                           000007   842  TIM1_CCMR4_IC4F3 = (7)
                           000006   843  TIM1_CCMR4_IC4F2 = (6)
                           000005   844  TIM1_CCMR4_IC4F1 = (5)
                           000004   845  TIM1_CCMR4_IC4F0 = (4)
                           000003   846  TIM1_CCMR4_IC4PSC1 = (3)
                           000002   847  TIM1_CCMR4_IC4PSC0 = (2)
                                    848 ;  TIM1_CCMR4_CC4S1 = (1)
                           000000   849  TIM1_CCMR4_CC4S0 = (0)
                                    850 
                                    851 ; Timer 2 - 16-bit timer
                           005300   852  TIM2_CR1  = (0x5300)
                           005301   853  TIM2_IER  = (0x5301)
                           005302   854  TIM2_SR1  = (0x5302)
                           005303   855  TIM2_SR2  = (0x5303)
                           005304   856  TIM2_EGR  = (0x5304)
                           005305   857  TIM2_CCMR1  = (0x5305)
                           005306   858  TIM2_CCMR2  = (0x5306)
                           005307   859  TIM2_CCMR3  = (0x5307)
                           005308   860  TIM2_CCER1  = (0x5308)
                           005309   861  TIM2_CCER2  = (0x5309)
                           00530A   862  TIM2_CNTRH  = (0x530A)
                           00530B   863  TIM2_CNTRL  = (0x530B)
                           00530C   864  TIM2_PSCR  = (0x530C)
                           00530D   865  TIM2_ARRH  = (0x530D)
                           00530E   866  TIM2_ARRL  = (0x530E)
                           00530F   867  TIM2_CCR1H  = (0x530F)
                           005310   868  TIM2_CCR1L  = (0x5310)
                           005311   869  TIM2_CCR2H  = (0x5311)
                           005312   870  TIM2_CCR2L  = (0x5312)
                           005313   871  TIM2_CCR3H  = (0x5313)
                           005314   872  TIM2_CCR3L  = (0x5314)
                                    873 
                                    874 ; TIM2_CR1 bitfields
                           000000   875  TIM2_CR1_CEN=(0) ; Counter enable
                           000001   876  TIM2_CR1_UDIS=(1) ; Update disable
                           000002   877  TIM2_CR1_URS=(2) ; Update request source
                           000003   878  TIM2_CR1_OPM=(3) ; One-pulse mode
                           000007   879  TIM2_CR1_ARPE=(7) ; Auto-reload preload enable
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 21.
Hexadecimal [24-Bits]



                                    880 
                                    881 ; TIMER2_CCMR bitfields 
                           000000   882  TIM2_CCMR_CCS=(0) ; input/output select
                           000003   883  TIM2_CCMR_OCPE=(3) ; preload enable
                           000004   884  TIM2_CCMR_OCM=(4)  ; output compare mode 
                                    885 
                                    886 ; TIMER2_CCER1 bitfields
                           000000   887  TIM2_CCER1_CC1E=(0)
                           000001   888  TIM2_CCER1_CC1P=(1)
                           000004   889  TIM2_CCER1_CC2E=(4)
                           000005   890  TIM2_CCER1_CC2P=(5)
                                    891 
                                    892 ; TIMER2_EGR bitfields
                           000000   893  TIM2_EGR_UG=(0) ; update generation
                           000001   894  TIM2_EGR_CC1G=(1) ; Capture/compare 1 generation
                           000002   895  TIM2_EGR_CC2G=(2) ; Capture/compare 2 generation
                           000003   896  TIM2_EGR_CC3G=(3) ; Capture/compare 3 generation
                           000006   897  TIM2_EGR_TG=(6); Trigger generation
                                    898 
                                    899 ; Timer 3
                           005320   900  TIM3_CR1  = (0x5320)
                           005321   901  TIM3_IER  = (0x5321)
                           005322   902  TIM3_SR1  = (0x5322)
                           005323   903  TIM3_SR2  = (0x5323)
                           005324   904  TIM3_EGR  = (0x5324)
                           005325   905  TIM3_CCMR1  = (0x5325)
                           005326   906  TIM3_CCMR2  = (0x5326)
                           005327   907  TIM3_CCER1  = (0x5327)
                           005328   908  TIM3_CNTRH  = (0x5328)
                           005329   909  TIM3_CNTRL  = (0x5329)
                           00532A   910  TIM3_PSCR  = (0x532A)
                           00532B   911  TIM3_ARRH  = (0x532B)
                           00532C   912  TIM3_ARRL  = (0x532C)
                           00532D   913  TIM3_CCR1H  = (0x532D)
                           00532E   914  TIM3_CCR1L  = (0x532E)
                           00532F   915  TIM3_CCR2H  = (0x532F)
                           005330   916  TIM3_CCR2L  = (0x5330)
                                    917 
                                    918 ; TIM3_CR1  fields
                           000000   919  TIM3_CR1_CEN = (0)
                           000001   920  TIM3_CR1_UDIS = (1)
                           000002   921  TIM3_CR1_URS = (2)
                           000003   922  TIM3_CR1_OPM = (3)
                           000007   923  TIM3_CR1_ARPE = (7)
                                    924 ; TIM3_CCR2  fields
                           000000   925  TIM3_CCMR2_CC2S_POS = (0)
                           000003   926  TIM3_CCMR2_OC2PE_POS = (3)
                           000004   927  TIM3_CCMR2_OC2M_POS = (4)  
                                    928 ; TIM3_CCER1 fields
                           000000   929  TIM3_CCER1_CC1E = (0)
                           000001   930  TIM3_CCER1_CC1P = (1)
                           000004   931  TIM3_CCER1_CC2E = (4)
                           000005   932  TIM3_CCER1_CC2P = (5)
                                    933 ; TIM3_CCER2 fields
                           000000   934  TIM3_CCER2_CC3E = (0)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 22.
Hexadecimal [24-Bits]



                           000001   935  TIM3_CCER2_CC3P = (1)
                                    936 
                                    937 ; Timer 4
                           005340   938  TIM4_CR1  = (0x5340)
                           005341   939  TIM4_IER  = (0x5341)
                           005342   940  TIM4_SR  = (0x5342)
                           005343   941  TIM4_EGR  = (0x5343)
                           005344   942  TIM4_CNTR  = (0x5344)
                           005345   943  TIM4_PSCR  = (0x5345)
                           005346   944  TIM4_ARR  = (0x5346)
                                    945 
                                    946 ; Timer 4 bitmasks
                                    947 
                           000007   948  TIM4_CR1_ARPE = (7)
                           000003   949  TIM4_CR1_OPM = (3)
                           000002   950  TIM4_CR1_URS = (2)
                           000001   951  TIM4_CR1_UDIS = (1)
                           000000   952  TIM4_CR1_CEN = (0)
                                    953 
                           000000   954  TIM4_IER_UIE = (0)
                                    955 
                           000000   956  TIM4_SR_UIF = (0)
                                    957 
                           000000   958  TIM4_EGR_UG = (0)
                                    959 
                           000002   960  TIM4_PSCR_PSC2 = (2)
                           000001   961  TIM4_PSCR_PSC1 = (1)
                           000000   962  TIM4_PSCR_PSC0 = (0)
                                    963 
                           000000   964  TIM4_PSCR_1 = 0
                           000001   965  TIM4_PSCR_2 = 1
                           000002   966  TIM4_PSCR_4 = 2
                           000003   967  TIM4_PSCR_8 = 3
                           000004   968  TIM4_PSCR_16 = 4
                           000005   969  TIM4_PSCR_32 = 5
                           000006   970  TIM4_PSCR_64 = 6
                           000007   971  TIM4_PSCR_128 = 7
                                    972 
                                    973 ; ADC2
                           005400   974  ADC_CSR  = (0x5400)
                           005401   975  ADC_CR1  = (0x5401)
                           005402   976  ADC_CR2  = (0x5402)
                           005403   977  ADC_CR3  = (0x5403)
                           005404   978  ADC_DRH  = (0x5404)
                           005405   979  ADC_DRL  = (0x5405)
                           005406   980  ADC_TDRH  = (0x5406)
                           005407   981  ADC_TDRL  = (0x5407)
                                    982  
                                    983 ; ADC bitmasks
                                    984 
                           000007   985  ADC_CSR_EOC = (7)
                           000006   986  ADC_CSR_AWD = (6)
                           000005   987  ADC_CSR_EOCIE = (5)
                           000004   988  ADC_CSR_AWDIE = (4)
                           000003   989  ADC_CSR_CH3 = (3)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 23.
Hexadecimal [24-Bits]



                           000002   990  ADC_CSR_CH2 = (2)
                           000001   991  ADC_CSR_CH1 = (1)
                           000000   992  ADC_CSR_CH0 = (0)
                                    993 
                           000006   994  ADC_CR1_SPSEL2 = (6)
                           000005   995  ADC_CR1_SPSEL1 = (5)
                           000004   996  ADC_CR1_SPSEL0 = (4)
                           000001   997  ADC_CR1_CONT = (1)
                           000000   998  ADC_CR1_ADON = (0)
                                    999 
                           000006  1000  ADC_CR2_EXTTRIG = (6)
                           000005  1001  ADC_CR2_EXTSEL1 = (5)
                           000004  1002  ADC_CR2_EXTSEL0 = (4)
                           000003  1003  ADC_CR2_ALIGN = (3)
                           000001  1004  ADC_CR2_SCAN = (1)
                                   1005 
                           000007  1006  ADC_CR3_DBUF = (7)
                           000006  1007  ADC_CR3_DRH = (6)
                                   1008 
                                   1009 ; beCAN
                           005420  1010  CAN_MCR = (0x5420)
                           005421  1011  CAN_MSR = (0x5421)
                           005422  1012  CAN_TSR = (0x5422)
                           005423  1013  CAN_TPR = (0x5423)
                           005424  1014  CAN_RFR = (0x5424)
                           005425  1015  CAN_IER = (0x5425)
                           005426  1016  CAN_DGR = (0x5426)
                           005427  1017  CAN_FPSR = (0x5427)
                           005428  1018  CAN_P0 = (0x5428)
                           005429  1019  CAN_P1 = (0x5429)
                           00542A  1020  CAN_P2 = (0x542A)
                           00542B  1021  CAN_P3 = (0x542B)
                           00542C  1022  CAN_P4 = (0x542C)
                           00542D  1023  CAN_P5 = (0x542D)
                           00542E  1024  CAN_P6 = (0x542E)
                           00542F  1025  CAN_P7 = (0x542F)
                           005430  1026  CAN_P8 = (0x5430)
                           005431  1027  CAN_P9 = (0x5431)
                           005432  1028  CAN_PA = (0x5432)
                           005433  1029  CAN_PB = (0x5433)
                           005434  1030  CAN_PC = (0x5434)
                           005435  1031  CAN_PD = (0x5435)
                           005436  1032  CAN_PE = (0x5436)
                           005437  1033  CAN_PF = (0x5437)
                                   1034 
                                   1035 
                                   1036 ; CPU
                           007F00  1037  CPU_A  = (0x7F00)
                           007F01  1038  CPU_PCE  = (0x7F01)
                           007F02  1039  CPU_PCH  = (0x7F02)
                           007F03  1040  CPU_PCL  = (0x7F03)
                           007F04  1041  CPU_XH  = (0x7F04)
                           007F05  1042  CPU_XL  = (0x7F05)
                           007F06  1043  CPU_YH  = (0x7F06)
                           007F07  1044  CPU_YL  = (0x7F07)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 24.
Hexadecimal [24-Bits]



                           007F08  1045  CPU_SPH  = (0x7F08)
                           007F09  1046  CPU_SPL   = (0x7F09)
                           007F0A  1047  CPU_CCR   = (0x7F0A)
                                   1048 
                                   1049 ; global configuration register
                           007F60  1050  CFG_GCR   = (0x7F60)
                           000001  1051  CFG_GCR_AL = 1
                           000000  1052  CFG_GCR_SWIM = 0
                                   1053 
                                   1054 ; interrupt software priority 
                           007F70  1055  ITC_SPR1   = (0x7F70) ; (0..3) 0->resreved,AWU..EXT0 
                           007F71  1056  ITC_SPR2   = (0x7F71) ; (4..7) EXT1..EXT4 RX 
                           007F72  1057  ITC_SPR3   = (0x7F72) ; (8..11) beCAN RX..TIM1 UPDT/OVR  
                           007F73  1058  ITC_SPR4   = (0x7F73) ; (12..15) TIM1 CAP/CMP .. TIM3 UPDT/OVR 
                           007F74  1059  ITC_SPR5   = (0x7F74) ; (16..19) TIM3 CAP/CMP..I2C  
                           007F75  1060  ITC_SPR6   = (0x7F75) ; (20..23) UART3 TX..TIM4 CAP/OVR 
                           007F76  1061  ITC_SPR7   = (0x7F76) ; (24..29) FLASH WR..
                           007F77  1062  ITC_SPR8   = (0x7F77) ; (30..32) ..
                                   1063 
                           000001  1064 ITC_SPR_LEVEL1=1 
                           000000  1065 ITC_SPR_LEVEL2=0
                           000003  1066 ITC_SPR_LEVEL3=3 
                                   1067 
                                   1068 ; SWIM, control and status register
                           007F80  1069  SWIM_CSR   = (0x7F80)
                                   1070 ; debug registers
                           007F90  1071  DM_BK1RE   = (0x7F90)
                           007F91  1072  DM_BK1RH   = (0x7F91)
                           007F92  1073  DM_BK1RL   = (0x7F92)
                           007F93  1074  DM_BK2RE   = (0x7F93)
                           007F94  1075  DM_BK2RH   = (0x7F94)
                           007F95  1076  DM_BK2RL   = (0x7F95)
                           007F96  1077  DM_CR1   = (0x7F96)
                           007F97  1078  DM_CR2   = (0x7F97)
                           007F98  1079  DM_CSR1   = (0x7F98)
                           007F99  1080  DM_CSR2   = (0x7F99)
                           007F9A  1081  DM_ENFCTR   = (0x7F9A)
                                   1082 
                                   1083 ; Interrupt Numbers
                           000000  1084  INT_TLI = 0
                           000001  1085  INT_AWU = 1
                           000002  1086  INT_CLK = 2
                           000003  1087  INT_EXTI0 = 3
                           000004  1088  INT_EXTI1 = 4
                           000005  1089  INT_EXTI2 = 5
                           000006  1090  INT_EXTI3 = 6
                           000007  1091  INT_EXTI4 = 7
                           000008  1092  INT_CAN_RX = 8
                           000009  1093  INT_CAN_TX = 9
                           00000A  1094  INT_SPI = 10
                           00000B  1095  INT_TIM1_OVF = 11
                           00000C  1096  INT_TIM1_CCM = 12
                           00000D  1097  INT_TIM2_OVF = 13
                           00000E  1098  INT_TIM2_CCM = 14
                           00000F  1099  INT_TIM3_OVF = 15
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 25.
Hexadecimal [24-Bits]



                           000010  1100  INT_TIM3_CCM = 16
                           000011  1101  INT_UART1_TX_COMPLETED = 17
                           000012  1102  INT_AUART1_RX_FULL = 18
                           000013  1103  INT_I2C = 19
                           000014  1104  INT_UART3_TX_COMPLETED = 20
                           000015  1105  INT_UART3_RX_FULL = 21
                           000016  1106  INT_ADC2 = 22
                           000017  1107  INT_TIM4_OVF = 23
                           000018  1108  INT_FLASH = 24
                                   1109 
                                   1110 ; Interrupt Vectors
                           008000  1111  INT_VECTOR_RESET = 0x8000
                           008004  1112  INT_VECTOR_TRAP = 0x8004
                           008008  1113  INT_VECTOR_TLI = 0x8008
                           00800C  1114  INT_VECTOR_AWU = 0x800C
                           008010  1115  INT_VECTOR_CLK = 0x8010
                           008014  1116  INT_VECTOR_EXTI0 = 0x8014
                           008018  1117  INT_VECTOR_EXTI1 = 0x8018
                           00801C  1118  INT_VECTOR_EXTI2 = 0x801C
                           008020  1119  INT_VECTOR_EXTI3 = 0x8020
                           008024  1120  INT_VECTOR_EXTI4 = 0x8024
                           008028  1121  INT_VECTOR_CAN_RX = 0x8028
                           00802C  1122  INT_VECTOR_CAN_TX = 0x802c
                           008030  1123  INT_VECTOR_SPI = 0x8030
                           008034  1124  INT_VECTOR_TIM1_OVF = 0x8034
                           008038  1125  INT_VECTOR_TIM1_CCM = 0x8038
                           00803C  1126  INT_VECTOR_TIM2_OVF = 0x803C
                           008040  1127  INT_VECTOR_TIM2_CCM = 0x8040
                           008044  1128  INT_VECTOR_TIM3_OVF = 0x8044
                           008048  1129  INT_VECTOR_TIM3_CCM = 0x8048
                           00804C  1130  INT_VECTOR_UART1_TX_COMPLETED = 0x804c
                           008050  1131  INT_VECTOR_UART1_RX_FULL = 0x8050
                           008054  1132  INT_VECTOR_I2C = 0x8054
                           008058  1133  INT_VECTOR_UART3_TX_COMPLETED = 0x8058
                           00805C  1134  INT_VECTOR_UART3_RX_FULL = 0x805C
                           008060  1135  INT_VECTOR_ADC2 = 0x8060
                           008064  1136  INT_VECTOR_TIM4_OVF = 0x8064
                           008068  1137  INT_VECTOR_FLASH = 0x8068
                                   1138 
                                   1139 ; Condition code register bits
                           000007  1140 CC_V = 7  ; overflow flag 
                           000005  1141 CC_I1= 5  ; interrupt bit 1
                           000004  1142 CC_H = 4  ; half carry 
                           000003  1143 CC_I0 = 3 ; interrupt bit 0
                           000002  1144 CC_N = 2 ;  negative flag 
                           000001  1145 CC_Z = 1 ;  zero flag  
                           000000  1146 CC_C = 0 ; carry bit 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 26.
Hexadecimal [24-Bits]



                                     51 	.include "inc/nucleo_8s207.inc" 
                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2023 
                                      3 ; This file is part of stm8_chipcon 
                                      4 ;
                                      5 ;     stm8_chipcon is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_chipcon is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_chipcon.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     19 ; NUCLEO-8S207K8 board specific definitions
                                     20 ; Date: 2023/11/02
                                     21 ; author: Jacques Deschênes, copyright 2023
                                     22 ; licence: GPLv3
                                     23 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     24 
                                     25 ; mcu on board is stm8s207k8
                                     26 
                                     27 ; crystal on board is 8Mhz
                                     28 ; st-link crystal 
                           7A1200    29 FHSE = 8000000
                                     30 
                                     31 ; LD3 is user LED
                                     32 ; connected to PC5 via Q2
                           00500A    33 LED_PORT = PC_BASE ;port C
                           000005    34 LED_BIT = 5
                           000020    35 LED_MASK = (1<<LED_BIT) ;bit 5 mask
                                     36 
                                     37 ; user interface UART via STLINK (T_VCP)
                                     38 
                           000002    39 UART=UART3 
                                     40 ; port used by  UART3 
                           00500F    41 UART_PORT_ODR=PD_ODR 
                           005011    42 UART_PORT_DDR=PD_DDR 
                           005010    43 UART_PORT_IDR=PD_IDR 
                           005012    44 UART_PORT_CR1=PD_CR1 
                           005013    45 UART_PORT_CR2=PD_CR2 
                                     46 
                                     47 ; clock enable bit 
                           000003    48 UART_PCKEN=CLK_PCKENR1_UART3 
                                     49 
                                     50 ; uart3 registers 
                           005240    51 UART_SR=UART3_SR
                           005241    52 UART_DR=UART3_DR
                           005242    53 UART_BRR1=UART3_BRR1
                           005243    54 UART_BRR2=UART3_BRR2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 27.
Hexadecimal [24-Bits]



                           005244    55 UART_CR1=UART3_CR1
                           005245    56 UART_CR2=UART3_CR2
                                     57 
                                     58 ; TX, RX pin
                           000005    59 UART_TX_PIN=UART3_TX_PIN 
                           000006    60 UART_RX_PIN=UART3_RX_PIN 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 28.
Hexadecimal [24-Bits]



                                     52 	.include "inc/gen_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 29.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 30.
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 31.
Hexadecimal [24-Bits]



                                     53 	.include "app_macros.inc" 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 32.
Hexadecimal [24-Bits]



                                     55     .macro _drop_args n 
                                     56     addw sp,#2*n
                                     57     .endm 
                                     58 
                                     59 
                                     60 ;--------------------------------
                                     61 ; oled commands macros 
                                     62 ;----------------------------------
                                     63 
                                     64     ; initialize cmd_buffer 
                                     65     .macro _cmd_init 
                                     66         BUF_OFS=0
                                     67     .endm 
                                     68 
                                     69     ; set oled command buffer values 
                                     70     ; initialize BUF_OFS=0 
                                     71     ; before using it 
                                     72     .macro _set_cmd n
                                     73     BUF_OFS=BUF_OFS+1 
                                     74     mov cmd_buffer_BUF_OFS,#0x80
                                     75     BUF_OFS=BUF_OFS+1 
                                     76     mov cmd_buffer+BUF_OFS,#n 
                                     77     .endm 
                                     78 
                                     79     
                                     80     ; send command 
                                     81     .macro _send_cmd code 
                                     82     ld a,#code 
                                     83     call oled_cmd 
                                     84     .endm 
                                     85 
                                     86 
                                     87     ; read buttons 
                                     88     .macro _read_buttons
                                     89     ld a,#BTN_PORT+GPIO_IDR 
                                     90     and a,#ALL_KEY_UP
                                     91     .endm 
                                     92 
                                     93 
                                     94 ;-----------------------------
                                     95 ;   keypad macros 
                                     96 ;-----------------------------
                                     97 
                                     98     .macro _btn_down btn 
                                     99     ld a,BTN_IDR 
                                    100     and a,#(1<<btn)
                                    101     or a,#(1<<btn)
                                    102     .endm 
                                    103 
                                    104     .macro _btn_up 
                                    105     ld a,#BTN_IDR 
                                    106     and a,#(1<<btn)
                                    107     .endm 
                                    108 
                                    109     .macro _btn_state 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                    110     ld a,#BTN_IDR 
                                    111     and a,#ALL_KEY_UP
                                    112     .endm 
                                    113 
                                    114     .macro _wait_key_release  ?loop 
                                    115     loop:
                                    116     ld a,BTN_IDR 
                                    117     and a,#ALL_KEY_UP 
                                    118     cp a,#ALL_KEY_UP 
                                    119     jrne loop 
                                    120     .endm 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 34.
Hexadecimal [24-Bits]



                                     54 
                                     55 
                                     56 
                                     57 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 35.
Hexadecimal [24-Bits]



                                     31 
                                     32 
                           000080    33 STACK_SIZE=128
                           0017FF    34 STACK_EMPTY=RAM_SIZE-1 
                           000080    35 DISPLAY_BUFFER_SIZE=128 ; horz pixels   
                                     36 
                                     37 ;;-----------------------------------
                                     38     .area SSEG (ABS)
                                     39 ;; working buffers and stack at end of RAM. 	
                                     40 ;;-----------------------------------
      00177E                         41     .org RAM_END - STACK_SIZE - 1
      00177E                         42 free_ram_end: 
      00177E                         43 stack_full: .ds STACK_SIZE   ; control stack 
      0017FE                         44 stack_unf: ; stack underflow ; control_stack bottom 
                                     45 
                                     46 ;;--------------------------------------
                                     47     .area HOME 
                                     48 ;; interrupt vector table at 0x8000
                                     49 ;;--------------------------------------
                                     50 
      008000 82 00 81 3A             51 	int cold_start	        ; reset
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
      008054 82 00 81 5C             72 	int I2cIntHandler  		; irq19
      008058 82 00 80 80             73 	int NonHandledInterrupt	; irq20
                           000000    74 .if DEBUG 
                                     75 	int UartRxHandler   	; irq21
                           000001    76 .else 
      00805C 82 00 80 80             77 	int NonHandledInterrupt	; irq21
                                     78 .endif	
      008060 82 00 80 80             79 	int NonHandledInterrupt	; irq22
      008064 82 00 80 81             80 	int Timer4UpdateHandler ; irq23
      008068 82 00 80 80             81 	int NonHandledInterrupt	; irq24
      00806C 82 00 80 80             82 	int NonHandledInterrupt	; irq25
      008070 82 00 80 80             83 	int NonHandledInterrupt	; irq26
      008074 82 00 80 80             84 	int NonHandledInterrupt	; irq27
      008078 82 00 80 80             85 	int NonHandledInterrupt	; irq28
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
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
                                    110 ;OLED display 
      00001D                        111 cur_y: .blkb 1 ; text cursor x coord in char position {0..20} 
      00001E                        112 cur_x: .blkb 1 ;  text cursor y coord  in line position {0..7}
      00001F                        113 start_page: .blkb 1 ; display start page 
                                    114 
                           000000   115 .if DEBUG 
                                    116 ; usart queue 
                                    117 rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
                                    118 rx1_head:  .blkb 1 ; rx1_queue head pointer
                                    119 rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
                                    120 ; transaction input buffer 
                                    121 tib: .ds TIB_SIZE
                                    122 count: .blkb 1 ; character count in tib  
                                    123 .endif ; DEBUG 
                                    124 
      000100                        125 	.org 0x100
      000100                        126 co_code: .blkb 1	
      000101                        127 disp_buffer: .ds DISPLAY_BUFFER_SIZE ; oled display page buffer 
                                    128 
      000181                        129 free_ram: ; from here RAM free up to free_ram_end 
                                    130 
                                    131 
                                    132 	.area CODE 
                                    133 
                                    134 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    135 ; non handled interrupt 
                                    136 ; reset MCU
                                    137 ;;;;;;;;;;;;;;;;;;;;;;;;;;;
      008080                        138 NonHandledInterrupt:
      008080 80               [11]  139 	iret 
                                    140 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
Hexadecimal [24-Bits]



                                    141 ;------------------------------
                                    142 ; TIMER 4 is used to maintain 
                                    143 ; timers and ticks 
                                    144 ; interrupt interval is 1.664 msec 
                                    145 ;--------------------------------
      008081                        146 Timer4UpdateHandler:
      008081 72 5F 53 42      [ 1]  147 	clr TIM4_SR 
      000005                        148 	_ldxz ticks
      008085 BE 08                    1     .byte 0xbe,ticks 
      008087 5C               [ 1]  149 	incw x 
      000008                        150 	_strxz ticks
      008088 BF 08                    1     .byte 0xbf,ticks 
                                    151 ; decrement delay_timer and sound_timer on ticks mod 10==0
      00808A A6 0A            [ 1]  152 	ld a,#10
      00808C 62               [ 2]  153 	div x,a 
      00808D 4D               [ 1]  154 	tnz a
      00808E 26 1E            [ 1]  155 	jrne 9$
      008090                        156 1$:	 
      008090 72 0F 00 14 0A   [ 2]  157 	btjf flags,#F_GAME_TMR,2$  
      008095 72 5A 00 0A      [ 1]  158 	dec delay_timer 
      008099 26 04            [ 1]  159 	jrne 2$ 
      00809B 72 1F 00 14      [ 1]  160 	bres flags,#F_GAME_TMR  
      00809F                        161 2$:
      00809F 72 0D 00 14 0A   [ 2]  162 	btjf flags,#F_SOUND_TMR,9$
      0080A4 72 5A 00 0B      [ 1]  163 	dec sound_timer 
      0080A8 26 04            [ 1]  164 	jrne 9$ 
      0080AA 72 1D 00 14      [ 1]  165 	bres flags,#F_SOUND_TMR
      0080AE                        166 9$:
      0080AE 80               [11]  167 	iret 
                                    168 
                                    169 
                                    170 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    171 ;    peripherals initialization
                                    172 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    173 
                                    174 ;----------------------------------------
                                    175 ; inialize MCU clock 
                                    176 ; HSI no divisor 
                                    177 ; FMSTR=16Mhz 
                                    178 ;----------------------------------------
      0080AF                        179 clock_init:	
      0080AF 72 5F 50 C6      [ 1]  180 	clr CLK_CKDIVR 
      0080B3 81               [ 4]  181 	ret
                                    182 
                                    183 ;---------------------------------
                                    184 ; TIM4 is configured to generate an 
                                    185 ; interrupt every 1.66 millisecond 
                                    186 ;----------------------------------
      0080B4                        187 timer4_init:
      0080B4 72 18 50 C7      [ 1]  188 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM4
      0080B8 72 11 53 40      [ 1]  189 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080BC 35 07 53 45      [ 1]  190 	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
      0080C0 35 83 53 46      [ 1]  191 	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
      0080C4 35 05 53 40      [ 1]  192 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080C8 72 10 53 41      [ 1]  193 	bset TIM4_IER,#TIM4_IER_UIE
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



                                    194 ; set int level to 1 
                           000000   195 .if 0
                                    196 	ld a,#ITC_SPR_LEVEL1 
                                    197 	ldw x,#INT_TIM4_OVF 
                                    198 	call set_int_priority
                                    199 	bres flags,#F_GAME_TMR
                                    200 	bres flags,#F_SOUND_TMR 
                                    201 .endif 
      0080CC 81               [ 4]  202 	ret
                                    203 
                                    204 ;----------------------------------
                                    205 ; TIMER2 used as audio tone output 
                                    206 ; on port D:4. CN3-13
                                    207 ; channel 1 configured as PWM mode 1 
                                    208 ;-----------------------------------  
      0080CD                        209 timer2_init:
      0080CD 72 1A 50 C7      [ 1]  210 	bset CLK_PCKENR1,#CLK_PCKENR1_TIM2 ; enable TIMER2 clock 
      0080D1 35 60 53 05      [ 1]  211  	mov TIM2_CCMR1,#(6<<TIM2_CCMR_OCM) ; PWM mode 1 
      0080D5 35 08 53 0C      [ 1]  212 	mov TIM2_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
      0080D9 72 10 53 00      [ 1]  213 	bset TIM2_CR1,#TIM2_CR1_CEN
      0080DD 72 11 53 08      [ 1]  214 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      0080E1 81               [ 4]  215 	ret 
                                    216 
                           000000   217 .if 0
                                    218 ;--------------------------
                                    219 ; set software interrupt 
                                    220 ; priority 
                                    221 ; input:
                                    222 ;   A    priority 1,2,3 
                                    223 ;   X    vector 
                                    224 ;---------------------------
                                    225 	SPR_ADDR=1 
                                    226 	PRIORITY=3
                                    227 	SLOT=4
                                    228 	MASKED=5  
                                    229 	VSIZE=5
                                    230 set_int_priority::
                                    231 	_vars VSIZE
                                    232 	and a,#3  
                                    233 	ld (PRIORITY,sp),a 
                                    234 	ld a,#4 
                                    235 	div x,a 
                                    236 	sll a  ; slot*2 
                                    237 	ld (SLOT,sp),a
                                    238 	addw x,#ITC_SPR1 
                                    239 	ldw (SPR_ADDR,sp),x 
                                    240 ; build mask
                                    241 	ldw x,#0xfffc 	
                                    242 	ld a,(SLOT,sp)
                                    243 	jreq 2$ 
                                    244 	scf 
                                    245 1$:	rlcw x 
                                    246 	dec a 
                                    247 	jrne 1$
                                    248 2$:	ld a,xl 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



                                    249 ; apply mask to slot 
                                    250 	ldw x,(SPR_ADDR,sp)
                                    251 	and a,(x)
                                    252 	ld (MASKED,sp),a 
                                    253 ; shift priority to slot 
                                    254 	ld a,(PRIORITY,sp)
                                    255 	ld xl,a 
                                    256 	ld a,(SLOT,sp)
                                    257 	jreq 4$
                                    258 3$:	sllw x 
                                    259 	dec a 
                                    260 	jrne 3$
                                    261 4$:	ld a,xl 
                                    262 	or a,(MASKED,sp)
                                    263 	ldw x,(SPR_ADDR,sp)
                                    264 	ld (x),a 
                                    265 	_drop VSIZE 
                                    266 	ret
                                    267 .endif ;DEBUG 
                                    268 
                                    269 ;------------------------
                                    270 ; suspend execution 
                                    271 ; input:
                                    272 ;   A     n/60 seconds  
                                    273 ;-------------------------
      0080E2                        274 pause:
      000062                        275 	_straz delay_timer 
      0080E2 B7 0A                    1     .byte 0xb7,delay_timer 
      0080E4 72 1E 00 14      [ 1]  276 	bset flags,#F_GAME_TMR 
      0080E8 8F               [10]  277 1$: wfi 	
      0080E9 72 0E 00 14 FA   [ 2]  278 	btjt flags,#F_GAME_TMR,1$ 
      0080EE 81               [ 4]  279 	ret 
                                    280 
                                    281 ;--------------------------
                                    282 ; sound timer blocking 
                                    283 ; delay 
                                    284 ; input:
                                    285 ;   A    n*10 msec
                                    286 ;--------------------------
      0080EF                        287 sound_pause:
      00006F                        288 	_straz sound_timer  
      0080EF B7 0B                    1     .byte 0xb7,sound_timer 
      0080F1 72 1C 00 14      [ 1]  289 	bset flags,#F_SOUND_TMR 
      0080F5 8F               [10]  290 1$: wfi 
      0080F6 72 0C 00 14 FA   [ 2]  291 	btjt flags,#F_SOUND_TMR,1$
      0080FB 72 11 53 00      [ 1]  292 	bres TIM2_CR1,#TIM2_CR1_CEN 
      0080FF 72 11 53 08      [ 1]  293 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      008103 72 10 53 04      [ 1]  294 	bset TIM2_EGR,#TIM2_EGR_UG
      008107 81               [ 4]  295 9$:	ret 
                                    296 
                                    297 ;-----------------------
                                    298 ; tone generator 
                                    299 ; Ft2clk=62500 hertz 
                                    300 ; input:
                                    301 ;   A   duration n*10 msec    
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



                                    302 ;   X   frequency 
                                    303 ;------------------------
                           00F424   304 FR_T2_CLK=62500
      008108                        305 tone:
      008108 90 89            [ 2]  306 	pushw y 
      00810A 88               [ 1]  307 	push a 
      00810B 90 93            [ 1]  308 	ldw y,x 
      00810D AE F4 24         [ 2]  309 	ldw x,#FR_T2_CLK 
      008110 65               [ 2]  310 	divw x,y 
      008111 9E               [ 1]  311 	ld a,xh 
      008112 C7 53 0D         [ 1]  312 	ld TIM2_ARRH,a 
      008115 9F               [ 1]  313 	ld a,xl 
      008116 C7 53 0E         [ 1]  314 	ld TIM2_ARRL,a 
      008119 54               [ 2]  315 	srlw x 
      00811A 9E               [ 1]  316 	ld a,xh 
      00811B C7 53 0F         [ 1]  317 	ld TIM2_CCR1H,a 
      00811E 9F               [ 1]  318 	ld a,xl 
      00811F C7 53 10         [ 1]  319 	ld TIM2_CCR1L,a 
      008122 72 10 53 08      [ 1]  320 	bset TIM2_CCER1,#TIM2_CCER1_CC1E
      008126 72 10 53 00      [ 1]  321 	bset TIM2_CR1,#TIM2_CR1_CEN 
      00812A 84               [ 1]  322 	pop a 
      00812B CD 80 EF         [ 4]  323 	call sound_pause 
      00812E 90 85            [ 2]  324 	popw y 
      008130 81               [ 4]  325 	ret 
                                    326 
                                    327 ;-----------------
                                    328 ; 1Khz beep 
                                    329 ;-----------------
      008131                        330 beep:
      008131 AE 03 E8         [ 2]  331 	ldw x,#1000 ; hertz 
      008134 A6 14            [ 1]  332 	ld a,#20
      008136 CD 81 08         [ 4]  333 	call tone  
      008139 81               [ 4]  334 	ret 
                                    335 
                           000000   336 .if DEBUG 
                                    337 ;---------------------------------
                                    338 ; Pseudo Random Number Generator 
                                    339 ; XORShift algorithm.
                                    340 ;---------------------------------
                                    341 
                                    342 ;---------------------------------
                                    343 ;  seedx:seedy= x:y ^ seedx:seedy
                                    344 ; output:
                                    345 ;  X:Y   seedx:seedy new value   
                                    346 ;---------------------------------
                                    347 xor_seed32:
                                    348     ld a,xh 
                                    349     _xorz seedx 
                                    350     _straz seedx
                                    351     ld a,xl 
                                    352     _xorz seedx+1 
                                    353     _straz seedx+1 
                                    354     ld a,yh 
                                    355     _xorz seedy
                                    356     _straz seedy 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



                                    357     ld a,yl 
                                    358     _xorz seedy+1 
                                    359     _straz seedy+1 
                                    360     _ldxz seedx  
                                    361     _ldyz seedy 
                                    362     ret 
                                    363 
                                    364 ;-----------------------------------
                                    365 ;   x:y= x:y << a 
                                    366 ;  input:
                                    367 ;    A     shift count 
                                    368 ;    X:Y   uint32 value 
                                    369 ;  output:
                                    370 ;    X:Y   uint32 shifted value   
                                    371 ;-----------------------------------
                                    372 sll_xy_32: 
                                    373     sllw y 
                                    374     rlcw x
                                    375     dec a 
                                    376     jrne sll_xy_32 
                                    377     ret 
                                    378 
                                    379 ;-----------------------------------
                                    380 ;   x:y= x:y >> a 
                                    381 ;  input:
                                    382 ;    A     shift count 
                                    383 ;    X:Y   uint32 value 
                                    384 ;  output:
                                    385 ;    X:Y   uint32 shifted value   
                                    386 ;-----------------------------------
                                    387 srl_xy_32: 
                                    388     srlw x 
                                    389     rrcw y 
                                    390     dec a 
                                    391     jrne srl_xy_32 
                                    392     ret 
                                    393 
                                    394 ;-------------------------------------
                                    395 ;  PRNG generator proper 
                                    396 ; input:
                                    397 ;   none 
                                    398 ; ouput:
                                    399 ;   X     bits 31...16  PRNG seed  
                                    400 ;  use: 
                                    401 ;   seedx:seedy   system variables   
                                    402 ;--------------------------------------
                                    403 prng::
                                    404 	pushw y   
                                    405     _ldxz seedx
                                    406 	_ldyz seedy  
                                    407 	ld a,#13
                                    408     call sll_xy_32 
                                    409     call xor_seed32
                                    410     ld a,#17 
                                    411     call srl_xy_32
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



                                    412     call xor_seed32 
                                    413     ld a,#5 
                                    414     call sll_xy_32
                                    415     call xor_seed32
                                    416     popw y 
                                    417     ret 
                                    418 
                                    419 
                                    420 ;---------------------------------
                                    421 ; initialize seedx:seedy 
                                    422 ; input:
                                    423 ;    X    0 -> seedx=ticks, seedy=tib[0..1] 
                                    424 ;    X    !0 -> seedx=X, seedy=[0x60<<8|XL]
                                    425 ;-------------------------------------------
                                    426 set_seed:
                                    427     tnzw x 
                                    428     jrne 1$ 
                                    429     ldw x,ticks 
                                    430     _strxz seedx
                                    431     ldw x,disp_buffer  
                                    432     _strxz seedy  
                                    433     ret 
                                    434 1$:  
                                    435     _strxz seedx
                                    436     _clrz seedy 
                                    437     _clrz seedy+1
                                    438     ret 
                                    439 
                                    440 ;----------------------------
                                    441 ;  read keypad 
                                    442 ; output:
                                    443 ;    A    keypress|0
                                    444 ;----------------------------
                                    445 key:
                                    446 	ld a,BTN_IDR 
                                    447 	and a,#ALL_KEY_UP
                                    448     ret 
                                    449 
                                    450 ;----------------------------
                                    451 ; wait for key press 
                                    452 ; output:
                                    453 ;    A    key 
                                    454 ;----------------------------
                                    455 	KPAD=1
                                    456 wait_key:
                                    457 	push #ALL_KEY_UP 
                                    458 1$:	
                                    459 	ld a,BTN_IDR 
                                    460 	and a,#ALL_KEY_UP 
                                    461 	cp a,#ALL_KEY_UP
                                    462 	jreq 1$
                                    463 	ld (KPAD,sp),a  
                                    464 ; debounce
                                    465 	mov delay_timer,#2
                                    466 	bset flags,#F_GAME_TMR
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



                                    467 2$: ld a,BTN_IDR 
                                    468 	and a,#ALL_KEY_UP 
                                    469 	cp a,(KPAD,sp)
                                    470 	jrne 1$
                                    471 	btjt flags,#F_GAME_TMR,2$ 
                                    472 	pop a  
                                    473 	ret 
                                    474 .endif ; DEBUG 
                                    475 
                                    476 ;-------------------------------------
                                    477 ;  initialization entry point 
                                    478 ;-------------------------------------
      00813A                        479 cold_start:
                                    480 ;set stack 
      00813A AE 17 FF         [ 2]  481 	ldw x,#STACK_EMPTY
      00813D 94               [ 1]  482 	ldw sp,x
                                    483 ; clear all ram 
      00813E 7F               [ 1]  484 0$: clr (x)
      00813F 5A               [ 2]  485 	decw x 
      008140 26 FC            [ 1]  486 	jrne 0$
      008142 CD 80 AF         [ 4]  487     call clock_init 
                           000000   488 .if DEBUG 
                                    489 ; set pull up on PC_IDR (buttons input)
                                    490 	cLr BTN_PORT+GPIO_DDR
                                    491 	mov BTN_PORT+GPIO_CR1,#255
                                    492 .endif ; DEBUG 
                                    493 ; set sound output 	
      008145 72 18 50 11      [ 1]  494 	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT 
      008149 72 18 50 12      [ 1]  495 	bset SOUND_PORT+GPIO_CR1,#SOUND_BIT 
                           000000   496 .if DEBUG 
                                    497 	call uart_init 
                                    498 .endif ;DEBUG 	
      00814D CD 80 B4         [ 4]  499 	call timer4_init ; msec ticks timer 
      008150 CD 80 CD         [ 4]  500 	call timer2_init ; tone generator 
      008153 A6 01            [ 1]  501 	ld a,#I2C_FAST   
      008155 CD 82 7A         [ 4]  502 	call i2c_init 
      008158 9A               [ 1]  503 	rim ; enable interrupts
                           000000   504 .if DEBUG 
                                    505 ; RND function seed 
                                    506 ; must be initialized 
                                    507 ; to value other than 0.
                                    508 ; take values from FLASH space 
                                    509 	ldw x,#I2cIntHandler
                                    510 	ldw seedy,x  
                                    511 	ldw x,#test_code 
                                    512 	ldw seedx,x  
                                    513     jp test_code  	
                           000001   514 .else 
      008159 CC 87 BD         [ 2]  515 	jp app 
                                    516 .endif ; DEBUG 
                                    517 
                                    518 
                                    519 
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
      00815C                         39 I2cIntHandler:
      00815C C6 52 18         [ 1]   40     ld a, I2C_SR2 ; errors status 
      00815F 72 5F 52 18      [ 1]   41     clr I2C_SR2 
      008163 A4 0F            [ 1]   42     and a,#15 
      008165 27 0A            [ 1]   43     jreq 1$
      008167 CA 00 1B         [ 1]   44     or a,i2c_status 
      0000EA                         45     _straz i2c_status 
      00816A B7 1B                    1     .byte 0xb7,i2c_status 
      00816C 72 12 52 11      [ 1]   46     bset I2C_CR2,#I2C_CR2_STOP
      008170 80               [11]   47     iret 
      008171                         48 1$: ; no error detected 
      008171 72 0F 00 1B 05   [ 2]   49     btjf i2c_status,#I2C_STATUS_DONE,2$
      008176 72 5F 52 1A      [ 1]   50     clr I2C_ITR 
      00817A 80               [11]   51     iret 
                                     52 ; handle events 
      0000FB                         53 2$: _ldxz i2c_idx  
      00817B BE 19                    1     .byte 0xbe,i2c_idx 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



      00817D 72 00 52 17 1A   [ 2]   54     btjt I2C_SR1,#I2C_SR1_SB,evt_sb 
      008182 72 02 52 17 1B   [ 2]   55     btjt I2C_SR1,#I2C_SR1_ADDR,evt_addr 
      008187 72 04 52 17 31   [ 2]   56     btjt I2C_SR1,#I2C_SR1_BTF,evt_btf  
      00818C 72 0E 52 17 17   [ 2]   57     btjt I2C_SR1,#I2C_SR1_TXE,evt_txe 
      008191 72 0C 52 17 40   [ 2]   58     btjt I2C_SR1,#I2C_SR1_RXNE,evt_rxne 
      008196 72 08 52 17 56   [ 2]   59     btjt I2C_SR1,#I2C_SR1_STOPF,evt_stopf 
      00819B 80               [11]   60     iret 
                                     61 
      00819C                         62 evt_sb: ; EV5  start bit sent 
      00011C                         63     _ldaz i2c_devid
      00819C B6 1C                    1     .byte 0xb6,i2c_devid 
      00819E C7 52 16         [ 1]   64     ld I2C_DR,a ; send device address 
      0081A1 80               [11]   65     iret 
                                     66 
      0081A2                         67 evt_addr: ; EV6  address sent, send data bytes  
      0081A2 72 04 52 19 01   [ 2]   68     btjt I2C_SR3,#I2C_SR3_TRA,evt_txe
      0081A7 80               [11]   69     iret 
                                     70 
                                     71 ; master transmit mode 
      0081A8                         72 evt_txe: ; EV8  send data byte 
      000128                         73     _ldyz i2c_count 
      0081A8 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      0081AB 27 1C            [ 1]   74     jreq end_of_tx 
      0081AD                         75 evt_txe_1:
      0081AD 72 D6 00 15      [ 4]   76     ld a,([i2c_buf],x)
      0081B1 C7 52 16         [ 1]   77     ld I2C_DR,a
      0081B4 5C               [ 1]   78     incw x 
      000135                         79     _strxz i2c_idx 
      0081B5 BF 19                    1     .byte 0xbf,i2c_idx 
      0081B7 90 5A            [ 2]   80     decw y  
      000139                         81     _stryz i2c_count  
      0081B9 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      0081BC 80               [11]   82 1$: iret 
                                     83 
                                     84 ; only append if no STOP send 
      0081BD                         85 evt_btf: 
      0081BD 72 05 52 19 14   [ 2]   86     btjf I2C_SR3,#I2C_SR3_TRA,#evt_rxne  
      000142                         87     _ldyz i2c_count 
      0081C2 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      0081C5 26 E6            [ 1]   88     jrne evt_txe_1 
      0081C7 20 00            [ 2]   89     jra end_of_tx 
                                     90 
                                     91 ; end of transmission
      0081C9                         92 end_of_tx:
      0081C9 72 1E 00 1B      [ 1]   93     bset i2c_status,#I2C_STATUS_DONE  
                                     94 ;    btjt i2c_status,#I2C_STATUS_NO_STOP,1$
      0081CD 72 12 52 11      [ 1]   95     bset I2C_CR2,#I2C_CR2_STOP
      0081D1 72 5F 52 1A      [ 1]   96 1$: clr I2C_ITR
      0081D5 80               [11]   97     iret 
                                     98 
                                     99 ; master receive mode 
      0081D6                        100 evt_rxne: 
      000156                        101     _ldyz i2c_count 
      0081D6 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      0081D9 27 16            [ 1]  102     jreq evt_stopf  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



      0081DB C6 52 16         [ 1]  103 1$: ld a,I2C_DR 
      0081DE 72 D7 00 15      [ 4]  104     ld ([i2c_buf],x),a  
      0081E2 5C               [ 1]  105     incw x 
      000163                        106     _strxz i2c_idx 
      0081E3 BF 19                    1     .byte 0xbf,i2c_idx 
      0081E5 90 5A            [ 2]  107     decw y 
      000167                        108     _stryz i2c_count
      0081E7 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      0081EA 26 04            [ 1]  109     jrne 4$
      0081EC 72 15 52 11      [ 1]  110     bres I2C_CR2,#I2C_CR2_ACK
      0081F0 80               [11]  111 4$: iret 
                                    112 
      0081F1                        113 evt_stopf:
      0081F1 C6 52 16         [ 1]  114     ld a,I2C_DR 
      0081F4 72 D7 00 15      [ 4]  115     ld ([i2c_buf],x),a 
      0081F8 72 12 52 11      [ 1]  116     bset I2C_CR2,#I2C_CR2_STOP
      0081FC 72 1E 00 1B      [ 1]  117     bset i2c_status,#I2C_STATUS_DONE
      008200 72 5F 52 1A      [ 1]  118     clr I2C_ITR 
      008204 80               [11]  119     iret  
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
      008205                        138 i2c_error:
      000185                        139     _ldaz i2c_status 
      008205 B6 1B                    1     .byte 0xb6,i2c_status 
      008207 4E               [ 1]  140     swap a 
      008208 C7 00 11         [ 1]  141     ld acc8,a 
      00820B 4B 04            [ 1]  142     push #4 
      00820D                        143 nibble_loop:     
      00820D A6 0C            [ 1]  144     ld a,#12 
      00820F CD 81 31         [ 4]  145     call beep 
      008212 72 58 00 11      [ 1]  146     sll acc8  
      008216 25 05            [ 1]  147     jrc blink1 
      008218                        148 blink0:
      008218 AE 00 C8         [ 2]  149     ldw x,#200
      00821B 20 03            [ 2]  150     jra blink
      00821D                        151 blink1: 
      00821D AE 02 58         [ 2]  152     ldw x,#600 
      008220                        153 blink:
      008220 CD 80 E2         [ 4]  154     call pause 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



      008223 4F               [ 1]  155     clr a 
      008224 CD 81 31         [ 4]  156     call beep  
      008227 AE 00 C8         [ 2]  157     ldw x,#200 
      00822A CD 80 E2         [ 4]  158     call pause 
      00822D 0A 01            [ 1]  159     dec (1,sp)
      00822F 26 DC            [ 1]  160     jrne nibble_loop 
      008231 84               [ 1]  161     pop a 
      008232 AE 02 BC         [ 2]  162     ldw x,#700 
      008235 CD 80 E2         [ 4]  163     call pause 
      008238 20 CB            [ 2]  164 jra i2c_error     
      00823A 81               [ 4]  165     ret  
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
      00823B                        208 i2c_write:
      00823B 72 00 52 19 FB   [ 2]  209     btjt I2C_SR3,#I2C_SR3_MSL,.
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



      008240 5F               [ 1]  210     clrw x 
      0001C1                        211     _strxz i2c_idx 
      008241 BF 19                    1     .byte 0xbf,i2c_idx 
      008243 A6 07            [ 1]  212     ld a,#(1<<I2C_ITR_ITBUFEN)|(1<<I2C_ITR_ITERREN)|(1<<I2C_ITR_ITEVTEN) 
      008245 C7 52 1A         [ 1]  213     ld I2C_ITR,a 
      008248 A6 05            [ 1]  214     ld a,#(1<<I2C_CR2_START)|(1<<I2C_CR2_ACK)
      00824A C7 52 11         [ 1]  215     ld I2C_CR2,a      
      00824D 72 0F 00 1B FB   [ 2]  216 1$: btjf i2c_status,#I2C_STATUS_DONE,1$ 
      008252 81               [ 4]  217     ret 
                                    218 
                                    219 ;-------------------------------
                                    220 ; set I2C SCL frequency
                                    221 ; parameter:
                                    222 ;    A    {I2C_STD,I2C_FAST}
                                    223 ;-------------------------------
      008253                        224 i2c_scl_freq:
      008253 72 11 52 10      [ 1]  225 	bres I2C_CR1,#I2C_CR1_PE 
      008257 A1 00            [ 1]  226 	cp a,#I2C_STD 
      008259 26 0E            [ 1]  227 	jrne fast
      00825B                        228 std:
      00825B 35 00 52 1C      [ 1]  229 	mov I2C_CCRH,#I2C_CCRH_16MHZ_STD_100 
      00825F 35 50 52 1B      [ 1]  230 	mov I2C_CCRL,#I2C_CCRL_16MHZ_STD_100
      008263 35 11 52 1D      [ 1]  231 	mov I2C_TRISER,#I2C_TRISER_16MHZ_STD_100
      008267 20 0C            [ 2]  232 	jra i2c_scl_freq_exit 
      008269                        233 fast:
      008269 35 80 52 1C      [ 1]  234 	mov I2C_CCRH,#I2C_CCRH_16MHZ_FAST_400 
      00826D 35 0D 52 1B      [ 1]  235 	mov I2C_CCRL,#I2C_CCRL_16MHZ_FAST_400
      008271 35 05 52 1D      [ 1]  236 	mov I2C_TRISER,#I2C_TRISER_16MHZ_FAST_400
      008275                        237 i2c_scl_freq_exit:
      008275 72 10 52 10      [ 1]  238 	bset I2C_CR1,#I2C_CR1_PE 
      008279 81               [ 4]  239 	ret 
                                    240 
                                    241 ;-------------------------------
                                    242 ; initialize I2C peripheral 
                                    243 ; parameter:
                                    244 ;    A    {I2C_STD,I2C_FAST}
                                    245 ;-------------------------------
      00827A                        246 i2c_init:
                                    247 ; set SDA and SCL pins as OD output 
      00827A 72 1B 00 08      [ 1]  248 	bres I2C_PORT+GPIO_CR1,#SDA_BIT
      00827E 72 19 00 08      [ 1]  249 	bres I2C_PORT+GPIO_CR1,#SCL_BIT 
                                    250 ; set I2C peripheral 
      008282 72 10 50 C7      [ 1]  251 	bset CLK_PCKENR1,#CLK_PCKENR1_I2C 
      008286 72 5F 52 10      [ 1]  252 	clr I2C_CR1 
      00828A 72 5F 52 11      [ 1]  253 	clr I2C_CR2 
      00828E 35 10 52 12      [ 1]  254     mov I2C_FREQR,#FMSTR ; peripheral clock frequency 
      008292 AD BF            [ 4]  255 	callr i2c_scl_freq
      008294 72 10 52 10      [ 1]  256 	bset I2C_CR1,#I2C_CR1_PE ; enable peripheral 
      008298 81               [ 4]  257 	ret 
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
      008299                        267 i2c_start:
      008299 72 02 52 19 FB   [ 2]  268     btjt I2C_SR3,#I2C_SR3_BUSY,.
      00829E 72 10 52 11      [ 1]  269 	bset I2C_CR2,#I2C_CR2_START 
      0082A2 72 01 52 17 FB   [ 2]  270 	btjf I2C_SR1,#I2C_SR1_SB,. 
      0082A7 C7 52 16         [ 1]  271 	ld I2C_DR,a 
      0082AA 72 03 52 17 FB   [ 2]  272 	btjf I2C_SR1,#I2C_SR1_ADDR,. 
      0082AF 81               [ 4]  273 	ret 
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
                                     25 ;----------------------------
                                     26 ; initialize OLED display
                                     27 ;----------------------------
      0082B0                         28 oled_init:: 
                                     29 ; multiplex ratio to default 64 
      000230                         30     _send_cmd MUX_RATIO 
      0082B0 A6 A8            [ 1]    1     ld a,#MUX_RATIO 
      0082B2 CD 83 4D         [ 4]    2     call oled_cmd 
      000235                         31     _send_cmd 63
      0082B5 A6 3F            [ 1]    1     ld a,#63 
      0082B7 CD 83 4D         [ 4]    2     call oled_cmd 
                                     32 ; no display offset 
      00023A                         33     _send_cmd DISP_OFFSET 
      0082BA A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      0082BC CD 83 4D         [ 4]    2     call oled_cmd 
      00023F                         34     _send_cmd 0 
      0082BF A6 00            [ 1]    1     ld a,#0 
      0082C1 CD 83 4D         [ 4]    2     call oled_cmd 
                                     35 ; no segment remap SEG0 -> COM0 
      000244                         36     _send_cmd MAP_SEG0_COL0   
      0082C4 A6 A0            [ 1]    1     ld a,#MAP_SEG0_COL0 
      0082C6 CD 83 4D         [ 4]    2     call oled_cmd 
                                     37 ; COMMON scan direction top to bottom 
      000249                         38     _send_cmd SCAN_TOP_DOWN
      0082C9 A6 C0            [ 1]    1     ld a,#SCAN_TOP_DOWN 
      0082CB CD 83 4D         [ 4]    2     call oled_cmd 
                                     39 ; common pins config, bit 5=0, 4=1 
      00024E                         40     _send_cmd COM_CFG 
      0082CE A6 DA            [ 1]    1     ld a,#COM_CFG 
      0082D0 CD 83 4D         [ 4]    2     call oled_cmd 
      000253                         41     _send_cmd COM_DISABLE_REMAP+COM_ALTERNATE
      0082D3 A6 10            [ 1]    1     ld a,#COM_DISABLE_REMAP+COM_ALTERNATE 
      0082D5 CD 83 4D         [ 4]    2     call oled_cmd 
                                     42 ; constrast level 1, lowest 
      000258                         43     _send_cmd DISP_CONTRAST
      0082D8 A6 81            [ 1]    1     ld a,#DISP_CONTRAST 
      0082DA CD 83 4D         [ 4]    2     call oled_cmd 
      00025D                         44     _send_cmd 1
      0082DD A6 01            [ 1]    1     ld a,#1 
      0082DF CD 83 4D         [ 4]    2     call oled_cmd 
                                     45 ; display RAM 
      000262                         46     _send_cmd DISP_RAM
      0082E2 A6 A4            [ 1]    1     ld a,#DISP_RAM 
      0082E4 CD 83 4D         [ 4]    2     call oled_cmd 
                                     47 ; display normal 
      000267                         48     _send_cmd DISP_NORMAL
      0082E7 A6 A6            [ 1]    1     ld a,#DISP_NORMAL 
      0082E9 CD 83 4D         [ 4]    2     call oled_cmd 
                                     49 ; clock frequency=maximum and display divisor=1 
      00026C                         50     _send_cmd CLK_FREQ_DIV
      0082EC A6 D5            [ 1]    1     ld a,#CLK_FREQ_DIV 
      0082EE CD 83 4D         [ 4]    2     call oled_cmd 
      000271                         51     _send_cmd ((15<<CLK_FREQ)+(0<<DISP_DIV)) 
      0082F1 A6 F0            [ 1]    1     ld a,#((15<<CLK_FREQ)+(0<<DISP_DIV)) 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



      0082F3 CD 83 4D         [ 4]    2     call oled_cmd 
                                     52 ; pre-charge phase1=1 and phase2=15
                                     53 ; reducing phase2 value dim display  
      000276                         54     _send_cmd PRE_CHARGE
      0082F6 A6 D9            [ 1]    1     ld a,#PRE_CHARGE 
      0082F8 CD 83 4D         [ 4]    2     call oled_cmd 
      00027B                         55     _send_cmd ((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD))
      0082FB A6 F1            [ 1]    1     ld a,#((1<<PHASE1_PERIOD)+(15<<PHASE2_PERIOD)) 
      0082FD CD 83 4D         [ 4]    2     call oled_cmd 
                                     56 ; RAM addressing mode       
      000280                         57     _send_cmd ADR_MODE 
      008300 A6 20            [ 1]    1     ld a,#ADR_MODE 
      008302 CD 83 4D         [ 4]    2     call oled_cmd 
      000285                         58     _send_cmd PAGE_MODE
      008305 A6 02            [ 1]    1     ld a,#PAGE_MODE 
      008307 CD 83 4D         [ 4]    2     call oled_cmd 
                                     59 ; Vcomh deselect level 0.83volt 
      00028A                         60     _send_cmd VCOMH_DSEL 
      00830A A6 DB            [ 1]    1     ld a,#VCOMH_DSEL 
      00830C CD 83 4D         [ 4]    2     call oled_cmd 
      00028F                         61     _send_cmd VCOMH_DSEL_83
      00830F A6 30            [ 1]    1     ld a,#VCOMH_DSEL_83 
      008311 CD 83 4D         [ 4]    2     call oled_cmd 
                                     62 ; enable charge pump 
      000294                         63     _send_cmd DISP_CHARGE_PUMP
      008314 A6 8D            [ 1]    1     ld a,#DISP_CHARGE_PUMP 
      008316 CD 83 4D         [ 4]    2     call oled_cmd 
      000299                         64     _send_cmd CP_ON 
      008319 A6 14            [ 1]    1     ld a,#CP_ON 
      00831B CD 83 4D         [ 4]    2     call oled_cmd 
                                     65 ; disable scrolling 
      00029E                         66     _send_cmd SCROLL_STOP
      00831E A6 2E            [ 1]    1     ld a,#SCROLL_STOP 
      008320 CD 83 4D         [ 4]    2     call oled_cmd 
                                     67 ; diplay row from 0 
      0002A3                         68     _send_cmd START_LINE 
      008323 A6 40            [ 1]    1     ld a,#START_LINE 
      008325 CD 83 4D         [ 4]    2     call oled_cmd 
                                     69 ; activate display 
      0002A8                         70     _send_cmd DISP_ON 
      008328 A6 AF            [ 1]    1     ld a,#DISP_ON 
      00832A CD 83 4D         [ 4]    2     call oled_cmd 
      00832D 81               [ 4]   71     ret 
                                     72 
                                     73 ;--------------------------------
                                     74 ; set column address to 0:127 
                                     75 ; set page address to 0:7 
                                     76 ;--------------------------------
      00832E                         77 all_display:
                                     78 ; page window 0..7
      0002AE                         79     _send_cmd PAG_WND 
      00832E A6 22            [ 1]    1     ld a,#PAG_WND 
      008330 CD 83 4D         [ 4]    2     call oled_cmd 
      0002B3                         80     _send_cmd 0  
      008333 A6 00            [ 1]    1     ld a,#0 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      008335 CD 83 4D         [ 4]    2     call oled_cmd 
      0002B8                         81     _send_cmd 7 
      008338 A6 07            [ 1]    1     ld a,#7 
      00833A CD 83 4D         [ 4]    2     call oled_cmd 
                                     82 ; columns windows 0..127
      0002BD                         83     _send_cmd COL_WND 
      00833D A6 21            [ 1]    1     ld a,#COL_WND 
      00833F CD 83 4D         [ 4]    2     call oled_cmd 
      0002C2                         84     _send_cmd 0 
      008342 A6 00            [ 1]    1     ld a,#0 
      008344 CD 83 4D         [ 4]    2     call oled_cmd 
      0002C7                         85     _send_cmd 127
      008347 A6 7F            [ 1]    1     ld a,#127 
      008349 CD 83 4D         [ 4]    2     call oled_cmd 
      00834C 81               [ 4]   86     ret 
                                     87 
                                     88 
                           000000    89 .if 0
                                     90 ;------------------------
                                     91 ; scroll display left|right  
                                     92 ; input:
                                     93 ;     A   SCROLL_LEFT|SCROLL_RIGHT 
                                     94 ;     XL  speed 
                                     95 ;------------------------
                                     96 scroll:
                                     97     pushw x 
                                     98     call oled_cmd 
                                     99     _send_cmd 0 ; dummy byte  
                                    100     _send_cmd 0 ; start page 0 
                                    101     pop a ; 
                                    102     pop a ; 
                                    103     call oled_cmd ;speed  
                                    104     _send_cmd 7 ; end page 
                                    105     _send_cmd 0 ; dummy 
                                    106     _send_cmd 255 ; dummy
                                    107     _send_cmd SCROLL_START 
                                    108     ret 
                                    109 
                                    110 ;---------------------------------
                                    111 ; enable/disable charge pump 
                                    112 ; parameters:
                                    113 ;    A    CP_OFF|CP_ON 
                                    114 ;---------------------------------
                                    115 charge_pump_switch:
                                    116     push a 
                                    117     _send_cmd DISP_CHARGE_PUMP
                                    118     pop a 
                                    119     jra oled_cmd 
                                    120 
                                    121 .endif 
                                    122 
                                    123 ;---------------------------------
                                    124 ; send command to OLED 
                                    125 ; parameters:
                                    126 ;     A     command code  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



                                    127 ;---------------------------------
      00834D                        128 oled_cmd:
                                    129 ;    ldw x,#2 
                                    130 ;    _strxz i2c_count 
      0002CD                        131     _clrz i2c_count 
      00834D 3F 17                    1     .byte 0x3f, i2c_count 
      00834F 35 02 00 18      [ 1]  132     mov i2c_count+1,#2
      008353 AE 01 00         [ 2]  133     ldw x,#co_code 
      008356 E7 01            [ 1]  134     ld (1,x),a 
      008358 A6 80            [ 1]  135     ld a,#OLED_CMD 
      00835A                        136 oled_send:
      00835A F7               [ 1]  137     ld (x),a   
      0002DB                        138     _strxz i2c_buf 
      00835B BF 15                    1     .byte 0xbf,i2c_buf 
      00835D 35 78 00 1C      [ 1]  139     mov i2c_devid,#OLED_DEVID 
      0002E1                        140     _clrz i2c_status
      008361 3F 1B                    1     .byte 0x3f, i2c_status 
      008363 CD 82 3B         [ 4]  141     call i2c_write
      008366 81               [ 4]  142     ret 
                                    143 
                                    144 ;---------------------------------
                                    145 ; send data to OLED GDDRAM
                                    146 ; parameters:
                                    147 ;     X     byte count  
                                    148 ;---------------------------------
      008367                        149 oled_data:
      008367 5C               [ 1]  150     incw x   
      0002E8                        151     _strxz i2c_count 
      008368 BF 17                    1     .byte 0xbf,i2c_count 
      00836A AE 01 00         [ 2]  152     ldw x,#co_code 
      00836D A6 40            [ 1]  153     ld a,#OLED_DATA 
      00836F 20 E9            [ 2]  154     jra oled_send  
                                    155 
                                    156 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



                                      1  
                                      2  ;
                                      3 ; Copyright Jacques Deschênes 2023 
                                      4 ; This file is part of stm8_ssd1306 
                                      5 ;
                                      6 ;     stm8_ssd1306 is free software: you can redistribute it and/or modify
                                      7 ;     it under the terms of the GNU General Public License as published by
                                      8 ;     the Free Software Foundation, either version 3 of the License, or
                                      9 ;     (at your option) any later version.
                                     10 ;
                                     11 ;     stm8_ssd1306 is distributed in the hope that it will be useful,
                                     12 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     13 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     14 ;     GNU General Public License for more details.
                                     15 ;
                                     16 ;     You should have received a copy of the GNU General Public License
                                     17 ;     along with stm8_ssd1306.  If not, see <http://www.gnu.org/licenses/>.
                                     18 ;;
                                     19 
                                     20 
                                     21 
                                     22 ;; small hexadecimal font, 4x5 pixels 
                           000004    23 SF_WIDTH=4
                           000005    24 SF_HEIGHT=5
      008371                         25 font_hex_4x5:
      008371 E0 A0 A0 A0 E0          26     .byte 0xe0,0xa0,0xa0,0xa0,0xe0 ;0
      008376 C0 40 40 40 E0          27     .byte 0xc0,0x40,0x40,0x40,0xe0 ;1
      00837B E0 20 E0 80 E0          28     .byte 0xe0,0x20,0xe0,0x80,0xe0 ;2
      008380 E0 20 E0 20 E0          29     .byte 0xe0,0x20,0xe0,0x20,0xe0 ;3
      008385 A0 A0 E0 20 20          30     .byte 0xa0,0xa0,0xe0,0x20,0x20 ;4
      00838A E0 80 E0 20 E0          31     .byte 0xe0,0x80,0xe0,0x20,0xe0 ;5
      00838F 80 80 E0 A0 E0          32     .byte 0x80,0x80,0xe0,0xa0,0xe0 ;6
      008394 E0 20 20 20 20          33     .byte 0xe0,0x20,0x20,0x20,0x20 ;7
      008399 E0 A0 E0 A0 E0          34     .byte 0xe0,0xa0,0xe0,0xa0,0xe0 ;8
      00839E E0 A0 E0 20 20          35     .byte 0xe0,0xa0,0xe0,0x20,0x20 ;9
      0083A3 E0 A0 E0 A0 A0          36     .byte 0xe0,0xa0,0xe0,0xa0,0xa0 ;A
      0083A8 C0 A0 C0 A0 C0          37     .byte 0xc0,0xa0,0xc0,0xa0,0xc0 ;B
      0083AD E0 80 80 80 E0          38     .byte 0xe0,0x80,0x80,0x80,0xe0 ;C
      0083B2 C0 A0 A0 A0 C0          39     .byte 0xc0,0xa0,0xa0,0xa0,0xc0 ;D
      0083B7 E0 80 E0 80 E0          40     .byte 0xe0,0x80,0xe0,0x80,0xe0 ;E
      0083BC E0 80 E0 80 80          41     .byte 0xe0,0x80,0xe0,0x80,0x80 ;F
                                     42 
                                     43 
                                     44 ;; large hexadecimal font, 8x10 pixels
                           000008    45 LF_WIDTH=8 
                           00000A    46 LF_HEIGHT=10 
      0083C1                         47 font_hex_8x10:
      0083C1 7C 82 86 8A 92 A2 C2    48     .byte 0x7c,0x82,0x86,0x8a,0x92,0xa2,0xc2,0x82,0x7c,0x00 ; 0
             82 7C 00
      0083CB 08 18 28 08 08 08 08    49     .byte 0x08,0x18,0x28,0x08,0x08,0x08,0x08,0x08,0x3e,0x00 ; 1
             08 3E 00
      0083D5 38 44 82 04 08 10 20    50     .byte 0x38,0x44,0x82,0x04,0x08,0x10,0x20,0x40,0xfe,0x00 ; 2
             40 FE 00
      0083DF 38 44 82 02 3C 02 82    51     .byte 0x38,0x44,0x82,0x02,0x3c,0x02,0x82,0x44,0x38,0x00 ; 3
             44 38 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



      0083E9 84 84 84 84 7E 04 04    52     .byte 0x84,0x84,0x84,0x84,0x7e,0x04,0x04,0x04,0x04,0x00 ; 4
             04 04 00
      0083F3 7E 80 80 80 7C 02 02    53     .byte 0x7e,0x80,0x80,0x80,0x7c,0x02,0x02,0x02,0xfe,0x00 ; 5
             02 FE 00
      0083FD 78 84 80 80 FC 82 82    54     .byte 0x78,0x84,0x80,0x80,0xfc,0x82,0x82,0x82,0x7c,0x00 ; 6
             82 7C 00
      008407 7E 82 04 08 08 08 08    55     .byte 0x7e,0x82,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x00 ; 7
             08 08 00
      008411 38 44 82 82 7C 82 82    56     .byte 0x38,0x44,0x82,0x82,0x7c,0x82,0x82,0x44,0x38,0x00 ; 8
             44 38 00
      00841B 38 44 82 82 46 3A 02    57     .byte 0x38,0x44,0x82,0x82,0x46,0x3a,0x02,0x04,0x38,0x00 ; 9
             04 38 00
      008425 38 44 82 82 FE 82 82    58     .byte 0x38,0x44,0x82,0x82,0xfe,0x82,0x82,0x82,0x82,0x00 ; A
             82 82 00
      00842F FC 82 82 82 FC 82 82    59     .byte 0xfc,0x82,0x82,0x82,0xfc,0x82,0x82,0x82,0xfc,0x00 ; B
             82 FC 00
      008439 3E 40 80 80 80 80 80    60     .byte 0x3e,0x40,0x80,0x80,0x80,0x80,0x80,0x40,0x3e,0x00 ; C
             40 3E 00
      008443 F8 84 82 82 82 82 82    61     .byte 0xf8,0x84,0x82,0x82,0x82,0x82,0x82,0x84,0xf8,0x00 ; D
             84 F8 00
      00844D FE 80 80 80 FE 80 80    62     .byte 0xfe,0x80,0x80,0x80,0xfe,0x80,0x80,0x80,0xfe,0x00 ; E
             80 FE 00
      008457 FE 80 80 80 FE 80 80    63     .byte 0xfe,0x80,0x80,0x80,0xfe,0x80,0x80,0x80,0x80,0x00 ; F
             80 80 00
                                     64 
                                     65 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
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
      008461                         24 oled_font_6x8: 
      008461 00 00 00 00 00 00       25 .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; space ASCII 32
      008467 00 00 5F 00 00 00       26 .byte 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 ; !
      00846D 00 07 00 07 00 00       27 .byte 0x00, 0x07, 0x00, 0x07, 0x00, 0x00 ; "
      008473 14 7F 14 7F 14 00       28 .byte 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 ; #
      008479 24 2A 7F 2A 12 00       29 .byte 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 ; $
      00847F 23 13 08 64 62 00       30 .byte 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 ; %
      008485 36 49 55 22 50 00       31 .byte 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 ; &
      00848B 00 05 03 00 00 00       32 .byte 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 ; '
      008491 00 1C 22 41 00 00       33 .byte 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 ; (
      008497 00 41 22 1C 00 00       34 .byte 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 ; )
      00849D 14 08 3E 08 14 00       35 .byte 0x14, 0x08, 0x3E, 0x08, 0x14, 0x00 ; *
      0084A3 08 08 3E 08 08 00       36 .byte 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 ; +
      0084A9 00 D8 78 38 00 00       37 .byte 0x00, 0xD8, 0x78, 0x38, 0x00, 0x00 ; ,
      0084AF 08 08 08 08 00 00       38 .byte 0x08, 0x08, 0x08, 0x08, 0x00, 0x00 ; -
      0084B5 00 60 60 60 00 00       39 .byte 0x00, 0x60, 0x60, 0x60, 0x00, 0x00 ; .
      0084BB 00 20 34 18 0C 06       40 .byte 0x00, 0x20, 0x34, 0x18, 0x0C, 0x06 ; /
      0084C1 3E 51 49 45 3E 00       41 .byte 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 ; 0
      0084C7 40 42 7F 40 40 00       42 .byte 0x40, 0x42, 0x7F, 0x40, 0x40, 0x00 ; 1
      0084CD 62 51 49 45 42 00       43 .byte 0x62, 0x51, 0x49, 0x45, 0x42, 0x00 ; 2
      0084D3 49 49 49 49 36 00       44 .byte 0x49, 0x49, 0x49, 0x49, 0x36, 0x00 ; 3
      0084D9 18 14 12 7F 10 00       45 .byte 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 ; 4
      0084DF 4F 49 49 49 31 00       46 .byte 0x4F, 0x49, 0x49, 0x49, 0x31, 0x00 ; 5
      0084E5 3C 4A 49 49 30 00       47 .byte 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 ; 6
      0084EB 01 71 09 05 03 00       48 .byte 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 ; 7
      0084F1 36 49 49 49 36 00       49 .byte 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 ; 8
      0084F7 06 49 49 49 36 00       50 .byte 0x06, 0x49, 0x49, 0x49, 0x36, 0x00 ; 9
      0084FD 00 36 36 36 00 00       51 .byte 0x00, 0x36, 0x36, 0x36, 0x00, 0x00 ; :
      008503 00 F6 76 36 00 00       52 .byte 0x00, 0xF6, 0x76, 0x36, 0x00, 0x00 ; ;
      008509 08 14 22 41 00 00       53 .byte 0x08, 0x14, 0x22, 0x41, 0x00, 0x00 ; <
      00850F 14 14 14 14 14 00       54 .byte 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 ; =
      008515 00 41 22 14 08 00       55 .byte 0x00, 0x41, 0x22, 0x14, 0x08, 0x00 ; >
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      00851B 02 01 51 09 06 00       56 .byte 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 ; ?
      008521 32 49 79 41 3E 00       57 .byte 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 ; @
      008527 7E 09 09 09 7E 00       58 .byte 0x7E, 0x09, 0x09, 0x09, 0x7E, 0x00 ; A
      00852D 7F 49 49 49 36 00       59 .byte 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 ; B
      008533 3E 41 41 41 41 00       60 .byte 0x3E, 0x41, 0x41, 0x41, 0x41, 0x00 ; C
      008539 7F 41 41 41 3E 00       61 .byte 0x7F, 0x41, 0x41, 0x41, 0x3E, 0x00 ; D
      00853F 7F 49 49 49 49 00       62 .byte 0x7F, 0x49, 0x49, 0x49, 0x49, 0x00 ; E
      008545 7F 09 09 09 09 00       63 .byte 0x7F, 0x09, 0x09, 0x09, 0x09, 0x00 ; F
      00854B 3E 41 49 49 31 00       64 .byte 0x3E, 0x41, 0x49, 0x49, 0x31, 0x00 ; G
      008551 7F 08 08 08 7F 00       65 .byte 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 ; H
      008557 00 41 7F 41 00 00       66 .byte 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 ; I
      00855D 20 41 41 21 1F 00       67 .byte 0x20, 0x41, 0x41, 0x21, 0x1F, 0x00 ; J
      008563 7F 08 14 22 41 00       68 .byte 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 ; K
      008569 7F 40 40 40 40 00       69 .byte 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 ; L
      00856F 7F 02 04 02 7F 00       70 .byte 0x7F, 0x02, 0x04, 0x02, 0x7F, 0x00 ; M
      008575 7F 04 08 10 7F 00       71 .byte 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 ; N
      00857B 3E 41 41 41 3E 00       72 .byte 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 ; O
      008581 7F 09 09 09 06 00       73 .byte 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 ; P
      008587 3E 41 51 61 7E 00       74 .byte 0x3E, 0x41, 0x51, 0x61, 0x7E, 0x00 ; Q
      00858D 7F 09 19 29 46 00       75 .byte 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 ; R
      008593 46 49 49 49 31 00       76 .byte 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 ; S
      008599 01 01 01 7F 01 01       77 .byte 0x01, 0x01, 0x01, 0x7F, 0x01, 0x01 ; T
      00859F 3F 40 40 40 3F 00       78 .byte 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 ; U
      0085A5 1F 20 40 20 1F 00       79 .byte 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 ; V
      0085AB 7F 20 18 20 7F 00       80 .byte 0x7F, 0x20, 0x18, 0x20, 0x7F, 0x00 ; W
      0085B1 63 14 08 14 63 00       81 .byte 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 ; X
      0085B7 07 08 70 08 07 00       82 .byte 0x07, 0x08, 0x70, 0x08, 0x07, 0x00 ; Y
      0085BD 71 49 45 43 41 00       83 .byte 0x71, 0x49, 0x45, 0x43, 0x41, 0x00 ; Z
      0085C3 00 7F 41 00 00 00       84 .byte 0x00, 0x7F, 0x41, 0x00, 0x00, 0x00 ; [
      0085C9 02 04 08 10 20 00       85 .byte 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 ; '\'
      0085CF 00 00 00 41 7F 00       86 .byte 0x00, 0x00, 0x00, 0x41, 0x7F, 0x00 ; ]
      0085D5 04 02 01 02 04 00       87 .byte 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 ; ^
      0085DB 80 80 80 80 80 80       88 .byte 0x80, 0x80, 0x80, 0x80, 0x80, 0x80 ; _
      0085E1 00 01 02 04 00 00       89 .byte 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 ; `
      0085E7 20 54 54 54 78 00       90 .byte 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 ; a
      0085ED 7F 50 48 48 30 00       91 .byte 0x7F, 0x50, 0x48, 0x48, 0x30, 0x00 ; b
      0085F3 38 44 44 44 20 00       92 .byte 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 ; c
      0085F9 30 48 48 50 7F 00       93 .byte 0x30, 0x48, 0x48, 0x50, 0x7F, 0x00 ; d
      0085FF 38 54 54 54 18 00       94 .byte 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 ; e
      008605 08 7E 09 01 02 00       95 .byte 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 ; f
      00860B 18 A4 A4 A4 7C 00       96 .byte 0x18, 0xA4, 0xA4, 0xA4, 0x7C, 0x00 ; g
      008611 7F 08 04 04 78 00       97 .byte 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 ; h
      008617 00 00 7A 00 00 00       98 .byte 0x00, 0x00, 0x7A, 0x00, 0x00, 0x00 ; i
      00861D 20 40 44 3D 00 00       99 .byte 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 ; j
      008623 7F 10 28 44 00 00      100 .byte 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00 ; k
      008629 00 41 7F 40 00 00      101 .byte 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 ; l
      00862F 7C 04 18 04 78 00      102 .byte 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 ; m
      008635 7C 08 04 04 78 00      103 .byte 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 ; n
      00863B 38 44 44 44 38 00      104 .byte 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 ; o
      008641 FC 24 24 24 18 00      105 .byte 0xFC, 0x24, 0x24, 0x24, 0x18, 0x00 ; p
      008647 38 44 24 F8 84 00      106 .byte 0x38, 0x44, 0x24, 0xF8, 0x84, 0x00 ; q
      00864D 7C 08 04 04 08 00      107 .byte 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 ; r
      008653 48 54 54 54 20 00      108 .byte 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 ; s
      008659 04 3F 44 40 20 00      109 .byte 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 ; t
      00865F 3C 40 40 20 7C 00      110 .byte 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 ; u
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



      008665 1C 20 40 20 1C 00      111 .byte 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 ; v
      00866B 3C 40 30 40 3C 00      112 .byte 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 ; w
      008671 44 28 10 28 44 00      113 .byte 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 ; x
      008677 1C A0 A0 A0 7C 00      114 .byte 0x1C, 0xA0, 0xA0, 0xA0, 0x7C, 0x00 ; y
      00867D 44 64 54 4C 44 00      115 .byte 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 ; z
      008683 08 36 41 00 00 00      116 .byte 0x08, 0x36, 0x41, 0x00, 0x00, 0x00 ; {
      008689 00 00 7F 00 00 00      117 .byte 0x00, 0x00, 0x7F, 0x00, 0x00, 0x00 ; |
      00868F 00 41 36 08 00 00      118 .byte 0x00, 0x41, 0x36, 0x08, 0x00, 0x00 ; }
      008695 08 04 08 10 08 00      119 .byte 0x08, 0x04, 0x08, 0x10, 0x08, 0x00 ; ~  ASCII 127 
      00869B FF FF FF FF FF FF      120 .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF ; 95 block cursor  128 
      0086A1 08 49 2A 1C 08 00      121 .byte 0x08, 0x49, 0x2A, 0x1C, 0x08, 0x00 ; 96 flèche droite 129 
      0086A7 08 1C 2A 49 08 00      122 .byte 0x08, 0x1C, 0x2A, 0x49, 0x08, 0x00 ; 97 flèche gauche 130
      0086AD 04 02 3F 02 04 00      123 .byte 0x04, 0x02, 0x3F, 0x02, 0x04, 0x00 ; 98 flèche haut   131
      0086B3 10 20 7E 20 10 00      124 .byte 0x10, 0x20, 0x7E, 0x20, 0x10, 0x00 ; 99 flèche bas    132
      0086B9 1C 3E 3E 3E 1C 00      125 .byte 0x1C, 0x3E, 0x3E, 0x3E, 0x1C, 0x00 ; 100 rond         133 
      0086BF 00 00 00 80 80 80      126 .byte 0x00, 0x00, 0x00, 0x80, 0x80, 0x80 ; 101 underline cursor 134
      0086C5 FF 00 00 00 00 00      127 .byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00 ; 102 insert cursor 135 
      0086CB                        128 oled_font_end:
                                    129 
                                    130 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
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
                                     26 ;--------------------------
                                     27 ; select display page 
                                     28 ; input:
                                     29 ;    A  page {0..7}
                                     30 ;--------------------------
      0086CB                         31 set_page:
      0086CB AB B0            [ 1]   32     add a,#0xB0 
      0086CD CD 83 4D         [ 4]   33     call oled_cmd 
      000650                         34     _send_cmd COL_WND 
      0086D0 A6 21            [ 1]    1     ld a,#COL_WND 
      0086D2 CD 83 4D         [ 4]    2     call oled_cmd 
      000655                         35     _send_cmd 0 
      0086D5 A6 00            [ 1]    1     ld a,#0 
      0086D7 CD 83 4D         [ 4]    2     call oled_cmd 
      00065A                         36     _send_cmd 127 
      0086DA A6 7F            [ 1]    1     ld a,#127 
      0086DC CD 83 4D         [ 4]    2     call oled_cmd 
      0086DF 81               [ 4]   37     ret 
                                     38 
                                     39 ;---------------------------
                                     40 ; set display start line 
                                     41 ;----------------------------
      0086E0                         42 scroll_up:
      0086E0 48               [ 1]   43     sll a 
      0086E1 48               [ 1]   44     sll a 
      0086E2 48               [ 1]   45     sll a 
      0086E3 88               [ 1]   46     push a 
      000664                         47     _send_cmd DISP_OFFSET
      0086E4 A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      0086E6 CD 83 4D         [ 4]    2     call oled_cmd 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



      0086E9 84               [ 1]   48     pop a  
      0086EA CC 83 4D         [ 2]   49     jp oled_cmd
                                     50 ;    ret 
                                     51 
                                     52 ;---------------------------
                                     53 ;  clear page 
                                     54 ;  expect disp_buffer cleared 
                                     55 ;  input:
                                     56 ;     A    page #
                                     57 ;---------------------------
      0086ED                         58 page_clear:
      0086ED CD 86 CB         [ 4]   59     call set_page 
      0086F0 72 5F 01 01      [ 1]   60     clr disp_buffer 
      0086F4 AE 00 80         [ 2]   61     ldw x,#DISPLAY_BUFFER_SIZE 
      0086F7 CC 83 67         [ 2]   62     jp oled_data
                                     63 
                                     64 ;----------------------
                                     65 ; zero's display buffer 
                                     66 ; input: 
                                     67 ;   none 
                                     68 ;----------------------
      0086FA                         69 clear_disp_buffer:
      0086FA 89               [ 2]   70     pushw x 
      0086FB 88               [ 1]   71     push a 
      0086FC AE 01 01         [ 2]   72     ldw x,#disp_buffer 
      0086FF A6 80            [ 1]   73     ld a,#DISPLAY_BUFFER_SIZE
      008701 7F               [ 1]   74 1$: clr(x)
      008702 5C               [ 1]   75     incw x 
      008703 4A               [ 1]   76     dec a 
      008704 26 FB            [ 1]   77     jrne 1$
      008706 84               [ 1]   78     pop a 
      008707 85               [ 2]   79     popw x 
      008708 81               [ 4]   80     ret 
                                     81 
                                     82 ;--------------------------
                                     83 ;  zero's SSD1306 RAM 
                                     84 ;--------------------------
      008709                         85 display_clear:
      008709 88               [ 1]   86     push a 
      00870A CD 86 FA         [ 4]   87     call clear_disp_buffer
      00870D 4B 07            [ 1]   88     push #7
      00870F 7B 01            [ 1]   89 2$: ld a,(1,sp)
      008711 CD 86 ED         [ 4]   90     call page_clear 
      008714 0A 01            [ 1]   91     dec (1,sp)
      008716 2A F7            [ 1]   92     jrpl 2$ 
      000698                         93     _drop 1 
      008718 5B 01            [ 2]    1     addw sp,#1 
      00871A 4F               [ 1]   94     clr a 
      00069B                         95     _straz cur_x
      00871B B7 1E                    1     .byte 0xb7,cur_x 
      00069D                         96     _straz cur_y
      00871D B7 1D                    1     .byte 0xb7,cur_y 
      00069F                         97     _straz start_page  
      00871F B7 1F                    1     .byte 0xb7,start_page 
      008721 CD 86 CB         [ 4]   98     call set_page
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



      008724 4F               [ 1]   99     clr a 
      008725 CD 86 E0         [ 4]  100     call scroll_up 
      008728 84               [ 1]  101     pop a 
      008729 81               [ 4]  102     ret 
                                    103 
                                    104 ;-----------------------
                                    105 ; send text cursor 
                                    106 ; at next line 
                                    107 ;------------------------
      00872A                        108 crlf:
      0006AA                        109     _clrz cur_x 
      00872A 3F 1E                    1     .byte 0x3f, cur_x 
      0006AC                        110     _ldaz cur_y
      00872C B6 1D                    1     .byte 0xb6,cur_y 
      00872E 4C               [ 1]  111     inc a 
      00872F A4 07            [ 1]  112     and a,#7 
      0006B1                        113     _straz cur_y 
      008731 B7 1D                    1     .byte 0xb7,cur_y 
      008733 CD 86 FA         [ 4]  114     call clear_disp_buffer 
      0006B6                        115     _ldaz cur_y 
      008736 B6 1D                    1     .byte 0xb6,cur_y 
      008738 CD 86 ED         [ 4]  116     call page_clear
      0006BB                        117     _ldaz cur_y 
      00873B B6 1D                    1     .byte 0xb6,cur_y 
      00873D CD 86 CB         [ 4]  118     call set_page
      0006C0                        119     _ldaz start_page 
      008740 B6 1F                    1     .byte 0xb6,start_page 
      008742 4C               [ 1]  120     inc a  
      008743 A1 08            [ 1]  121     cp a,#8
      008745 2B 07            [ 1]  122     jrmi 6$ 
      0006C7                        123     _ldaz cur_y
      008747 B6 1D                    1     .byte 0xb6,cur_y 
      008749 4C               [ 1]  124     inc a   
      00874A CD 86 E0         [ 4]  125     call scroll_up 
      00874D 81               [ 4]  126     ret 
      0006CE                        127 6$: _straz start_page  
      00874E B7 1F                    1     .byte 0xb7,start_page 
      008750 81               [ 4]  128     ret 
                                    129 
                                    130 ;-----------------------
                                    131 ; move cursor right 
                                    132 ; 1 character position
                                    133 ; scroll up if needed 
                                    134 ;-----------------------
      008751                        135 cursor_right:
      0006D1                        136     _ldaz cur_x 
      008751 B6 1E                    1     .byte 0xb6,cur_x 
      008753 AB 01            [ 1]  137     add a,#1  
      0006D5                        138     _straz cur_x 
      008755 B7 1E                    1     .byte 0xb7,cur_x 
      008757 A1 15            [ 1]  139     cp a,#21 
      008759 2B 03            [ 1]  140     jrmi 9$
      00875B CD 87 2A         [ 4]  141     call crlf 
      00875E 81               [ 4]  142 9$: ret 
                                    143 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



                                    144 ;----------------------------
                                    145 ; put char using rotated font 
                                    146 ; input:
                                    147 ;    A    character 
                                    148 ;-----------------------------
      00875F                        149 put_char:
      00875F 89               [ 2]  150     pushw x
      008760 90 89            [ 2]  151     pushw y 
      008762 A0 20            [ 1]  152 	sub a,#32
      008764 AE 00 06         [ 2]  153 	ldw x,#OLED_FONT_WIDTH
      008767 42               [ 4]  154 	mul x,a 
      008768 1C 84 61         [ 2]  155 	addw x,#oled_font_6x8
      00876B 90 93            [ 1]  156     ldw y,x 
      00876D AE 01 01         [ 2]  157     ldw x,#disp_buffer
      008770 4B 06            [ 1]  158     push #OLED_FONT_WIDTH
      008772                        159 1$:
      008772 90 F6            [ 1]  160     ld a,(y)
      008774 F7               [ 1]  161     ld (x),a 
      008775 5C               [ 1]  162     incw x 
      008776 90 5C            [ 1]  163     incw y 
      008778 0A 01            [ 1]  164     dec (1,sp)
      00877A 26 F6            [ 1]  165     jrne 1$ 
      0006FC                        166     _drop 1
      00877C 5B 01            [ 2]    1     addw sp,#1 
      00877E AE 00 06         [ 2]  167     ldw x,#OLED_FONT_WIDTH
      008781 CD 83 67         [ 4]  168     call oled_data 
      008784 CD 87 51         [ 4]  169     call cursor_right 
      008787 90 85            [ 2]  170     popw y
      008789 85               [ 2]  171     popw x 
      00878A 81               [ 4]  172     ret 
                                    173 
                                    174 
                                    175 ;----------------------
                                    176 ; put string in display 
                                    177 ; buffer 
                                    178 ; input:
                                    179 ;    y  .asciz  
                                    180 ;----------------------
      00878B                        181 put_string:
      00878B 90 F6            [ 1]  182 1$: ld a,(y)
      00878D 27 10            [ 1]  183     jreq 9$
      00878F A1 0A            [ 1]  184     cp a,#'\n'
      008791 26 05            [ 1]  185     jrne 2$
      008793 CD 87 2A         [ 4]  186     call crlf 
      008796 20 03            [ 2]  187     jra 4$
      008798                        188 2$:
      008798 CD 87 5F         [ 4]  189     call put_char 
      00879B                        190 4$:
      00879B 90 5C            [ 1]  191     incw y 
      00879D 20 EC            [ 2]  192     jra 1$
                                    193 
      00879F                        194 9$:  
      00879F 81               [ 4]  195     ret 
                                    196 
                                    197 ;-------------------
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



                                    198 ; put byte in hex 
                                    199 ; input:
                                    200 ;   A 
                                    201 ;------------------
      0087A0                        202 put_byte:
      0087A0 88               [ 1]  203     push a 
      0087A1 4E               [ 1]  204     swap a 
      0087A2 CD 87 A6         [ 4]  205     call put_hex 
      0087A5 84               [ 1]  206     pop a 
      0087A6                        207 put_hex:    
      0087A6 A4 0F            [ 1]  208     and a,#0xf 
      0087A8 AB 30            [ 1]  209     add a,#'0 
      0087AA A1 3A            [ 1]  210     cp a,#'9+1 
      0087AC 2B 02            [ 1]  211     jrmi 2$ 
      0087AE AB 07            [ 1]  212     add a,#7 
      0087B0 CD 87 5F         [ 4]  213 2$: call put_char 
      0087B3 81               [ 4]  214     ret 
                                    215 
                                    216 ;----------------------------
                                    217 ; put hexadecimal integer 
                                    218 ; in display 
                                    219 ; buffer 
                                    220 ; input:
                                    221 ;    X    integer to display 
                                    222 ;---------------------------
      0087B4                        223 put_hex_int:
      0087B4 9E               [ 1]  224     ld a,xh 
      0087B5 CD 87 A0         [ 4]  225     call put_byte 
      0087B8 9F               [ 1]  226     ld a,xl 
      0087B9 CD 87 A0         [ 4]  227     call put_byte 
      0087BC 81               [ 4]  228     ret 
                                    229 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
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
                           000000    19 .if DEBUG 
                                     20     .module STM8_MON 
                                     21 
                                     22 ;--------------------------------------
                                     23     .area DATA
                                     24 mode: .blkb 1 ; command mode 
                                     25 xamadr: .blkw 1 ; examine address 
                                     26 storadr: .blkw 1 ; store address 
                                     27 last: .blkw 1   ; last address parsed from input 
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
                                     40     NOP=0
                                     41     READ=1 ; single address or block
                                     42     STORE=2 
                                     43 
                                     44     ; get next character from input buffer 
                                     45     .macro _next_char 
                                     46     ld a,(y)
                                     47     incw y 
                                     48     .endm ; 4 bytes, 2 cy 
                                     49 
                                     50 cli: 
                                     51     ld a,#CR 
                                     52     call putchar 
                                     53     ld a,#'# 
                                     54     call putchar ; prompt character 
                                     55     call getline
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



                                     56 ; analyze input line      
                                     57     ldw y,#tib  
                                     58     _clrz mode 
                                     59 next_char:     
                                     60     _next_char
                                     61     tnz a     
                                     62     jrne parse01
                                     63 ; at end of line 
                                     64     tnz mode 
                                     65     jreq cli 
                                     66     call exam_block 
                                     67     jra cli 
                                     68 parse01:
                                     69     cp a,#'R 
                                     70     jrne 4$
                                     71     _ldxz xamadr   
                                     72     call (x) ; run program 
                                     73 4$: cp a,#':
                                     74     jrne 5$ 
                                     75     call modify 
                                     76     jra cli     
                                     77 5$:
                                     78     cp a,#'. 
                                     79     jrne 8$ 
                                     80     tnz mode 
                                     81     jreq cli ; here mode should be set to 1 
                                     82     jra next_char 
                                     83 8$: 
                                     84     cp a,#SPACE 
                                     85     jrmi next_char ; skip separator and invalids characters  
                                     86     call parse_hex ; maybe an hexadecimal number 
                                     87     tnz a ; unknown token ignore rest of line
                                     88     jreq cli 
                                     89     tnz mode 
                                     90     jreq 9$
                                     91     call exam_block
                                     92     jra next_char
                                     93 9$:
                                     94     _strxz xamadr 
                                     95     _strxz storadr
                                     96     _incz mode
                                     97     jra next_char 
                                     98 
                                     99 ;-------------------------------------
                                    100 ; modify RAM or peripheral register 
                                    101 ; read byte list from input buffer
                                    102 ;--------------------------------------
                                    103 modify:
                                    104 1$: 
                                    105 ; skip spaces 
                                    106     _next_char 
                                    107     cp a,#SPACE 
                                    108     jreq 1$ 
                                    109     call parse_hex
                                    110     tnz a 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



                                    111     jreq 9$ 
                                    112     ld a,xl 
                                    113     _ldxz storadr 
                                    114     ld (x),a 
                                    115     incw x 
                                    116     _strxz storadr
                                    117     jra 1$ 
                                    118 9$: _clrz mode 
                                    119     ret 
                                    120 
                                    121 ;-------------------------------------------
                                    122 ; display memory in range 'xamadr'...'last' 
                                    123 ;-------------------------------------------    
                                    124     ROW_SIZE=1
                                    125     VSIZE=1
                                    126 exam_block:
                                    127     _vars VSIZE
                                    128     _ldxz xamadr
                                    129 new_row: 
                                    130     ld a,#8
                                    131     ld (ROW_SIZE,sp),a ; bytes per row 
                                    132     ld a,#CR 
                                    133     call putchar 
                                    134     call print_adr ; display address and first byte of row 
                                    135     call print_mem ; display byte at address  
                                    136 row:
                                    137     incw x 
                                    138     cpw x,last 
                                    139     jrugt 9$ 
                                    140     dec (ROW_SIZE,sp)
                                    141     jreq new_row  
                                    142     call print_mem  
                                    143     jra row 
                                    144 9$:
                                    145     _clrz mode 
                                    146     _drop VSIZE 
                                    147     ret  
                                    148 
                                    149 ;----------------------------
                                    150 ; parse hexadecimal number 
                                    151 ; from input buffer 
                                    152 ; input:
                                    153 ;    A   first character 
                                    154 ;    Y   pointer to TIB 
                                    155 ; output: 
                                    156 ;    X     number 
                                    157 ;    Y     point after number 
                                    158 ;-----------------------------      
                                    159 parse_hex:
                                    160     push #0 ; digits count 
                                    161     clrw x
                                    162 1$:    
                                    163     xor a,#0x30
                                    164     cp a,#10 
                                    165     jrmi 2$   ; 0..9 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



                                    166     cp a,#0x71
                                    167     jrmi 9$
                                    168     sub a,#0x67  
                                    169 2$: push #4
                                    170     swap a 
                                    171 3$:
                                    172     sll a 
                                    173     rlcw x 
                                    174     dec (1,sp)
                                    175     jrne 3$
                                    176     pop a
                                    177     inc (1,sp) ; digits count  
                                    178     _next_char 
                                    179     tnz a 
                                    180     jrne 1$
                                    181 9$: ; end of hex number
                                    182     decw y  ; put back last character  
                                    183     pop a 
                                    184     tnz a 
                                    185     jreq 10$
                                    186     _strxz last 
                                    187 10$:
                                    188     ret 
                                    189 
                                    190 ;-----------------------------------
                                    191 ;  print address in xamadr variable
                                    192 ;  followed by ': '  
                                    193 ;  input: 
                                    194 ;    X     address to print 
                                    195 ;  output:
                                    196 ;   X      not modified 
                                    197 ;-------------------------------------
                                    198 print_adr: 
                                    199     callr print_word 
                                    200     ld a,#': 
                                    201     callr putchar 
                                    202     jra space
                                    203 
                                    204 ;-------------------------------------
                                    205 ;  print byte at memory location 
                                    206 ;  pointed by X followed by ' ' 
                                    207 ;  input:
                                    208 ;     X     memory address 
                                    209 ;  output:
                                    210 ;    X      not modified 
                                    211 ;-------------------------------------
                                    212 print_mem:
                                    213     ld a,(x) 
                                    214     call print_byte 
                                    215     
                                    216 
                                    217 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    218 ;;     TERMIO 
                                    219 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    220 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



                                    221 ;--------------------------------
                                    222 ; print blank space 
                                    223 ;-------------------------------
                                    224 space:
                                    225     ld a,#SPACE 
                                    226     callr putchar 
                                    227     ret 
                                    228 
                                    229 ;-------------------------------
                                    230 ;  print hexadecimal number 
                                    231 ; input:
                                    232 ;    X  number to print 
                                    233 ; output:
                                    234 ;    none 
                                    235 ;--------------------------------
                                    236 print_word: 
                                    237     ld a,xh
                                    238     call print_byte 
                                    239     ld a,xl 
                                    240     call print_byte 
                                    241     ret 
                                    242 
                                    243 ;---------------------
                                    244 ; print byte value 
                                    245 ; in hexadecimal 
                                    246 ; input:
                                    247 ;    A   value to print 
                                    248 ; output:
                                    249 ;    none 
                                    250 ;-----------------------
                                    251 print_byte:
                                    252     push a 
                                    253     swap a 
                                    254     call print_digit 
                                    255     pop a 
                                    256 
                                    257 ;-------------------------
                                    258 ; print lower nibble 
                                    259 ; as digit 
                                    260 ; input:
                                    261 ;    A     hex digit to print
                                    262 ; output:
                                    263 ;   none:
                                    264 ;---------------------------
                                    265 print_digit: 
                                    266     and a,#15 
                                    267     add a,#'0 
                                    268     cp a,#'9+1 
                                    269     jrmi 1$
                                    270     add a,#7 
                                    271 1$:
                                    272     call putchar 
                                    273 9$:
                                    274     ret 
                                    275 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



                                    276 
                                    277 ;---------------------------------
                                    278 ; Query for character in rx1_queue
                                    279 ; input:
                                    280 ;   none 
                                    281 ; output:
                                    282 ;   A     0 no charcter available
                                    283 ;   Z     1 no character available
                                    284 ;---------------------------------
                                    285 uart_qgetc:
                                    286 	_ldaz rx1_head 
                                    287 	sub a,rx1_tail 
                                    288 	ret 
                                    289 
                                    290 ;---------------------------------
                                    291 ; wait character from UART 
                                    292 ; input:
                                    293 ;   none
                                    294 ; output:
                                    295 ;   A 			char  
                                    296 ;--------------------------------	
                                    297 uart_getc::
                                    298 	call uart_qgetc
                                    299 	jreq uart_getc 
                                    300 	pushw x 
                                    301 	_clrz acc16 
                                    302     _movz acc8,rx1_head 
                                    303     ldw x,#rx1_queue
                                    304 	_ldaz rx1_head 
                                    305 	inc a 
                                    306 	and a,#RX_QUEUE_SIZE-1
                                    307 	_straz rx1_head 
                                    308 	ld a,([acc16],x)
                                    309 	cp a,#'a 
                                    310     jrmi 2$ 
                                    311     cp a,#'z+1 
                                    312     jrpl 2$
                                    313 	and a,#0xDF ; uppercase letter 
                                    314 2$:
                                    315 	popw x
                                    316 	ret 
                                    317 
                                    318 
                                    319 ;---------------------------------------
                                    320 ; send character to terminal 
                                    321 ; input:
                                    322 ;    A    character to send 
                                    323 ; output:
                                    324 ;    none 
                                    325 ;----------------------------------------    
                                    326 putchar:
                                    327     btjf UART_SR,#UART_SR_TXE,. 
                                    328     ld UART_DR,a 
                                    329     ret 
                                    330 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



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
                                    341 getline:
                                    342     ldw y,#tib 
                                    343 1$:
                                    344     clr (y) 
                                    345     callr uart_getc 
                                    346     cp a,#CR 
                                    347     jreq 9$ 
                                    348     cp a,#BS 
                                    349     jrne 2$
                                    350     callr delback 
                                    351     jra 1$ 
                                    352 2$: 
                                    353     cp a,#ESC 
                                    354     jrne 3$
                                    355     ldw y,#tib
                                    356     clr(y)
                                    357     ret 
                                    358 3$:    
                                    359     cp a,#SPACE 
                                    360     jrmi 1$  ; ignore others control char 
                                    361     callr putchar
                                    362     ld (y),a 
                                    363     incw y 
                                    364     jra 1$
                                    365 9$: callr putchar 
                                    366     ret 
                                    367 
                                    368 ;-----------------------------------
                                    369 ; delete character left of cursor 
                                    370 ; decrement Y 
                                    371 ; input:
                                    372 ;   none 
                                    373 ; output:
                                    374 ;   none 
                                    375 ;-----------------------------------
                                    376 delback:
                                    377     cpw y,#tib 
                                    378     jreq 9$     
                                    379     callr putchar ; backspace 
                                    380     ld a,#SPACE    
                                    381     callr putchar ; overwrite with space 
                                    382     ld a,#BS 
                                    383     callr putchar ;  backspace
                                    384     decw y
                                    385 9$:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



                                    386     ret 
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
                                    406 UartRxHandler: ; console receive char 
                                    407 	btjf UART_SR,#UART_SR_RXNE,5$ 
                                    408 	ld a,UART_DR 
                                    409 	cp a,#CTRL_C 
                                    410 	jrne 2$ 
                                    411 	ldw x,#cli  
                                    412 	clr (7,sp)
                                    413 	ldw (8,sp),x 
                                    414 	jra 5$
                                    415 2$:
                                    416 	cp a,#CAN ; CTRL_X 
                                    417 	jrne 3$
                                    418 	_swreset 	
                                    419 3$:	push a 
                                    420 	ld a,#rx1_queue 
                                    421 	add a,rx1_tail 
                                    422 	clrw x 
                                    423 	ld xl,a 
                                    424 	pop a 
                                    425 	ld (x),a 
                                    426 	ld a,rx1_tail 
                                    427 	inc a 
                                    428 	and a,#RX_QUEUE_SIZE-1
                                    429 	ld rx1_tail,a 
                                    430 5$:	iret 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



                                    441 uart_init:
                                    442 ; enable UART clock
                                    443 	bset CLK_PCKENR1,#UART_PCKEN 	
                                    444 	bres UART,#UART_CR1_PIEN
                                    445 ; baud rate 115200
                                    446 ; BRR value = 16Mhz/115200 ; 139 (0x8b) 
                                    447 	ld a,#0xb
                                    448 	ld UART_BRR2,a 
                                    449 	ld a,#0x8 
                                    450 	ld UART_BRR1,a 
                                    451 3$:
                                    452     clr UART_DR
                                    453 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
                                    454 	bset UART_CR2,#UART_CR2_SBK
                                    455     btjf UART_SR,#UART_SR_TC,.
                                    456     clr rx1_head 
                                    457 	clr rx1_tail
                                    458 	bset UART,#UART_CR1_PIEN
                                    459 	ret
                                    460 
                                    461 .endif ; DEBUG
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



                                      1 
                                      2 ; fake application 
                                      3 
      0087BD                          4 app:
      0087BD CD 81 31         [ 4]    5     call beep 
      0087C0 CD 82 B0         [ 4]    6     call oled_init 
      0087C3 CD 87 09         [ 4]    7     call display_clear 
      0087C6 90 AE 87 CF      [ 2]    8     ldw y,#hello 
      0087CA CD 87 8B         [ 4]    9     call put_string 
      0087CD 20 FE            [ 2]   10     jra .
                                     11 
      0087CF 48 45 4C 4C 4F 20 57    12 hello: .asciz "HELLO WORLD!"
             4F 52 4C 44 21 00
                                     13 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]

Symbol Table

    .__.$$$.=  002710 L   |     .__.ABS.=  000000 G   |     .__.CPU.=  000000 L
    .__.H$L.=  000001 L   |     ACK     =  000006     |     ADC_CR1 =  005401 
    ADC_CR1_=  000000     |     ADC_CR1_=  000001     |     ADC_CR1_=  000004 
    ADC_CR1_=  000005     |     ADC_CR1_=  000006     |     ADC_CR2 =  005402 
    ADC_CR2_=  000003     |     ADC_CR2_=  000004     |     ADC_CR2_=  000005 
    ADC_CR2_=  000006     |     ADC_CR2_=  000001     |     ADC_CR3 =  005403 
    ADC_CR3_=  000007     |     ADC_CR3_=  000006     |     ADC_CSR =  005400 
    ADC_CSR_=  000006     |     ADC_CSR_=  000004     |     ADC_CSR_=  000000 
    ADC_CSR_=  000001     |     ADC_CSR_=  000002     |     ADC_CSR_=  000003 
    ADC_CSR_=  000007     |     ADC_CSR_=  000005     |     ADC_DRH =  005404 
    ADC_DRL =  005405     |     ADC_TDRH=  005406     |     ADC_TDRL=  005407 
    ADR_MODE=  000020     |     AFR     =  004803     |     AFR0_ADC=  000000 
    AFR1_TIM=  000001     |     AFR2_CCO=  000002     |     AFR3_TIM=  000003 
    AFR4_TIM=  000004     |     AFR5_TIM=  000005     |     AFR6_I2C=  000006 
    AFR7_BEE=  000007     |     ALL_KEY_=  0000BE     |     AWU_APR =  0050F1 
    AWU_CSR =  0050F0     |     AWU_CSR_=  000004     |     AWU_TBR =  0050F2 
    B0_MASK =  000001     |     B115200 =  000006     |     B19200  =  000003 
    B1_MASK =  000002     |     B230400 =  000007     |     B2400   =  000000 
    B2_MASK =  000004     |     B38400  =  000004     |     B3_MASK =  000008 
    B460800 =  000008     |     B4800   =  000001     |     B4_MASK =  000010 
    B57600  =  000005     |     B5_MASK =  000020     |     B6_MASK =  000040 
    B7_MASK =  000080     |     B921600 =  000009     |     B9600   =  000002 
    BEEP_BIT=  000004     |     BEEP_CSR=  0050F3     |     BEEP_MAS=  000010 
    BEEP_POR=  00000F     |     BELL    =  000007     |     BIT0    =  000000 
    BIT1    =  000001     |     BIT2    =  000002     |     BIT3    =  000003 
    BIT4    =  000004     |     BIT5    =  000005     |     BIT6    =  000006 
    BIT7    =  000007     |     BLOCK_SI=  000080     |     BOOT_ROM=  006000 
    BOOT_ROM=  007FFF     |     BS      =  000008     |     BTN_A   =  000001 
    BTN_B   =  000002     |     BTN_DOWN=  000005     |     BTN_IDR =  00500B 
    BTN_LEFT=  000007     |     BTN_PORT=  00500A     |     BTN_RIGH=  000004 
    BTN_UP  =  000003     |     CAN     =  000018     |     CAN_DGR =  005426 
    CAN_FPSR=  005427     |     CAN_IER =  005425     |     CAN_MCR =  005420 
    CAN_MSR =  005421     |     CAN_P0  =  005428     |     CAN_P1  =  005429 
    CAN_P2  =  00542A     |     CAN_P3  =  00542B     |     CAN_P4  =  00542C 
    CAN_P5  =  00542D     |     CAN_P6  =  00542E     |     CAN_P7  =  00542F 
    CAN_P8  =  005430     |     CAN_P9  =  005431     |     CAN_PA  =  005432 
    CAN_PB  =  005433     |     CAN_PC  =  005434     |     CAN_PD  =  005435 
    CAN_PE  =  005436     |     CAN_PF  =  005437     |     CAN_RFR =  005424 
    CAN_TPR =  005423     |     CAN_TSR =  005422     |     CC_C    =  000000 
    CC_H    =  000004     |     CC_I0   =  000003     |     CC_I1   =  000005 
    CC_N    =  000002     |     CC_V    =  000007     |     CC_Z    =  000001 
    CFG_GCR =  007F60     |     CFG_GCR_=  000001     |     CFG_GCR_=  000000 
    CLKOPT  =  004807     |     CLKOPT_C=  000002     |     CLKOPT_E=  000003 
    CLKOPT_P=  000000     |     CLKOPT_P=  000001     |     CLK_CCOR=  0050C9 
    CLK_CKDI=  0050C6     |     CLK_CKDI=  000000     |     CLK_CKDI=  000001 
    CLK_CKDI=  000002     |     CLK_CKDI=  000003     |     CLK_CKDI=  000004 
    CLK_CMSR=  0050C3     |     CLK_CSSR=  0050C8     |     CLK_ECKR=  0050C1 
    CLK_ECKR=  000000     |     CLK_ECKR=  000001     |     CLK_FREQ=  000004 
    CLK_FREQ=  0000D5     |     CLK_HSIT=  0050CC     |     CLK_ICKR=  0050C0 
    CLK_ICKR=  000002     |     CLK_ICKR=  000000     |     CLK_ICKR=  000001 
    CLK_ICKR=  000003     |     CLK_ICKR=  000004     |     CLK_ICKR=  000005 
    CLK_PCKE=  0050C7     |     CLK_PCKE=  000000     |     CLK_PCKE=  000001 
    CLK_PCKE=  000007     |     CLK_PCKE=  000005     |     CLK_PCKE=  000006 
    CLK_PCKE=  000004     |     CLK_PCKE=  000002     |     CLK_PCKE=  000003 
    CLK_PCKE=  0050CA     |     CLK_PCKE=  000003     |     CLK_PCKE=  000002 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]

Symbol Table

    CLK_PCKE=  000007     |     CLK_SWCR=  0050C5     |     CLK_SWCR=  000000 
    CLK_SWCR=  000001     |     CLK_SWCR=  000002     |     CLK_SWCR=  000003 
    CLK_SWIM=  0050CD     |     CLK_SWR =  0050C4     |     CLK_SWR_=  0000B4 
    CLK_SWR_=  0000E1     |     CLK_SWR_=  0000D2     |     COLON   =  00003A 
    COL_WND =  000021     |     COMMA   =  00002C     |     COM_ALTE=  000010 
    COM_CFG =  0000DA     |     COM_DISA=  000000     |     COM_ENAB=  000020 
    COM_SEQU=  000000     |     CPU_A   =  007F00     |     CPU_CCR =  007F0A 
    CPU_PCE =  007F01     |     CPU_PCH =  007F02     |     CPU_PCL =  007F03 
    CPU_SPH =  007F08     |     CPU_SPL =  007F09     |     CPU_XH  =  007F04 
    CPU_XL  =  007F05     |     CPU_YH  =  007F06     |     CPU_YL  =  007F07 
    CP_OFF  =  000010     |     CP_ON   =  000014     |     CR      =  00000D 
    CTRL_A  =  000001     |     CTRL_B  =  000002     |     CTRL_C  =  000003 
    CTRL_D  =  000004     |     CTRL_E  =  000005     |     CTRL_F  =  000006 
    CTRL_G  =  000007     |     CTRL_H  =  000008     |     CTRL_I  =  000009 
    CTRL_J  =  00000A     |     CTRL_K  =  00000B     |     CTRL_L  =  00000C 
    CTRL_M  =  00000D     |     CTRL_N  =  00000E     |     CTRL_O  =  00000F 
    CTRL_P  =  000010     |     CTRL_Q  =  000011     |     CTRL_R  =  000012 
    CTRL_S  =  000013     |     CTRL_T  =  000014     |     CTRL_U  =  000015 
    CTRL_V  =  000016     |     CTRL_W  =  000017     |     CTRL_X  =  000018 
    CTRL_Y  =  000019     |     CTRL_Z  =  00001A     |     DC1     =  000011 
    DC2     =  000012     |     DC3     =  000013     |     DC4     =  000014 
    DEBUG   =  000000     |     DEBUG_BA=  007F00     |     DEBUG_EN=  007FFF 
    DEVID_BA=  0048CD     |     DEVID_EN=  0048D8     |     DEVID_LO=  0048D2 
    DEVID_LO=  0048D3     |     DEVID_LO=  0048D4     |     DEVID_LO=  0048D5 
    DEVID_LO=  0048D6     |     DEVID_LO=  0048D7     |     DEVID_LO=  0048D8 
    DEVID_WA=  0048D1     |     DEVID_XH=  0048CE     |     DEVID_XL=  0048CD 
    DEVID_YH=  0048D0     |     DEVID_YL=  0048CF     |     DISPLAY_=  000080 
    DISP_ALL=  0000A5     |     DISP_CHA=  00008D     |     DISP_CON=  000081 
    DISP_DIV=  000000     |     DISP_HEI=  000040     |     DISP_INV=  0000A7 
    DISP_NOR=  0000A6     |     DISP_OFF=  0000AE     |     DISP_OFF=  0000D3 
    DISP_ON =  0000AF     |     DISP_RAM=  0000A4     |     DISP_WID=  000080 
    DLE     =  000010     |     DM_BK1RE=  007F90     |     DM_BK1RH=  007F91 
    DM_BK1RL=  007F92     |     DM_BK2RE=  007F93     |     DM_BK2RH=  007F94 
    DM_BK2RL=  007F95     |     DM_CR1  =  007F96     |     DM_CR2  =  007F97 
    DM_CSR1 =  007F98     |     DM_CSR2 =  007F99     |     DM_ENFCT=  007F9A 
    EEPROM_B=  004000     |     EEPROM_E=  0043FF     |     EEPROM_S=  000400 
    EM      =  000019     |     ENQ     =  000005     |     EOF     =  00001A 
    EOT     =  000004     |     ESC     =  00001B     |     ETB     =  000017 
    ETX     =  000003     |     EXTI_CR1=  0050A0     |     EXTI_CR2=  0050A1 
    FF      =  00000C     |     FHSE    =  7A1200     |     FHSI    =  F42400 
    FLASH_BA=  008000     |     FLASH_CR=  00505A     |     FLASH_CR=  000002 
    FLASH_CR=  000000     |     FLASH_CR=  000003     |     FLASH_CR=  000001 
    FLASH_CR=  00505B     |     FLASH_CR=  000005     |     FLASH_CR=  000004 
    FLASH_CR=  000007     |     FLASH_CR=  000000     |     FLASH_CR=  000006 
    FLASH_DU=  005064     |     FLASH_DU=  0000AE     |     FLASH_DU=  000056 
    FLASH_EN=  017FFF     |     FLASH_FP=  00505D     |     FLASH_FP=  000000 
    FLASH_FP=  000001     |     FLASH_FP=  000002     |     FLASH_FP=  000003 
    FLASH_FP=  000004     |     FLASH_FP=  000005     |     FLASH_IA=  00505F 
    FLASH_IA=  000003     |     FLASH_IA=  000002     |     FLASH_IA=  000006 
    FLASH_IA=  000001     |     FLASH_IA=  000000     |     FLASH_NC=  00505C 
    FLASH_NF=  00505E     |     FLASH_NF=  000000     |     FLASH_NF=  000001 
    FLASH_NF=  000002     |     FLASH_NF=  000003     |     FLASH_NF=  000004 
    FLASH_NF=  000005     |     FLASH_PU=  005062     |     FLASH_PU=  000056 
    FLASH_PU=  0000AE     |     FLASH_SI=  010000     |     FLASH_WS=  00480D 
    FLSI    =  01F400     |     FMSTR   =  000010     |     FR_T2_CL=  00F424 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]

Symbol Table

    FS      =  00001C     |     F_DISP_M=  000005     |     F_GAME_T=  000007 
    F_SOUND_=  000006     |     GPIO_BAS=  005000     |     GPIO_CR1=  000003 
    GPIO_CR2=  000004     |     GPIO_DDR=  000002     |     GPIO_IDR=  000001 
    GPIO_ODR=  000000     |     GPIO_SIZ=  000005     |     GS      =  00001D 
    HORZ_MOD=  000000     |     HSECNT  =  004809     |     I2C_BASE=  005210 
    I2C_CCRH=  00521C     |     I2C_CCRH=  000080     |     I2C_CCRH=  0000C0 
    I2C_CCRH=  000080     |     I2C_CCRH=  000000     |     I2C_CCRH=  000001 
    I2C_CCRH=  000000     |     I2C_CCRH=  000006     |     I2C_CCRH=  000007 
    I2C_CCRL=  00521B     |     I2C_CCRL=  00001A     |     I2C_CCRL=  000002 
    I2C_CCRL=  00000D     |     I2C_CCRL=  000050     |     I2C_CCRL=  000090 
    I2C_CCRL=  0000A0     |     I2C_CR1 =  005210     |     I2C_CR1_=  000006 
    I2C_CR1_=  000007     |     I2C_CR1_=  000000     |     I2C_CR2 =  005211 
    I2C_CR2_=  000002     |     I2C_CR2_=  000003     |     I2C_CR2_=  000000 
    I2C_CR2_=  000001     |     I2C_CR2_=  000007     |     I2C_DR  =  005216 
    I2C_ERR_=  000003     |     I2C_ERR_=  000004     |     I2C_ERR_=  000000 
    I2C_ERR_=  000001     |     I2C_ERR_=  000002     |     I2C_ERR_=  000005 
    I2C_FAST=  000001     |     I2C_FREQ=  005212     |     I2C_ITR =  00521A 
    I2C_ITR_=  000002     |     I2C_ITR_=  000000     |     I2C_ITR_=  000001 
    I2C_OARH=  005214     |     I2C_OARH=  000001     |     I2C_OARH=  000002 
    I2C_OARH=  000006     |     I2C_OARH=  000007     |     I2C_OARL=  005213 
    I2C_OARL=  000000     |     I2C_OAR_=  000813     |     I2C_OAR_=  000009 
    I2C_PECR=  00521E     |     I2C_PORT=  000005     |     I2C_READ=  000001 
    I2C_SR1 =  005217     |     I2C_SR1_=  000003     |     I2C_SR1_=  000001 
    I2C_SR1_=  000002     |     I2C_SR1_=  000006     |     I2C_SR1_=  000000 
    I2C_SR1_=  000004     |     I2C_SR1_=  000007     |     I2C_SR2 =  005218 
    I2C_SR2_=  000002     |     I2C_SR2_=  000001     |     I2C_SR2_=  000000 
    I2C_SR2_=  000003     |     I2C_SR2_=  000005     |     I2C_SR3 =  005219 
    I2C_SR3_=  000001     |     I2C_SR3_=  000007     |     I2C_SR3_=  000004 
    I2C_SR3_=  000000     |     I2C_SR3_=  000002     |     I2C_STAT=  000007 
    I2C_STAT=  000006     |     I2C_STD =  000000     |     I2C_TRIS=  00521D 
    I2C_TRIS=  000005     |     I2C_TRIS=  000005     |     I2C_TRIS=  000005 
    I2C_TRIS=  000011     |     I2C_TRIS=  000011     |     I2C_TRIS=  000011 
    I2C_WRIT=  000000     |   7 I2cIntHa   0000DC R   |     INPUT_DI=  000000 
    INPUT_EI=  000001     |     INPUT_FL=  000000     |     INPUT_PU=  000001 
    INT_ADC2=  000016     |     INT_AUAR=  000012     |     INT_AWU =  000001 
    INT_CAN_=  000008     |     INT_CAN_=  000009     |     INT_CLK =  000002 
    INT_EXTI=  000003     |     INT_EXTI=  000004     |     INT_EXTI=  000005 
    INT_EXTI=  000006     |     INT_EXTI=  000007     |     INT_FLAS=  000018 
    INT_I2C =  000013     |     INT_SPI =  00000A     |     INT_TIM1=  00000C 
    INT_TIM1=  00000B     |     INT_TIM2=  00000E     |     INT_TIM2=  00000D 
    INT_TIM3=  000010     |     INT_TIM3=  00000F     |     INT_TIM4=  000017 
    INT_TLI =  000000     |     INT_UART=  000011     |     INT_UART=  000015 
    INT_UART=  000014     |     INT_VECT=  008060     |     INT_VECT=  00800C 
    INT_VECT=  008028     |     INT_VECT=  00802C     |     INT_VECT=  008010 
    INT_VECT=  008014     |     INT_VECT=  008018     |     INT_VECT=  00801C 
    INT_VECT=  008020     |     INT_VECT=  008024     |     INT_VECT=  008068 
    INT_VECT=  008054     |     INT_VECT=  008000     |     INT_VECT=  008030 
    INT_VECT=  008038     |     INT_VECT=  008034     |     INT_VECT=  008040 
    INT_VECT=  00803C     |     INT_VECT=  008048     |     INT_VECT=  008044 
    INT_VECT=  008064     |     INT_VECT=  008008     |     INT_VECT=  008004 
    INT_VECT=  008050     |     INT_VECT=  00804C     |     INT_VECT=  00805C 
    INT_VECT=  008058     |     ITC_SPR1=  007F70     |     ITC_SPR2=  007F71 
    ITC_SPR3=  007F72     |     ITC_SPR4=  007F73     |     ITC_SPR5=  007F74 
    ITC_SPR6=  007F75     |     ITC_SPR7=  007F76     |     ITC_SPR8=  007F77 
    ITC_SPR_=  000001     |     ITC_SPR_=  000000     |     ITC_SPR_=  000003 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]

Symbol Table

    IWDG_KEY=  000055     |     IWDG_KEY=  0000CC     |     IWDG_KEY=  0000AA 
    IWDG_KR =  0050E0     |     IWDG_PR =  0050E1     |     IWDG_RLR=  0050E2 
    LED_BIT =  000005     |     LED_MASK=  000020     |     LED_PORT=  00500A 
    LF      =  00000A     |     LF_HEIGH=  00000A     |     LF_WIDTH=  000008 
    MAJOR   =  000001     |     MAP_SEG0=  0000A0     |     MAP_SEG0=  0000A1 
    MINOR   =  000000     |     MUX_RATI=  0000A8     |     NAFR    =  004804 
    NAK     =  000015     |     NCLKOPT =  004808     |     NFLASH_W=  00480E 
    NHSECNT =  00480A     |     NOPT1   =  004802     |     NOPT2   =  004804 
    NOPT3   =  004806     |     NOPT4   =  004808     |     NOPT5   =  00480A 
    NOPT6   =  00480C     |     NOPT7   =  00480E     |     NOPTBL  =  00487F 
    NUBC    =  004802     |     NWDGOPT =  004806     |     NWDGOPT_=  FFFFFFFD 
    NWDGOPT_=  FFFFFFFC     |     NWDGOPT_=  FFFFFFFF     |     NWDGOPT_=  FFFFFFFE 
  7 NonHandl   000000 R   |     OFS_UART=  000002     |     OFS_UART=  000003 
    OFS_UART=  000004     |     OFS_UART=  000005     |     OFS_UART=  000006 
    OFS_UART=  000007     |     OFS_UART=  000008     |     OFS_UART=  000009 
    OFS_UART=  000001     |     OFS_UART=  000009     |     OFS_UART=  00000A 
    OFS_UART=  000000     |     OLED_CMD=  000080     |     OLED_DAT=  000040 
    OLED_DEV=  000078     |     OLED_FON=  000008     |     OLED_FON=  000006 
    OLED_NOP=  0000E3     |     OPT0    =  004800     |     OPT1    =  004801 
    OPT2    =  004803     |     OPT3    =  004805     |     OPT4    =  004807 
    OPT5    =  004809     |     OPT6    =  00480B     |     OPT7    =  00480D 
    OPTBL   =  00487E     |     OPTION_B=  004800     |     OPTION_E=  00487F 
    OPTION_S=  000080     |     OUTPUT_F=  000001     |     OUTPUT_O=  000000 
    OUTPUT_P=  000001     |     OUTPUT_S=  000000     |     PA      =  000000 
    PAGE_MOD=  000002     |     PAG_WND =  000022     |     PA_BASE =  005000 
    PA_CR1  =  005003     |     PA_CR2  =  005004     |     PA_DDR  =  005002 
    PA_IDR  =  005001     |     PA_ODR  =  005000     |     PB      =  000005 
    PB_BASE =  005005     |     PB_CR1  =  005008     |     PB_CR2  =  005009 
    PB_DDR  =  005007     |     PB_IDR  =  005006     |     PB_ODR  =  005005 
    PC      =  00000A     |     PC_BASE =  00500A     |     PC_CR1  =  00500D 
    PC_CR2  =  00500E     |     PC_DDR  =  00500C     |     PC_IDR  =  00500B 
    PC_ODR  =  00500A     |     PD      =  00000F     |     PD_BASE =  00500F 
    PD_CR1  =  005012     |     PD_CR2  =  005013     |     PD_DDR  =  005011 
    PD_IDR  =  005010     |     PD_ODR  =  00500F     |     PE      =  000014 
    PE_BASE =  005014     |     PE_CR1  =  005017     |     PE_CR2  =  005018 
    PE_DDR  =  005016     |     PE_IDR  =  005015     |     PE_ODR  =  005014 
    PF      =  000019     |     PF_BASE =  005019     |     PF_CR1  =  00501C 
    PF_CR2  =  00501D     |     PF_DDR  =  00501B     |     PF_IDR  =  00501A 
    PF_ODR  =  005019     |     PG      =  00001E     |     PG_BASE =  00501E 
    PG_CR1  =  005021     |     PG_CR2  =  005022     |     PG_DDR  =  005020 
    PG_IDR  =  00501F     |     PG_ODR  =  00501E     |     PH      =  000023 
    PHASE1_P=  000000     |     PHASE2_P=  000004     |     PH_BASE =  005023 
    PH_CR1  =  005026     |     PH_CR2  =  005027     |     PH_DDR  =  005025 
    PH_IDR  =  005024     |     PH_ODR  =  005023     |     PI      =  000028 
    PI_BASE =  005028     |     PI_CR1  =  00502B     |     PI_CR2  =  00502C 
    PI_DDR  =  00502A     |     PI_IDR  =  005029     |     PI_ODR  =  005028 
    PRE_CHAR=  0000D9     |     RAM_BASE=  000000     |     RAM_END =  0017FF 
    RAM_SIZE=  001800     |     REV     =  000000     |     ROP     =  004800 
    RS      =  00001E     |     RST_SR  =  0050B3     |     RX_QUEUE=  000010 
    SCAN_REV=  0000C8     |     SCAN_TOP=  0000C0     |     SCL_BIT =  000004 
    SCROLL_L=  000027     |     SCROLL_R=  000026     |     SCROLL_S=  00002F 
    SCROLL_S=  00002E     |     SCROLL_V=  00002A     |     SCROLL_V=  000029 
    SDA_BIT =  000005     |     SEMIC   =  00003B     |     SFR_BASE=  005000 
    SFR_END =  0057FF     |     SF_HEIGH=  000005     |     SF_WIDTH=  000004 
    SHARP   =  000023     |     SI      =  00000F     |     SO      =  00000E 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]

Symbol Table

    SOH     =  000001     |     SOUND_BI=  000004     |     SOUND_PO=  00500F 
    SPACE   =  000020     |     SPI_CR1 =  005200     |     SPI_CR1_=  000003 
    SPI_CR1_=  000000     |     SPI_CR1_=  000001     |     SPI_CR1_=  000007 
    SPI_CR1_=  000002     |     SPI_CR1_=  000006     |     SPI_CR2 =  005201 
    SPI_CR2_=  000007     |     SPI_CR2_=  000006     |     SPI_CR2_=  000005 
    SPI_CR2_=  000004     |     SPI_CR2_=  000002     |     SPI_CR2_=  000000 
    SPI_CR2_=  000001     |     SPI_CRCP=  005205     |     SPI_DR  =  005204 
    SPI_ICR =  005202     |     SPI_RXCR=  005206     |     SPI_SR  =  005203 
    SPI_SR_B=  000007     |     SPI_SR_C=  000004     |     SPI_SR_M=  000005 
    SPI_SR_O=  000006     |     SPI_SR_R=  000000     |     SPI_SR_T=  000001 
    SPI_SR_W=  000003     |     SPI_TXCR=  005207     |     STACK_EM=  0017FF 
    STACK_SI=  000080     |     START_LI=  000040     |     STX     =  000002 
    SUB     =  00001A     |     SWIM_CSR=  007F80     |     SYN     =  000016 
    TAB     =  000009     |     TIB_SIZE=  000028     |     TICK    =  000027 
    TIM1_ARR=  005262     |     TIM1_ARR=  005263     |     TIM1_BKR=  00526D 
    TIM1_CCE=  00525C     |     TIM1_CCE=  00525D     |     TIM1_CCM=  005258 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  005259 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  00525A 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCM=  00525B 
    TIM1_CCM=  000000     |     TIM1_CCM=  000001     |     TIM1_CCM=  000004 
    TIM1_CCM=  000005     |     TIM1_CCM=  000006     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000003     |     TIM1_CCM=  000007 
    TIM1_CCM=  000002     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000003     |     TIM1_CCR=  005265 
    TIM1_CCR=  005266     |     TIM1_CCR=  005267     |     TIM1_CCR=  005268 
    TIM1_CCR=  005269     |     TIM1_CCR=  00526A     |     TIM1_CCR=  00526B 
    TIM1_CCR=  00526C     |     TIM1_CNT=  00525E     |     TIM1_CNT=  00525F 
    TIM1_CR1=  005250     |     TIM1_CR2=  005251     |     TIM1_CR2=  000000 
    TIM1_CR2=  000002     |     TIM1_CR2=  000004     |     TIM1_CR2=  000005 
    TIM1_CR2=  000006     |     TIM1_DTR=  00526E     |     TIM1_EGR=  005257 
    TIM1_EGR=  000007     |     TIM1_EGR=  000001     |     TIM1_EGR=  000002 
    TIM1_EGR=  000003     |     TIM1_EGR=  000004     |     TIM1_EGR=  000005 
    TIM1_EGR=  000006     |     TIM1_EGR=  000000     |     TIM1_ETR=  005253 
    TIM1_ETR=  000006     |     TIM1_ETR=  000000     |     TIM1_ETR=  000001 
    TIM1_ETR=  000002     |     TIM1_ETR=  000003     |     TIM1_ETR=  000007 
    TIM1_ETR=  000004     |     TIM1_ETR=  000005     |     TIM1_IER=  005254 
    TIM1_IER=  000007     |     TIM1_IER=  000001     |     TIM1_IER=  000002 
    TIM1_IER=  000003     |     TIM1_IER=  000004     |     TIM1_IER=  000005 
    TIM1_IER=  000006     |     TIM1_IER=  000000     |     TIM1_OIS=  00526F 
    TIM1_PSC=  005260     |     TIM1_PSC=  005261     |     TIM1_RCR=  005264 
    TIM1_SMC=  005252     |     TIM1_SMC=  000007     |     TIM1_SMC=  000000 
    TIM1_SMC=  000001     |     TIM1_SMC=  000002     |     TIM1_SMC=  000004 
    TIM1_SMC=  000005     |     TIM1_SMC=  000006     |     TIM1_SR1=  005255 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_SR1=  000007     |     TIM1_SR1=  000001     |     TIM1_SR1=  000002 
    TIM1_SR1=  000003     |     TIM1_SR1=  000004     |     TIM1_SR1=  000005 
    TIM1_SR1=  000006     |     TIM1_SR1=  000000     |     TIM1_SR2=  005256 
    TIM1_SR2=  000001     |     TIM1_SR2=  000002     |     TIM1_SR2=  000003 
    TIM1_SR2=  000004     |     TIM2_ARR=  00530D     |     TIM2_ARR=  00530E 
    TIM2_CCE=  005308     |     TIM2_CCE=  000000     |     TIM2_CCE=  000001 
    TIM2_CCE=  000004     |     TIM2_CCE=  000005     |     TIM2_CCE=  005309 
    TIM2_CCM=  005305     |     TIM2_CCM=  005306     |     TIM2_CCM=  005307 
    TIM2_CCM=  000000     |     TIM2_CCM=  000004     |     TIM2_CCM=  000003 
    TIM2_CCR=  00530F     |     TIM2_CCR=  005310     |     TIM2_CCR=  005311 
    TIM2_CCR=  005312     |     TIM2_CCR=  005313     |     TIM2_CCR=  005314 
    TIM2_CLK=  00F424     |     TIM2_CNT=  00530A     |     TIM2_CNT=  00530B 
    TIM2_CR1=  005300     |     TIM2_CR1=  000007     |     TIM2_CR1=  000000 
    TIM2_CR1=  000003     |     TIM2_CR1=  000001     |     TIM2_CR1=  000002 
    TIM2_EGR=  005304     |     TIM2_EGR=  000001     |     TIM2_EGR=  000002 
    TIM2_EGR=  000003     |     TIM2_EGR=  000006     |     TIM2_EGR=  000000 
    TIM2_IER=  005301     |     TIM2_PSC=  00530C     |     TIM2_SR1=  005302 
    TIM2_SR2=  005303     |     TIM3_ARR=  00532B     |     TIM3_ARR=  00532C 
    TIM3_CCE=  005327     |     TIM3_CCE=  000000     |     TIM3_CCE=  000001 
    TIM3_CCE=  000004     |     TIM3_CCE=  000005     |     TIM3_CCE=  000000 
    TIM3_CCE=  000001     |     TIM3_CCM=  005325     |     TIM3_CCM=  005326 
    TIM3_CCM=  000000     |     TIM3_CCM=  000004     |     TIM3_CCM=  000003 
    TIM3_CCR=  00532D     |     TIM3_CCR=  00532E     |     TIM3_CCR=  00532F 
    TIM3_CCR=  005330     |     TIM3_CNT=  005328     |     TIM3_CNT=  005329 
    TIM3_CR1=  005320     |     TIM3_CR1=  000007     |     TIM3_CR1=  000000 
    TIM3_CR1=  000003     |     TIM3_CR1=  000001     |     TIM3_CR1=  000002 
    TIM3_EGR=  005324     |     TIM3_IER=  005321     |     TIM3_PSC=  00532A 
    TIM3_SR1=  005322     |     TIM3_SR2=  005323     |     TIM4_ARR=  005346 
    TIM4_CNT=  005344     |     TIM4_CR1=  005340     |     TIM4_CR1=  000007 
    TIM4_CR1=  000000     |     TIM4_CR1=  000003     |     TIM4_CR1=  000001 
    TIM4_CR1=  000002     |     TIM4_EGR=  005343     |     TIM4_EGR=  000000 
    TIM4_IER=  005341     |     TIM4_IER=  000000     |     TIM4_PSC=  005345 
    TIM4_PSC=  000000     |     TIM4_PSC=  000007     |     TIM4_PSC=  000004 
    TIM4_PSC=  000001     |     TIM4_PSC=  000005     |     TIM4_PSC=  000002 
    TIM4_PSC=  000006     |     TIM4_PSC=  000003     |     TIM4_PSC=  000000 
    TIM4_PSC=  000001     |     TIM4_PSC=  000002     |     TIM4_SR =  005342 
    TIM4_SR_=  000000     |     TIM_CR1_=  000007     |     TIM_CR1_=  000000 
    TIM_CR1_=  000006     |     TIM_CR1_=  000005     |     TIM_CR1_=  000004 
    TIM_CR1_=  000003     |     TIM_CR1_=  000001     |     TIM_CR1_=  000002 
  7 Timer4Up   000001 R   |     UART    =  000002     |     UART1   =  000000 
    UART1_BA=  005230     |     UART1_BR=  005232     |     UART1_BR=  005233 
    UART1_CR=  005234     |     UART1_CR=  005235     |     UART1_CR=  005236 
    UART1_CR=  005237     |     UART1_CR=  005238     |     UART1_DR=  005231 
    UART1_GT=  005239     |     UART1_PO=  000000     |     UART1_PS=  00523A 
    UART1_RX=  000004     |     UART1_SR=  005230     |     UART1_TX=  000005 
    UART2   =  000001     |     UART3   =  000002     |     UART3_BA=  005240 
    UART3_BR=  005242     |     UART3_BR=  005243     |     UART3_CR=  005244 
    UART3_CR=  005245     |     UART3_CR=  005246     |     UART3_CR=  005247 
    UART3_CR=  004249     |     UART3_DR=  005241     |     UART3_PO=  00000F 
    UART3_RX=  000006     |     UART3_SR=  005240     |     UART3_TX=  000005 
    UART_BRR=  005242     |     UART_BRR=  005243     |     UART_CR1=  005244 
    UART_CR1=  000004     |     UART_CR1=  000002     |     UART_CR1=  000000 
    UART_CR1=  000001     |     UART_CR1=  000007     |     UART_CR1=  000006 
    UART_CR1=  000005     |     UART_CR1=  000003     |     UART_CR2=  005245 
    UART_CR2=  000004     |     UART_CR2=  000002     |     UART_CR2=  000005 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]

Symbol Table

    UART_CR2=  000001     |     UART_CR2=  000000     |     UART_CR2=  000006 
    UART_CR2=  000003     |     UART_CR2=  000007     |     UART_CR3=  000003 
    UART_CR3=  000001     |     UART_CR3=  000002     |     UART_CR3=  000000 
    UART_CR3=  000006     |     UART_CR3=  000004     |     UART_CR3=  000005 
    UART_CR4=  000000     |     UART_CR4=  000001     |     UART_CR4=  000002 
    UART_CR4=  000003     |     UART_CR4=  000004     |     UART_CR4=  000006 
    UART_CR4=  000005     |     UART_CR5=  000003     |     UART_CR5=  000001 
    UART_CR5=  000002     |     UART_CR5=  000004     |     UART_CR5=  000005 
    UART_CR6=  000004     |     UART_CR6=  000007     |     UART_CR6=  000001 
    UART_CR6=  000002     |     UART_CR6=  000000     |     UART_CR6=  000005 
    UART_DR =  005241     |     UART_PCK=  000003     |     UART_POR=  005012 
    UART_POR=  005013     |     UART_POR=  005011     |     UART_POR=  005010 
    UART_POR=  00500F     |     UART_RX_=  000006     |     UART_SR =  005240 
    UART_SR_=  000001     |     UART_SR_=  000004     |     UART_SR_=  000002 
    UART_SR_=  000003     |     UART_SR_=  000000     |     UART_SR_=  000005 
    UART_SR_=  000006     |     UART_SR_=  000007     |     UART_TX_=  000005 
    UBC     =  004801     |     US      =  00001F     |     VCOMH_DS=  0000DB 
    VCOMH_DS=  000000     |     VCOMH_DS=  000020     |     VCOMH_DS=  000030 
    VERT_MOD=  000001     |     VERT_SCR=  0000A3     |     VT      =  00000B 
    WANT_TER=  000001     |     WDGOPT  =  004805     |     WDGOPT_I=  000002 
    WDGOPT_L=  000003     |     WDGOPT_W=  000000     |     WDGOPT_W=  000001 
    WWDG_CR =  0050D1     |     WWDG_WR =  0050D2     |     XOFF    =  000013 
    XON     =  000011     |   5 acc16      000010 GR  |   5 acc8       000011 GR
  7 all_disp   0002AE R   |   7 app        00073D R   |   7 beep       0000B1 R
  7 blink      0001A0 R   |   7 blink0     000198 R   |   7 blink1     00019D R
  7 clear_di   00067A R   |   7 clock_in   00002F R   |   6 co_code    000100 R
  7 cold_sta   0000BA R   |   7 crlf       0006AA R   |   5 cur_x      00001E R
  5 cur_y      00001D R   |   7 cursor_r   0006D1 R   |   5 delay_ti   00000A R
  6 disp_buf   000101 R   |   7 display_   000689 R   |   7 end_of_t   000149 R
  7 evt_addr   000122 R   |   7 evt_btf    00013D R   |   7 evt_rxne   000156 R
  7 evt_sb     00011C R   |   7 evt_stop   000171 R   |   7 evt_txe    000128 R
  7 evt_txe_   00012D R   |   7 fast       0001E9 R   |   5 flags      000014 GR
  7 font_hex   0002F1 R   |   7 font_hex   000341 R   |   6 free_ram   000181 R
  2 free_ram   00177E R   |   7 hello      00074F R   |   5 i2c_buf    000015 R
  5 i2c_coun   000017 R   |   5 i2c_devi   00001C R   |   7 i2c_erro   000185 R
  5 i2c_idx    000019 R   |   7 i2c_init   0001FA R   |   7 i2c_scl_   0001D3 R
  7 i2c_scl_   0001F5 R   |   7 i2c_star   000219 R   |   5 i2c_stat   00001B R
  7 i2c_writ   0001BB R   |   7 nibble_l   00018D R   |   7 oled_cmd   0002CD R
  7 oled_dat   0002E7 R   |   7 oled_fon   0003E1 R   |   7 oled_fon   00064B R
  7 oled_ini   000230 GR  |   7 oled_sen   0002DA R   |   7 page_cle   00066D R
  7 pause      000062 R   |   5 ptr16      000012 GR  |   5 ptr8       000013 R
  7 put_byte   000720 R   |   7 put_char   0006DF R   |   7 put_hex    000726 R
  7 put_hex_   000734 R   |   7 put_stri   00070B R   |   7 scroll_u   000660 R
  5 seedx      00000C R   |   5 seedy      00000E R   |   7 set_page   00064B R
  7 sound_pa   00006F R   |   5 sound_ti   00000B R   |   2 stack_fu   00177E R
  2 stack_un   0017FE R   |   5 start_pa   00001F R   |   7 std        0001DB R
  5 ticks      000008 R   |   7 timer2_i   00004D R   |   7 timer4_i   000034 R
  7 tone       000088 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size     80   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      0   flags    8
   5 DATA1      size     18   flags    8
   6 DATA2      size     81   flags    8
   7 CODE       size    75C   flags    0
