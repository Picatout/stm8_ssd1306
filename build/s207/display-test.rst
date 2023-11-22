ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 1.
Hexadecimal [24-Bits]



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
                                     93 ;-----------------------------
                                     94 ;   keypad macros 
                                     95 ;-----------------------------
                                     96 
                                     97     .macro _btn_down btn 
                                     98     ld a,BTN_IDR 
                                     99     and a,#(1<<btn)
                                    100     or a,#(1<<btn)
                                    101     .endm 
                                    102 
                                    103     .macro _btn_up 
                                    104     ld a,#BTN_IDR 
                                    105     and a,#(1<<btn)
                                    106     .endm 
                                    107 
                                    108     .macro _btn_state 
                                    109     ld a,#BTN_IDR 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 33.
Hexadecimal [24-Bits]



                                    110     and a,#ALL_KEY_UP
                                    111     .endm 
                                    112 
                                    113     .macro _wait_key_release  ?loop 
                                    114     loop:
                                    115     ld a,BTN_IDR 
                                    116     and a,#ALL_KEY_UP 
                                    117     cp a,#ALL_KEY_UP 
                                    118     jrne loop 
                                    119     .endm 
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
                           000400    35 DISPLAY_BUFFER_SIZE=128*8 ; col*page  
                                     36 
                                     37 ;;-----------------------------------
                                     38     .area SSEG (ABS)
                                     39 ;; working buffers and stack at end of RAM. 	
                                     40 ;;-----------------------------------
      00137E                         41     .org RAM_END - STACK_SIZE - DISPLAY_BUFFER_SIZE - 1
      00137E                         42 free_ram_end: 
      00137E                         43 oled_co: .blkb 1  ; OLED Co code sent before data bytes 
      00137F                         44 disp_buffer: .ds DISPLAY_BUFFER_SIZE ; data bytes sent to OLED 
      00177F                         45 stack_full: .ds STACK_SIZE   ; control stack 
      0017FF                         46 stack_unf: ; stack underflow ; control_stack bottom 
                                     47 
                                     48 ;;--------------------------------------
                                     49     .area HOME 
                                     50 ;; interrupt vector table at 0x8000
                                     51 ;;--------------------------------------
                                     52 
      008000 82 00 81 A5             53 	int cold_start	        ; reset
      008004 82 00 80 80             54 	int NonHandledInterrupt	; trap
      008008 82 00 80 80             55 	int NonHandledInterrupt	; irq0
      00800C 82 00 80 80             56 	int NonHandledInterrupt	; irq1
      008010 82 00 80 80             57 	int NonHandledInterrupt	; irq2
      008014 82 00 80 80             58 	int NonHandledInterrupt	; irq3
      008018 82 00 80 80             59 	int NonHandledInterrupt	; irq4
      00801C 82 00 80 80             60 	int NonHandledInterrupt	; irq5
      008020 82 00 80 80             61 	int NonHandledInterrupt	; irq6
      008024 82 00 80 80             62 	int NonHandledInterrupt	; irq7
      008028 82 00 80 80             63 	int NonHandledInterrupt	; irq8
      00802C 82 00 80 80             64 	int NonHandledInterrupt	; irq9
      008030 82 00 80 80             65 	int NonHandledInterrupt	; irq10
      008034 82 00 80 80             66 	int NonHandledInterrupt	; irq11
      008038 82 00 80 80             67 	int NonHandledInterrupt	; irq12
      00803C 82 00 80 80             68 	int NonHandledInterrupt	; irq13
      008040 82 00 80 80             69 	int NonHandledInterrupt	; irq14
      008044 82 00 80 80             70 	int NonHandledInterrupt	; irq15
      008048 82 00 80 80             71 	int NonHandledInterrupt	; irq16
      00804C 82 00 80 80             72 	int NonHandledInterrupt	; irq17
      008050 82 00 80 80             73 	int NonHandledInterrupt	; irq18
      008054 82 00 81 DE             74 	int I2cIntHandler  		; irq19
      008058 82 00 80 80             75 	int NonHandledInterrupt	; irq20
                           000001    76 .if WANT_TERMINAL
      00805C 82 00 8A 89             77 	int UartRxHandler   	; irq21
                           000000    78 .else 
                                     79 	int NonHandledInterrupt	; irq21
                                     80 .endif	
      008060 82 00 80 80             81 	int NonHandledInterrupt	; irq22
      008064 82 00 80 81             82 	int Timer4UpdateHandler ; irq23
      008068 82 00 80 80             83 	int NonHandledInterrupt	; irq24
      00806C 82 00 80 80             84 	int NonHandledInterrupt	; irq25
      008070 82 00 80 80             85 	int NonHandledInterrupt	; irq26
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 36.
Hexadecimal [24-Bits]



      008074 82 00 80 80             86 	int NonHandledInterrupt	; irq27
      008078 82 00 80 80             87 	int NonHandledInterrupt	; irq28
      00807C 82 00 80 80             88 	int NonHandledInterrupt	; irq29
                                     89 
                                     90 
                                     91 ;--------------------------------------
                                     92     .area DATA (ABS)
      000008                         93 	.org 8 
                                     94 ;--------------------------------------	
                                     95 
      000008                         96 ticks: .blkw 1 ; 1.664 milliseconds ticks counter (see Timer4UpdateHandler)
      00000A                         97 delay_timer: .blkb 1 ; 60 hertz timer   
      00000B                         98 sound_timer: .blkb 1 ; 60 hertz timer  
      00000C                         99 seedx: .blkw 1  ; xorshift 16 seed x  used by RND() function 
      00000E                        100 seedy: .blkw 1  ; xorshift 16 seed y  used by RND() funcion
      000010                        101 acc16:: .blkb 1 ; 16 bits accumulator, acc24 high-byte
      000011                        102 acc8::  .blkb 1 ;  8 bits accumulator, acc24 low-byte  
      000012                        103 ptr16::  .blkb 1 ; 16 bits pointer , farptr high-byte 
      000013                        104 ptr8:   .blkb 1 ; 8 bits pointer, farptr low-byte  
      000014                        105 flags:: .blkb 1 ; various boolean flags
                                    106 ; i2c peripheral 
      000015                        107 i2c_buf: .blkw 1 ; i2c buffer address 
      000017                        108 i2c_count: .blkw 1 ; bytes to transmit 
      000019                        109 i2c_idx: .blkw 1 ; index in buffer
      00001B                        110 i2c_status: .blkb 1 ; error status 
      00001C                        111 i2c_devid: .blkb 1 ; device identifier  
                                    112 ;OLED display 
      00001D                        113 cur_y: .blkb 1 ; text cursor x coord  
      00001E                        114 cur_x: .blkb 1 ;  text cursor y coord  
                                    115 
                                    116 
                           000001   117 .if WANT_TERMINAL
                                    118 ; usart queue 
      00001F                        119 rx1_queue: .ds RX_QUEUE_SIZE ; UART1 receive circular queue 
      00002F                        120 rx1_head:  .blkb 1 ; rx1_queue head pointer
      000030                        121 rx1_tail:   .blkb 1 ; rx1_queue tail pointer  
                                    122 ; transaction input buffer 
      000031                        123 tib: .ds TIB_SIZE
      000059                        124 count: .blkb 1 ; character count in tib  
                                    125 .endif 
                                    126 
      000100                        127 	.org 0x100
      000100                        128 cmd_buffer: .ds 129 ; oled display page buffer 
                                    129 
      000181                        130 free_ram: ; from here RAM free up to free_ram_end 
                                    131 
                                    132 
                                    133 
                                    134 
                                    135 
                                    136 
                                    137 	.area CODE 
                                    138 
                                    139 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    140 ; non handled interrupt 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 37.
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
      008081 72 5F 53 42      [ 1]  152 	clr TIM4_SR 
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 38.
Hexadecimal [24-Bits]



      0080B8 72 11 53 40      [ 1]  194 	bres TIM4_CR1,#TIM4_CR1_CEN 
      0080BC 35 07 53 45      [ 1]  195 	mov TIM4_PSCR,#7 ; Fmstr/128=125000 hertz  
      0080C0 35 83 53 46      [ 1]  196 	mov TIM4_ARR,#(256-125) ; 125000/125=1 msec 
      0080C4 35 05 53 40      [ 1]  197 	mov TIM4_CR1,#((1<<TIM4_CR1_CEN)|(1<<TIM4_CR1_URS))
      0080C8 72 10 53 41      [ 1]  198 	bset TIM4_IER,#TIM4_IER_UIE
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
      0080D1 35 60 53 05      [ 1]  216  	mov TIM2_CCMR1,#(6<<TIM2_CCMR_OCM) ; PWM mode 1 
      0080D5 35 08 53 0C      [ 1]  217 	mov TIM2_PSCR,#8 ; Ft2clk=fmstr/256=62500 hertz 
      0080D9 72 10 53 00      [ 1]  218 	bset TIM2_CR1,#TIM2_CR1_CEN
      0080DD 72 11 53 08      [ 1]  219 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      0080E1 81               [ 4]  220 	ret 
                                    221 
                                    222 
                                    223 ;--------------------------
                                    224 ; set software interrupt 
                                    225 ; priority 
                                    226 ; input:
                                    227 ;   A    priority 1,2,3 
                                    228 ;   X    vector 
                                    229 ;---------------------------
                           000001   230 	SPR_ADDR=1 
                           000003   231 	PRIORITY=3
                           000004   232 	SLOT=4
                           000005   233 	MASKED=5  
                           000005   234 	VSIZE=5
      0080E2                        235 set_int_priority::
      000062                        236 	_vars VSIZE
      0080E2 52 05            [ 2]    1     sub sp,#VSIZE 
      0080E4 A4 03            [ 1]  237 	and a,#3  
      0080E6 6B 03            [ 1]  238 	ld (PRIORITY,sp),a 
      0080E8 A6 04            [ 1]  239 	ld a,#4 
      0080EA 62               [ 2]  240 	div x,a 
      0080EB 48               [ 1]  241 	sll a  ; slot*2 
      0080EC 6B 04            [ 1]  242 	ld (SLOT,sp),a
      0080EE 1C 7F 70         [ 2]  243 	addw x,#ITC_SPR1 
      0080F1 1F 01            [ 2]  244 	ldw (SPR_ADDR,sp),x 
                                    245 ; build mask
      0080F3 AE FF FC         [ 2]  246 	ldw x,#0xfffc 	
      0080F6 7B 04            [ 1]  247 	ld a,(SLOT,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 39.
Hexadecimal [24-Bits]



      0080F8 27 05            [ 1]  248 	jreq 2$ 
      0080FA 99               [ 1]  249 	scf 
      0080FB 59               [ 2]  250 1$:	rlcw x 
      0080FC 4A               [ 1]  251 	dec a 
      0080FD 26 FC            [ 1]  252 	jrne 1$
      0080FF 9F               [ 1]  253 2$:	ld a,xl 
                                    254 ; apply mask to slot 
      008100 1E 01            [ 2]  255 	ldw x,(SPR_ADDR,sp)
      008102 F4               [ 1]  256 	and a,(x)
      008103 6B 05            [ 1]  257 	ld (MASKED,sp),a 
                                    258 ; shift priority to slot 
      008105 7B 03            [ 1]  259 	ld a,(PRIORITY,sp)
      008107 97               [ 1]  260 	ld xl,a 
      008108 7B 04            [ 1]  261 	ld a,(SLOT,sp)
      00810A 27 04            [ 1]  262 	jreq 4$
      00810C 58               [ 2]  263 3$:	sllw x 
      00810D 4A               [ 1]  264 	dec a 
      00810E 26 FC            [ 1]  265 	jrne 3$
      008110 9F               [ 1]  266 4$:	ld a,xl 
      008111 1A 05            [ 1]  267 	or a,(MASKED,sp)
      008113 1E 01            [ 2]  268 	ldw x,(SPR_ADDR,sp)
      008115 F7               [ 1]  269 	ld (x),a 
      000096                        270 	_drop VSIZE 
      008116 5B 05            [ 2]    1     addw sp,#VSIZE 
      008118 81               [ 4]  271 	ret 
                                    272 
                                    273 ;---------------------------------
                                    274 ; Pseudo Random Number Generator 
                                    275 ; XORShift algorithm.
                                    276 ;---------------------------------
                                    277 
                                    278 ;---------------------------------
                                    279 ;  seedx:seedy= x:y ^ seedx:seedy
                                    280 ; output:
                                    281 ;  X:Y   seedx:seedy new value   
                                    282 ;---------------------------------
      008119                        283 xor_seed32:
      008119 9E               [ 1]  284     ld a,xh 
      00009A                        285     _xorz seedx 
      00811A B8 0C                    1     .byte 0xb8,seedx 
      00009C                        286     _straz seedx
      00811C B7 0C                    1     .byte 0xb7,seedx 
      00811E 9F               [ 1]  287     ld a,xl 
      00009F                        288     _xorz seedx+1 
      00811F B8 0D                    1     .byte 0xb8,seedx+1 
      0000A1                        289     _straz seedx+1 
      008121 B7 0D                    1     .byte 0xb7,seedx+1 
      008123 90 9E            [ 1]  290     ld a,yh 
      0000A5                        291     _xorz seedy
      008125 B8 0E                    1     .byte 0xb8,seedy 
      0000A7                        292     _straz seedy 
      008127 B7 0E                    1     .byte 0xb7,seedy 
      008129 90 9F            [ 1]  293     ld a,yl 
      0000AB                        294     _xorz seedy+1 
      00812B B8 0F                    1     .byte 0xb8,seedy+1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 40.
Hexadecimal [24-Bits]



      0000AD                        295     _straz seedy+1 
      00812D B7 0F                    1     .byte 0xb7,seedy+1 
      0000AF                        296     _ldxz seedx  
      00812F BE 0C                    1     .byte 0xbe,seedx 
      0000B1                        297     _ldyz seedy 
      008131 90 BE 0E                 1     .byte 0x90,0xbe,seedy 
      008134 81               [ 4]  298     ret 
                                    299 
                                    300 ;-----------------------------------
                                    301 ;   x:y= x:y << a 
                                    302 ;  input:
                                    303 ;    A     shift count 
                                    304 ;    X:Y   uint32 value 
                                    305 ;  output:
                                    306 ;    X:Y   uint32 shifted value   
                                    307 ;-----------------------------------
      008135                        308 sll_xy_32: 
      008135 90 58            [ 2]  309     sllw y 
      008137 59               [ 2]  310     rlcw x
      008138 4A               [ 1]  311     dec a 
      008139 26 FA            [ 1]  312     jrne sll_xy_32 
      00813B 81               [ 4]  313     ret 
                                    314 
                                    315 ;-----------------------------------
                                    316 ;   x:y= x:y >> a 
                                    317 ;  input:
                                    318 ;    A     shift count 
                                    319 ;    X:Y   uint32 value 
                                    320 ;  output:
                                    321 ;    X:Y   uint32 shifted value   
                                    322 ;-----------------------------------
      00813C                        323 srl_xy_32: 
      00813C 54               [ 2]  324     srlw x 
      00813D 90 56            [ 2]  325     rrcw y 
      00813F 4A               [ 1]  326     dec a 
      008140 26 FA            [ 1]  327     jrne srl_xy_32 
      008142 81               [ 4]  328     ret 
                                    329 
                                    330 ;-------------------------------------
                                    331 ;  PRNG generator proper 
                                    332 ; input:
                                    333 ;   none 
                                    334 ; ouput:
                                    335 ;   X     bits 31...16  PRNG seed  
                                    336 ;  use: 
                                    337 ;   seedx:seedy   system variables   
                                    338 ;--------------------------------------
      008143                        339 prng::
      008143 90 89            [ 2]  340 	pushw y   
      0000C5                        341     _ldxz seedx
      008145 BE 0C                    1     .byte 0xbe,seedx 
      0000C7                        342 	_ldyz seedy  
      008147 90 BE 0E                 1     .byte 0x90,0xbe,seedy 
      00814A A6 0D            [ 1]  343 	ld a,#13
      00814C CD 81 35         [ 4]  344     call sll_xy_32 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 41.
Hexadecimal [24-Bits]



      00814F CD 81 19         [ 4]  345     call xor_seed32
      008152 A6 11            [ 1]  346     ld a,#17 
      008154 CD 81 3C         [ 4]  347     call srl_xy_32
      008157 CD 81 19         [ 4]  348     call xor_seed32 
      00815A A6 05            [ 1]  349     ld a,#5 
      00815C CD 81 35         [ 4]  350     call sll_xy_32
      00815F CD 81 19         [ 4]  351     call xor_seed32
      008162 90 85            [ 2]  352     popw y 
      008164 81               [ 4]  353     ret 
                                    354 
                                    355 
                                    356 ;---------------------------------
                                    357 ; initialize seedx:seedy 
                                    358 ; input:
                                    359 ;    X    0 -> seedx=ticks, seedy=tib[0..1] 
                                    360 ;    X    !0 -> seedx=X, seedy=[0x60<<8|XL]
                                    361 ;-------------------------------------------
      008165                        362 set_seed:
      008165 5D               [ 2]  363     tnzw x 
      008166 26 0B            [ 1]  364     jrne 1$ 
      008168 CE 00 08         [ 2]  365     ldw x,ticks 
      0000EB                        366     _strxz seedx
      00816B BF 0C                    1     .byte 0xbf,seedx 
      00816D CE 13 7F         [ 2]  367     ldw x,disp_buffer  
      0000F0                        368     _strxz seedy  
      008170 BF 0E                    1     .byte 0xbf,seedy 
      008172 81               [ 4]  369     ret 
      008173                        370 1$:  
      0000F3                        371     _strxz seedx
      008173 BF 0C                    1     .byte 0xbf,seedx 
      0000F5                        372     _clrz seedy 
      008175 3F 0E                    1     .byte 0x3f, seedy 
      0000F7                        373     _clrz seedy+1
      008177 3F 0F                    1     .byte 0x3f, seedy+1 
      008179 81               [ 4]  374     ret 
                                    375 
                                    376 ;----------------------------
                                    377 ;  read keypad 
                                    378 ; output:
                                    379 ;    A    keypress|0
                                    380 ;----------------------------
      00817A                        381 key:
      00817A C6 50 0B         [ 1]  382 	ld a,BTN_IDR 
      00817D A4 BE            [ 1]  383 	and a,#ALL_KEY_UP
      00817F 81               [ 4]  384     ret 
                                    385 
                                    386 ;----------------------------
                                    387 ; wait for key press 
                                    388 ; output:
                                    389 ;    A    key 
                                    390 ;----------------------------
                           000001   391 	KPAD=1
      008180                        392 wait_key:
      008180 4B BE            [ 1]  393 	push #ALL_KEY_UP 
      008182                        394 1$:	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 42.
Hexadecimal [24-Bits]



      008182 C6 50 0B         [ 1]  395 	ld a,BTN_IDR 
      008185 A4 BE            [ 1]  396 	and a,#ALL_KEY_UP 
      008187 A1 BE            [ 1]  397 	cp a,#ALL_KEY_UP
      008189 27 F7            [ 1]  398 	jreq 1$
      00818B 6B 01            [ 1]  399 	ld (KPAD,sp),a  
                                    400 ; debounce
      00818D 35 02 00 0A      [ 1]  401 	mov delay_timer,#2
      008191 72 1E 00 14      [ 1]  402 	bset flags,#F_GAME_TMR
      008195 C6 50 0B         [ 1]  403 2$: ld a,BTN_IDR 
      008198 A4 BE            [ 1]  404 	and a,#ALL_KEY_UP 
      00819A 11 01            [ 1]  405 	cp a,(KPAD,sp)
      00819C 26 E4            [ 1]  406 	jrne 1$
      00819E 72 0E 00 14 F2   [ 2]  407 	btjt flags,#F_GAME_TMR,2$ 
      0081A3 84               [ 1]  408 	pop a  
      0081A4 81               [ 4]  409 	ret 
                                    410 
                                    411 
                                    412 ;-------------------------------------
                                    413 ;  initialization entry point 
                                    414 ;-------------------------------------
      0081A5                        415 cold_start:
                                    416 ;set stack 
      0081A5 AE 17 FF         [ 2]  417 	ldw x,#STACK_EMPTY
      0081A8 94               [ 1]  418 	ldw sp,x
                                    419 ; clear all ram 
      0081A9 7F               [ 1]  420 0$: clr (x)
      0081AA 5A               [ 2]  421 	decw x 
      0081AB 26 FC            [ 1]  422 	jrne 0$
      0081AD CD 80 AF         [ 4]  423     call clock_init 
                                    424 ; set pull up on PC_IDR (buttons input)
      0081B0 72 5F 50 0C      [ 1]  425 	cLr BTN_PORT+GPIO_DDR
      0081B4 35 FF 50 0D      [ 1]  426 	mov BTN_PORT+GPIO_CR1,#255
                                    427 ; set sound output 	
      0081B8 72 18 50 11      [ 1]  428 	bset SOUND_PORT+GPIO_DDR,#SOUND_BIT 
      0081BC 72 18 50 12      [ 1]  429 	bset SOUND_PORT+GPIO_CR1,#SOUND_BIT 
      0081C0 CD 8A BA         [ 4]  430 	call uart_init 
      0081C3 CD 80 B4         [ 4]  431 	call timer4_init ; msec ticks timer 
      0081C6 CD 80 CD         [ 4]  432 	call timer2_init ; tone generator 
      0081C9 A6 01            [ 1]  433 	ld a,#I2C_FAST   
      0081CB CD 82 FC         [ 4]  434 	call i2c_init 
      0081CE 9A               [ 1]  435 	rim ; enable interrupts
                                    436 ; RND function seed 
                                    437 ; must be initialized 
                                    438 ; to value other than 0.
                                    439 ; take values from FLASH space 
      0081CF AE 81 DE         [ 2]  440 	ldw x,#I2cIntHandler
      0081D2 CF 00 0E         [ 2]  441 	ldw seedy,x  
      0081D5 AE 8C 1D         [ 2]  442 	ldw x,#main 
      0081D8 CF 00 0C         [ 2]  443 	ldw seedx,x  
      0081DB CC 8C 1D         [ 2]  444     jp main 	
                                    445 
                                    446 
                                    447 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 43.
Hexadecimal [24-Bits]



                                      1 ;;
                                      2 ; Copyright Jacques Deschênes 2019,2022  
                                      3 ; This file is part of stm8_tbi 
                                      4 ;
                                      5 ;     stm8_tbi is free software: you can redistribute it and/or modify
                                      6 ;     it under the terms of the GNU General Public License as published by
                                      7 ;     the Free Software Foundation, either version 3 of the License, or
                                      8 ;     (at your option) any later version.
                                      9 ;
                                     10 ;     stm8_tbi is distributed in the hope that it will be useful,
                                     11 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     12 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     13 ;     GNU General Public License for more details.
                                     14 ;
                                     15 ;     You should have received a copy of the GNU General Public License
                                     16 ;     along with stm8_tbi.  If not, see <http://www.gnu.org/licenses/>.
                                     17 ;;
                                     18 
                           000000    19 SEPARATE=0
                                     20 
                           000000    21 .if SEPARATE 
                                     22     .module I2C   
                                     23     .include "config.inc"
                                     24 
                                     25     .area CODE 
                                     26 .endif 
                                     27 
                                     28 ;-------------------------------------
                                     29 ;    I2C macros 
                                     30 ;-------------------------------------
                                     31     .macro _i2c_stop 
                                     32     bset I2C_CR2,#I2C_CR2_STOP
                                     33     .endm 
                                     34 
                                     35 ;--------------------------------
                                     36 ;  I2C peripheral driver 
                                     37 ;  Support only 7 bit addressing 
                                     38 ;  and master mode 
                                     39 ;--------------------------------
                                     40 
                           000007    41 I2C_STATUS_DONE=7 ; bit 7 of i2c_status indicate operation completed  
                           000006    42 I2C_STATUS_NO_STOP=6 ; don't send a stop at end of transmission
                                     43 
                                     44 
                                     45 ;------------------------------
                                     46 ; i2c global interrupt handler
                                     47 ;------------------------------
      0081DE                         48 I2cIntHandler:
      0081DE C6 52 18         [ 1]   49     ld a, I2C_SR2 ; errors status 
      0081E1 72 5F 52 18      [ 1]   50     clr I2C_SR2 
      0081E5 A4 0F            [ 1]   51     and a,#15 
      0081E7 27 0A            [ 1]   52     jreq 1$
      0081E9 CA 00 1B         [ 1]   53     or a,i2c_status 
      00016C                         54     _straz i2c_status 
      0081EC B7 1B                    1     .byte 0xb7,i2c_status 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 44.
Hexadecimal [24-Bits]



      0081EE 72 12 52 11      [ 1]   55     bset I2C_CR2,#I2C_CR2_STOP
      0081F2 80               [11]   56     iret 
      0081F3                         57 1$: ; no error detected 
      0081F3 72 0F 00 1B 05   [ 2]   58     btjf i2c_status,#I2C_STATUS_DONE,2$
      0081F8 72 5F 52 1A      [ 1]   59     clr I2C_ITR 
      0081FC 80               [11]   60     iret 
                                     61 ; handle events 
      00017D                         62 2$: _ldxz i2c_idx  
      0081FD BE 19                    1     .byte 0xbe,i2c_idx 
      0081FF 72 00 52 17 1A   [ 2]   63     btjt I2C_SR1,#I2C_SR1_SB,evt_sb 
      008204 72 02 52 17 1B   [ 2]   64     btjt I2C_SR1,#I2C_SR1_ADDR,evt_addr 
      008209 72 04 52 17 31   [ 2]   65     btjt I2C_SR1,#I2C_SR1_BTF,evt_btf  
      00820E 72 0E 52 17 17   [ 2]   66     btjt I2C_SR1,#I2C_SR1_TXE,evt_txe 
      008213 72 0C 52 17 40   [ 2]   67     btjt I2C_SR1,#I2C_SR1_RXNE,evt_rxne 
      008218 72 08 52 17 56   [ 2]   68     btjt I2C_SR1,#I2C_SR1_STOPF,evt_stopf 
      00821D 80               [11]   69     iret 
                                     70 
      00821E                         71 evt_sb: ; EV5  start bit sent 
      00019E                         72     _ldaz i2c_devid
      00821E B6 1C                    1     .byte 0xb6,i2c_devid 
      008220 C7 52 16         [ 1]   73     ld I2C_DR,a ; send device address 
      008223 80               [11]   74     iret 
                                     75 
      008224                         76 evt_addr: ; EV6  address sent, send data bytes  
      008224 72 04 52 19 01   [ 2]   77     btjt I2C_SR3,#I2C_SR3_TRA,evt_txe
      008229 80               [11]   78     iret 
                                     79 
                                     80 ; master transmit mode 
      00822A                         81 evt_txe: ; EV8  send data byte 
      0001AA                         82     _ldyz i2c_count 
      00822A 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      00822D 27 1C            [ 1]   83     jreq end_of_tx 
      00822F                         84 evt_txe_1:
      00822F 72 D6 00 15      [ 4]   85     ld a,([i2c_buf],x)
      008233 C7 52 16         [ 1]   86     ld I2C_DR,a
      008236 5C               [ 1]   87     incw x 
      0001B7                         88     _strxz i2c_idx 
      008237 BF 19                    1     .byte 0xbf,i2c_idx 
      008239 90 5A            [ 2]   89     decw y  
      0001BB                         90     _stryz i2c_count  
      00823B 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      00823E 80               [11]   91 1$: iret 
                                     92 
                                     93 ; only append if no STOP send 
      00823F                         94 evt_btf: 
      00823F 72 05 52 19 14   [ 2]   95     btjf I2C_SR3,#I2C_SR3_TRA,#evt_rxne  
      0001C4                         96     _ldyz i2c_count 
      008244 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      008247 26 E6            [ 1]   97     jrne evt_txe_1 
      008249 20 00            [ 2]   98     jra end_of_tx 
                                     99 
                                    100 ; end of transmission
      00824B                        101 end_of_tx:
      00824B 72 1E 00 1B      [ 1]  102     bset i2c_status,#I2C_STATUS_DONE  
                                    103 ;    btjt i2c_status,#I2C_STATUS_NO_STOP,1$
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 45.
Hexadecimal [24-Bits]



      00824F 72 12 52 11      [ 1]  104     bset I2C_CR2,#I2C_CR2_STOP
      008253 72 5F 52 1A      [ 1]  105 1$: clr I2C_ITR
      008257 80               [11]  106     iret 
                                    107 
                                    108 ; master receive mode 
      008258                        109 evt_rxne: 
      0001D8                        110     _ldyz i2c_count 
      008258 90 BE 17                 1     .byte 0x90,0xbe,i2c_count 
      00825B 27 16            [ 1]  111     jreq evt_stopf  
      00825D C6 52 16         [ 1]  112 1$: ld a,I2C_DR 
      008260 72 D7 00 15      [ 4]  113     ld ([i2c_buf],x),a  
      008264 5C               [ 1]  114     incw x 
      0001E5                        115     _strxz i2c_idx 
      008265 BF 19                    1     .byte 0xbf,i2c_idx 
      008267 90 5A            [ 2]  116     decw y 
      0001E9                        117     _stryz i2c_count
      008269 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      00826C 26 04            [ 1]  118     jrne 4$
      00826E 72 15 52 11      [ 1]  119     bres I2C_CR2,#I2C_CR2_ACK
      008272 80               [11]  120 4$: iret 
                                    121 
      008273                        122 evt_stopf:
      008273 C6 52 16         [ 1]  123     ld a,I2C_DR 
      008276 72 D7 00 15      [ 4]  124     ld ([i2c_buf],x),a 
      00827A 72 12 52 11      [ 1]  125     bset I2C_CR2,#I2C_CR2_STOP
      00827E 72 1E 00 1B      [ 1]  126     bset i2c_status,#I2C_STATUS_DONE
      008282 72 5F 52 1A      [ 1]  127     clr I2C_ITR 
      008286 80               [11]  128     iret  
                                    129 
                                    130 ; error message 
                           000000   131 I2C_ERR_NONE=0 
                           000001   132 I2C_ERR_NO_ACK=1 ; no ack received 
                           000002   133 I2C_ERR_OVR=2 ; overrun 
                           000003   134 I2C_ERR_ARLO=3 ; arbitration lost 
                           000004   135 I2C_ERR_BERR=4 ; bus error 
                           000005   136 I2C_ERR_TIMEOUT=5 ; operation time out 
                                    137 ;---------------------------
                                    138 ; display error message 
                                    139 ; blink error code on LED
                                    140 ; in binary format 
                                    141 ; most significant bit first 
                                    142 ; 0 -> 100msec blink
                                    143 ; 1 -> 300msec blink 
                                    144 ; space -> 100msec LED off 
                                    145 ; inter code -> 500msec LED off
                                    146 ;---------------------------
      008287                        147 i2c_error:
      000207                        148     _ldaz i2c_status 
      008287 B6 1B                    1     .byte 0xb6,i2c_status 
      008289 4E               [ 1]  149     swap a 
      00828A C7 00 11         [ 1]  150     ld acc8,a 
      00828D 4B 04            [ 1]  151     push #4 
      00828F                        152 nibble_loop:     
      00828F A6 0C            [ 1]  153     ld a,#12 
      008291 CD 8B 86         [ 4]  154     call beep 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 46.
Hexadecimal [24-Bits]



      008294 72 58 00 11      [ 1]  155     sll acc8  
      008298 25 05            [ 1]  156     jrc blink1 
      00829A                        157 blink0:
      00829A AE 00 C8         [ 2]  158     ldw x,#200
      00829D 20 03            [ 2]  159     jra blink
      00829F                        160 blink1: 
      00829F AE 02 58         [ 2]  161     ldw x,#600 
      0082A2                        162 blink:
      0082A2 CD 8B 37         [ 4]  163     call pause 
      0082A5 4F               [ 1]  164     clr a 
      0082A6 CD 8B 86         [ 4]  165     call beep  
      0082A9 AE 00 C8         [ 2]  166     ldw x,#200 
      0082AC CD 8B 37         [ 4]  167     call pause 
      0082AF 0A 01            [ 1]  168     dec (1,sp)
      0082B1 26 DC            [ 1]  169     jrne nibble_loop 
      0082B3 84               [ 1]  170     pop a 
      0082B4 AE 02 BC         [ 2]  171     ldw x,#700 
      0082B7 CD 8B 37         [ 4]  172     call pause 
      0082BA 20 CB            [ 2]  173 jra i2c_error     
      0082BC 81               [ 4]  174     ret  
                                    175 
                           000000   176 .if 0
                                    177 ;----------------------------
                                    178 ; set_i2c_params(devid,count,buf_addr,no_stop)
                                    179 ; set i2c operation parameters  
                                    180 ; 
                                    181 ; devid: BYTE 
                                    182 ;     7 bit device identifier 
                                    183 ;
                                    184 ; count: BYTE 
                                    185 ;     bytes to send|receive
                                    186 ;
                                    187 ; buf_addr: WORD 
                                    188 ;     pointer to buffer 
                                    189 ;  
                                    190 ; no_stop:  BYTE 
                                    191 ;     0   set STOP bit at end 
                                    192 ;     1   don't set STOP bit 
                                    193 ;---------------------------
                                    194     ARGCOUNT=4 
                                    195 i2c_set_params: ; (stop_cond buf_addr count devid -- )
                                    196     clr i2c_status  
                                    197 1$: _get_arg 0 ; no_stop 
                                    198     jreq 2$
                                    199     bset i2c_status,#I2C_STATUS_NO_STOP
                                    200 2$: _get_arg 1 ; buf_addr 
                                    201     ldw i2c_buf,x 
                                    202     _get_arg 2 ; count 
                                    203     _strxz i2c_count 
                                    204     _get_arg 3 ; devid 
                                    205     ld a,xl 
                                    206     _straz i2c_devid 
                                    207     ret 
                                    208 .endif 
                                    209 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 47.
Hexadecimal [24-Bits]



                                    210 ;--------------------------------
                                    211 ; write bytes to i2c device 
                                    212 ; devid:  device identifier 
                                    213 ; count: of bytes to write 
                                    214 ; buf_addr: address of bytes buffer 
                                    215 ; no_stop: dont't send a stop
                                    216 ;---------------------------------
      0082BD                        217 i2c_write:
      0082BD 72 00 52 19 FB   [ 2]  218     btjt I2C_SR3,#I2C_SR3_MSL,.
      0082C2 5F               [ 1]  219     clrw x 
      000243                        220     _strxz i2c_idx 
      0082C3 BF 19                    1     .byte 0xbf,i2c_idx 
      0082C5 A6 07            [ 1]  221     ld a,#(1<<I2C_ITR_ITBUFEN)|(1<<I2C_ITR_ITERREN)|(1<<I2C_ITR_ITEVTEN) 
      0082C7 C7 52 1A         [ 1]  222     ld I2C_ITR,a 
      0082CA A6 05            [ 1]  223     ld a,#(1<<I2C_CR2_START)|(1<<I2C_CR2_ACK)
      0082CC C7 52 11         [ 1]  224     ld I2C_CR2,a      
      0082CF 72 0F 00 1B FB   [ 2]  225 1$: btjf i2c_status,#I2C_STATUS_DONE,1$ 
      0082D4 81               [ 4]  226     ret 
                                    227 
                                    228 ;-------------------------------
                                    229 ; set I2C SCL frequency
                                    230 ; parameter:
                                    231 ;    A    {I2C_STD,I2C_FAST}
                                    232 ;-------------------------------
      0082D5                        233 i2c_scl_freq:
      0082D5 72 11 52 10      [ 1]  234 	bres I2C_CR1,#I2C_CR1_PE 
      0082D9 A1 00            [ 1]  235 	cp a,#I2C_STD 
      0082DB 26 0E            [ 1]  236 	jrne fast
      0082DD                        237 std:
      0082DD 35 00 52 1C      [ 1]  238 	mov I2C_CCRH,#I2C_CCRH_16MHZ_STD_100 
      0082E1 35 50 52 1B      [ 1]  239 	mov I2C_CCRL,#I2C_CCRL_16MHZ_STD_100
      0082E5 35 11 52 1D      [ 1]  240 	mov I2C_TRISER,#I2C_TRISER_16MHZ_STD_100
      0082E9 20 0C            [ 2]  241 	jra i2c_scl_freq_exit 
      0082EB                        242 fast:
      0082EB 35 80 52 1C      [ 1]  243 	mov I2C_CCRH,#I2C_CCRH_16MHZ_FAST_400 
      0082EF 35 0D 52 1B      [ 1]  244 	mov I2C_CCRL,#I2C_CCRL_16MHZ_FAST_400
      0082F3 35 05 52 1D      [ 1]  245 	mov I2C_TRISER,#I2C_TRISER_16MHZ_FAST_400
      0082F7                        246 i2c_scl_freq_exit:
      0082F7 72 10 52 10      [ 1]  247 	bset I2C_CR1,#I2C_CR1_PE 
      0082FB 81               [ 4]  248 	ret 
                                    249 
                                    250 ;-------------------------------
                                    251 ; initialize I2C peripheral 
                                    252 ; parameter:
                                    253 ;    A    {I2C_STD,I2C_FAST}
                                    254 ;-------------------------------
      0082FC                        255 i2c_init:
                                    256 ; set SDA and SCL pins as OD output 
      0082FC 72 1B 00 08      [ 1]  257 	bres I2C_PORT+GPIO_CR1,#SDA_BIT
      008300 72 19 00 08      [ 1]  258 	bres I2C_PORT+GPIO_CR1,#SCL_BIT 
                                    259 ; set I2C peripheral 
      008304 72 10 50 C7      [ 1]  260 	bset CLK_PCKENR1,#CLK_PCKENR1_I2C 
      008308 72 5F 52 10      [ 1]  261 	clr I2C_CR1 
      00830C 72 5F 52 11      [ 1]  262 	clr I2C_CR2 
      008310 35 10 52 12      [ 1]  263     mov I2C_FREQR,#FMSTR ; peripheral clock frequency 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 48.
Hexadecimal [24-Bits]



      008314 AD BF            [ 4]  264 	callr i2c_scl_freq
      008316 72 10 52 10      [ 1]  265 	bset I2C_CR1,#I2C_CR1_PE ; enable peripheral 
      00831A 81               [ 4]  266 	ret 
                                    267 
                                    268 
                                    269 ;-----------------------------
                                    270 ; send start bit and device id 
                                    271 ; paramenter:
                                    272 ;     A      device_id, 
                                    273 ; 			 b0=1 -> transmit
                                    274 ;			 b0=0 -> receive 
                                    275 ;----------------------------- 
      00831B                        276 i2c_start:
      00831B 72 02 52 19 FB   [ 2]  277     btjt I2C_SR3,#I2C_SR3_BUSY,.
      008320 72 10 52 11      [ 1]  278 	bset I2C_CR2,#I2C_CR2_START 
      008324 72 01 52 17 FB   [ 2]  279 	btjf I2C_SR1,#I2C_SR1_SB,. 
      008329 C7 52 16         [ 1]  280 	ld I2C_DR,a 
      00832C 72 03 52 17 FB   [ 2]  281 	btjf I2C_SR1,#I2C_SR1_ADDR,. 
      008331 81               [ 4]  282 	ret 
                                    283 
                                    284 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 49.
Hexadecimal [24-Bits]



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
                                     18 
                                     19 ;------------------------------
                                     20 ; SSD1306 OLED display 128x64
                                     21 ;------------------------------
                                     22 
                           000040    23 DISP_HEIGHT=64 ; pixels 
                           000080    24 DISP_WIDTH=128 ; pixels 
                                     25 
                                     26 ;-------------------------------
                                     27 ;  SSD1306 commands set 
                                     28 ;-------------------------------
                                     29 ; display on/off commands 
                           0000AE    30 DISP_OFF=0XAE      ; turn off display 
                           0000AF    31 DISP_ON=0XAF       ; turn on display 
                           000081    32 DISP_CONTRAST=0X81 ; adjust contrast 0..127
                           0000A4    33 DISP_RAM=0XA4     ; diplay RAM bits 
                           0000A5    34 DISP_ALL_ON=0XA5  ; all pixel on 
                           0000A6    35 DISP_NORMAL=0XA6  ; normal display, i.e. bit set oled light 
                           0000A7    36 DISP_INVERSE=0XA7 ; inverted display 
                           00008D    37 DISP_CHARGE_PUMP=0X8D ; enable charge pump 
                                     38 ; scrolling commands 
                           000026    39 SCROLL_RIGHT=0X26  ; scroll pages range right 
                           000027    40 SCROLL_LEFT=0X27   ; scroll pages range left 
                           000029    41 SCROLL_VRIGHT=0X29 ; scroll vertical and right  
                           00002A    42 SCROLL_VLEFT=0X2A ; scroll vertical and left 
                           00002E    43 SCROLL_STOP=0X2E   ; stop scrolling 
                           00002F    44 SCROLL_START=0X2F  ; start scrolling 
                           0000A3    45 VERT_SCROLL_AREA=0XA3  ; set vertical scrolling area 
                                     46 ; addressing setting commands 
                                     47 ; 0x00-0x0f set lower nibble for column start address, page mode  
                                     48 ; 0x10-0x1f set high nibble for column start address, page mode 
                           000020    49 ADR_MODE=0X20 ; 0-> horz mode, 1-> vert mode, 2->page mode 
                           000021    50 COL_WND=0X21 ; set column window for horz and vert mode 
                           000022    51 PAG_WND=0X22 ; set page window for horz and vert mode 
                                     52 ; 0xb0-0xb7 set start page for page mode 
                           000040    53 START_LINE=0X40 ; 0x40-0x7f set display start line 
                           0000A0    54 MAP_SEG0_COL0=0XA0 ; map segment 0 to column 0 
                           0000A1    55 MAP_SEG0_COL128=0XA1 ; inverse mapping segment 0 to col 127   
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 50.
Hexadecimal [24-Bits]



                           0000A8    56 MUX_RATIO=0XA8 ; reset to 64 
                           0000C0    57 SCAN_TOP_DOWN=0XC0 ; scan from COM0 to COM63 
                           0000C8    58 SCAN_REVERSE=0XC8 ; scan from COM63 to COM0 
                           0000D3    59 DISP_OFFSET=0XD3 ; display offset to COMx 
                           0000DA    60 COM_CFG=0XDA ; set COM pins hardware configuration 
                                     61 ;Timing & Driving Scheme Setting Command Table
                           0000D5    62 CLK_FREQ_DIV=0xD5 ; clock frequency and divisor 
                           0000D9    63 PRE_CHARGE=0xD9 ; set pre-charge period 
                           0000DB    64 VCOM_DESEL=0XDB ; set Vcomh deselect level 
                           0000E3    65 OLED_NOP=0xE3 
                                     66 
                                     67 ; switch charge pump on/off 
                           000010    68 CP_OFF=0x10 
                           000014    69 CP_ON=0x14 
                                     70 
                                     71 
                           000080    72 OLED_CMD=0x80 
                           000040    73 OLED_DATA=0x40 
                                     74 
                                     75 
                                     76 ;----------------------------
                                     77 ; initialize OLED display
                                     78 ;----------------------------
      008332                         79 oled_init:: 
                                     80 ; multiplex ratio to default 64 
      0002B2                         81     _send_cmd MUX_RATIO 
      008332 A6 A8            [ 1]    1     ld a,#MUX_RATIO 
      008334 CD 83 CF         [ 4]    2     call oled_cmd 
      0002B7                         82     _send_cmd 63
      008337 A6 3F            [ 1]    1     ld a,#63 
      008339 CD 83 CF         [ 4]    2     call oled_cmd 
                                     83 ; no display offset 
      0002BC                         84     _send_cmd DISP_OFFSET 
      00833C A6 D3            [ 1]    1     ld a,#DISP_OFFSET 
      00833E CD 83 CF         [ 4]    2     call oled_cmd 
      0002C1                         85     _send_cmd 0 
      008341 A6 00            [ 1]    1     ld a,#0 
      008343 CD 83 CF         [ 4]    2     call oled_cmd 
                                     86 ; no segment remap SEG0 -> COM0 
      0002C6                         87     _send_cmd MAP_SEG0_COL0   
      008346 A6 A0            [ 1]    1     ld a,#MAP_SEG0_COL0 
      008348 CD 83 CF         [ 4]    2     call oled_cmd 
                                     88 ; COMMON scan direction top to bottom 
      0002CB                         89     _send_cmd SCAN_TOP_DOWN
      00834B A6 C0            [ 1]    1     ld a,#SCAN_TOP_DOWN 
      00834D CD 83 CF         [ 4]    2     call oled_cmd 
                                     90 ; common pins config, bit 5=0, 4=1 
      0002D0                         91     _send_cmd COM_CFG 
      008350 A6 DA            [ 1]    1     ld a,#COM_CFG 
      008352 CD 83 CF         [ 4]    2     call oled_cmd 
      0002D5                         92     _send_cmd 0x12
      008355 A6 12            [ 1]    1     ld a,#0x12 
      008357 CD 83 CF         [ 4]    2     call oled_cmd 
                                     93 ; constrast level 0x7f half-way 
      0002DA                         94     _send_cmd DISP_CONTRAST
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 51.
Hexadecimal [24-Bits]



      00835A A6 81            [ 1]    1     ld a,#DISP_CONTRAST 
      00835C CD 83 CF         [ 4]    2     call oled_cmd 
      0002DF                         95     _send_cmd 0x1 
      00835F A6 01            [ 1]    1     ld a,#0x1 
      008361 CD 83 CF         [ 4]    2     call oled_cmd 
                                     96 ; display RAM 
      0002E4                         97     _send_cmd DISP_RAM
      008364 A6 A4            [ 1]    1     ld a,#DISP_RAM 
      008366 CD 83 CF         [ 4]    2     call oled_cmd 
                                     98 ; display normal 
      0002E9                         99     _send_cmd DISP_NORMAL
      008369 A6 A6            [ 1]    1     ld a,#DISP_NORMAL 
      00836B CD 83 CF         [ 4]    2     call oled_cmd 
                                    100 ; clock frequency=std and display divisor=1 
      0002EE                        101     _send_cmd CLK_FREQ_DIV
      00836E A6 D5            [ 1]    1     ld a,#CLK_FREQ_DIV 
      008370 CD 83 CF         [ 4]    2     call oled_cmd 
      0002F3                        102     _send_cmd 0xF0 
      008373 A6 F0            [ 1]    1     ld a,#0xF0 
      008375 CD 83 CF         [ 4]    2     call oled_cmd 
                                    103 ; pre-charge phase1=1 and phase2=15 
      0002F8                        104     _send_cmd PRE_CHARGE
      008378 A6 D9            [ 1]    1     ld a,#PRE_CHARGE 
      00837A CD 83 CF         [ 4]    2     call oled_cmd 
      0002FD                        105     _send_cmd 0xf1 
      00837D A6 F1            [ 1]    1     ld a,#0xf1 
      00837F CD 83 CF         [ 4]    2     call oled_cmd 
                                    106 ; horizontal addressing mode       
      000302                        107     _send_cmd ADR_MODE 
      008382 A6 20            [ 1]    1     ld a,#ADR_MODE 
      008384 CD 83 CF         [ 4]    2     call oled_cmd 
      000307                        108     _send_cmd 0 
      008387 A6 00            [ 1]    1     ld a,#0 
      008389 CD 83 CF         [ 4]    2     call oled_cmd 
                                    109 ; Vcomh deselect level 0.83volt 
      00030C                        110     _send_cmd VCOM_DESEL 
      00838C A6 DB            [ 1]    1     ld a,#VCOM_DESEL 
      00838E CD 83 CF         [ 4]    2     call oled_cmd 
      000311                        111     _send_cmd #0x30 
      008391 A6 30            [ 1]    1     ld a,##0x30 
      008393 CD 83 CF         [ 4]    2     call oled_cmd 
                                    112 ; enable charge pump 
      000316                        113     _send_cmd DISP_CHARGE_PUMP
      008396 A6 8D            [ 1]    1     ld a,#DISP_CHARGE_PUMP 
      008398 CD 83 CF         [ 4]    2     call oled_cmd 
      00031B                        114     _send_cmd 0x14
      00839B A6 14            [ 1]    1     ld a,#0x14 
      00839D CD 83 CF         [ 4]    2     call oled_cmd 
                                    115 ; disable scrolling 
      000320                        116     _send_cmd SCROLL_STOP
      0083A0 A6 2E            [ 1]    1     ld a,#SCROLL_STOP 
      0083A2 CD 83 CF         [ 4]    2     call oled_cmd 
                                    117 ; diplay row from 0 
      000325                        118     _send_cmd START_LINE 
      0083A5 A6 40            [ 1]    1     ld a,#START_LINE 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 52.
Hexadecimal [24-Bits]



      0083A7 CD 83 CF         [ 4]    2     call oled_cmd 
                                    119 ; activate display 
      00032A                        120     _send_cmd DISP_ON 
      0083AA A6 AF            [ 1]    1     ld a,#DISP_ON 
      0083AC CD 83 CF         [ 4]    2     call oled_cmd 
      0083AF 81               [ 4]  121     ret 
                                    122 
                                    123 ;--------------------------------
                                    124 ; set column address to 0:127 
                                    125 ; set page address to 0:7 
                                    126 ;--------------------------------
      0083B0                        127 all_display:
                                    128 ; page window 0..7
      000330                        129     _send_cmd PAG_WND 
      0083B0 A6 22            [ 1]    1     ld a,#PAG_WND 
      0083B2 CD 83 CF         [ 4]    2     call oled_cmd 
      000335                        130     _send_cmd 0  
      0083B5 A6 00            [ 1]    1     ld a,#0 
      0083B7 CD 83 CF         [ 4]    2     call oled_cmd 
      00033A                        131     _send_cmd 7 
      0083BA A6 07            [ 1]    1     ld a,#7 
      0083BC CD 83 CF         [ 4]    2     call oled_cmd 
                                    132 ; columns windows 0..127
      00033F                        133     _send_cmd COL_WND 
      0083BF A6 21            [ 1]    1     ld a,#COL_WND 
      0083C1 CD 83 CF         [ 4]    2     call oled_cmd 
      000344                        134     _send_cmd 0 
      0083C4 A6 00            [ 1]    1     ld a,#0 
      0083C6 CD 83 CF         [ 4]    2     call oled_cmd 
      000349                        135     _send_cmd 127
      0083C9 A6 7F            [ 1]    1     ld a,#127 
      0083CB CD 83 CF         [ 4]    2     call oled_cmd 
      0083CE 81               [ 4]  136     ret 
                                    137 
                                    138 
                           000000   139 .if 0
                                    140 ;------------------------
                                    141 ; scroll display left|right  
                                    142 ; input:
                                    143 ;     A   SCROLL_LEFT|SCROLL_RIGHT 
                                    144 ;     XL  speed 
                                    145 ;------------------------
                                    146 scroll:
                                    147     pushw x 
                                    148     call oled_cmd 
                                    149     _send_cmd 0 ; dummy byte  
                                    150     _send_cmd 0 ; start page 0 
                                    151     pop a ; 
                                    152     pop a ; 
                                    153     call oled_cmd ;speed  
                                    154     _send_cmd 7 ; end page 
                                    155     _send_cmd 0 ; dummy 
                                    156     _send_cmd 255 ; dummy
                                    157     _send_cmd SCROLL_START 
                                    158     ret 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 53.
Hexadecimal [24-Bits]



                                    159 
                                    160 ;---------------------------------
                                    161 ; enable/disable charge pump 
                                    162 ; parameters:
                                    163 ;    A    CP_OFF|CP_ON 
                                    164 ;---------------------------------
                                    165 charge_pump_switch:
                                    166     push a 
                                    167     _send_cmd DISP_CHARGE_PUMP
                                    168     pop a 
                                    169     jra oled_cmd 
                                    170 
                                    171 .endif 
                                    172 
                                    173 ;---------------------------------
                                    174 ; send command to OLED 
                                    175 ; parameters:
                                    176 ;     A     count bytes to send 
                                    177 ;     X     buffer address 
                                    178 ;---------------------------------
      0083CF                        179 oled_cmd:
      0083CF AE 00 02         [ 2]  180     ldw x,#2 
      000352                        181     _strxz i2c_count 
      0083D2 BF 17                    1     .byte 0xbf,i2c_count 
      0083D4 AE 01 00         [ 2]  182     ldw x,#cmd_buffer 
      0083D7 E7 01            [ 1]  183     ld (1,x),a 
      0083D9 A6 80            [ 1]  184     ld a,#OLED_CMD 
      0083DB                        185 oled_send:
      0083DB F7               [ 1]  186     ld (x),a 
      00035C                        187     _strxz i2c_buf 
      0083DC BF 15                    1     .byte 0xbf,i2c_buf 
      0083DE 35 78 00 1C      [ 1]  188     mov i2c_devid,#OLED_DEVID 
      000362                        189     _clrz i2c_status
      0083E2 3F 1B                    1     .byte 0x3f, i2c_status 
      0083E4 CD 82 BD         [ 4]  190     call i2c_write
      0083E7 81               [ 4]  191     ret 
                                    192 
                                    193 ;---------------------------------
                                    194 ; send data to OLED GDDRAM
                                    195 ; parameters:
                                    196 ;     X     buffer address 
                                    197 ;     Y     count bytes to send 
                                    198 ;---------------------------------
      0083E8                        199 oled_data:
      000368                        200     _stryz i2c_count 
      0083E8 90 BF 17                 1     .byte 0x90,0xbf,i2c_count 
      0083EB A6 40            [ 1]  201     ld a,#OLED_DATA 
      0083ED 20 EC            [ 2]  202     jra oled_send  
                                    203 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 54.
Hexadecimal [24-Bits]



                                      1  
                                      2  ;
                                      3 ; Copyright Jacques Deschênes 2023 
                                      4 ; This file is part of stm8_terminal 
                                      5 ;
                                      6 ;     stm8_terminal is free software: you can redistribute it and/or modify
                                      7 ;     it under the terms of the GNU General Public License as published by
                                      8 ;     the Free Software Foundation, either version 3 of the License, or
                                      9 ;     (at your option) any later version.
                                     10 ;
                                     11 ;     stm8_terminal is distributed in the hope that it will be useful,
                                     12 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     13 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     14 ;     GNU General Public License for more details.
                                     15 ;
                                     16 ;     You should have received a copy of the GNU General Public License
                                     17 ;     along with stm8_terminal.  If not, see <http://www.gnu.org/licenses/>.
                                     18 ;;
                                     19 
                                     20 
                                     21 
                                     22 ;; small hexadecimal font, 4x5 pixels 
                           000004    23 SF_WIDTH=4
                           000005    24 SF_HEIGHT=5
      0083EF                         25 font_hex_4x5:
      0083EF E0 A0 A0 A0 E0          26     .byte 0xe0,0xa0,0xa0,0xa0,0xe0 ;0
      0083F4 C0 40 40 40 E0          27     .byte 0xc0,0x40,0x40,0x40,0xe0 ;1
      0083F9 E0 20 E0 80 E0          28     .byte 0xe0,0x20,0xe0,0x80,0xe0 ;2
      0083FE E0 20 E0 20 E0          29     .byte 0xe0,0x20,0xe0,0x20,0xe0 ;3
      008403 A0 A0 E0 20 20          30     .byte 0xa0,0xa0,0xe0,0x20,0x20 ;4
      008408 E0 80 E0 20 E0          31     .byte 0xe0,0x80,0xe0,0x20,0xe0 ;5
      00840D 80 80 E0 A0 E0          32     .byte 0x80,0x80,0xe0,0xa0,0xe0 ;6
      008412 E0 20 20 20 20          33     .byte 0xe0,0x20,0x20,0x20,0x20 ;7
      008417 E0 A0 E0 A0 E0          34     .byte 0xe0,0xa0,0xe0,0xa0,0xe0 ;8
      00841C E0 A0 E0 20 20          35     .byte 0xe0,0xa0,0xe0,0x20,0x20 ;9
      008421 E0 A0 E0 A0 A0          36     .byte 0xe0,0xa0,0xe0,0xa0,0xa0 ;A
      008426 C0 A0 C0 A0 C0          37     .byte 0xc0,0xa0,0xc0,0xa0,0xc0 ;B
      00842B E0 80 80 80 E0          38     .byte 0xe0,0x80,0x80,0x80,0xe0 ;C
      008430 C0 A0 A0 A0 C0          39     .byte 0xc0,0xa0,0xa0,0xa0,0xc0 ;D
      008435 E0 80 E0 80 E0          40     .byte 0xe0,0x80,0xe0,0x80,0xe0 ;E
      00843A E0 80 E0 80 80          41     .byte 0xe0,0x80,0xe0,0x80,0x80 ;F
                                     42 
                                     43 
                                     44 ;; large hexadecimal font, 8x10 pixels
                           000008    45 LF_WIDTH=8 
                           00000A    46 LF_HEIGHT=10 
      00843F                         47 font_hex_8x10:
      00843F 7C 82 86 8A 92 A2 C2    48     .byte 0x7c,0x82,0x86,0x8a,0x92,0xa2,0xc2,0x82,0x7c,0x00 ; 0
             82 7C 00
      008449 08 18 28 08 08 08 08    49     .byte 0x08,0x18,0x28,0x08,0x08,0x08,0x08,0x08,0x3e,0x00 ; 1
             08 3E 00
      008453 38 44 82 04 08 10 20    50     .byte 0x38,0x44,0x82,0x04,0x08,0x10,0x20,0x40,0xfe,0x00 ; 2
             40 FE 00
      00845D 38 44 82 02 3C 02 82    51     .byte 0x38,0x44,0x82,0x02,0x3c,0x02,0x82,0x44,0x38,0x00 ; 3
             44 38 00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 55.
Hexadecimal [24-Bits]



      008467 84 84 84 84 7E 04 04    52     .byte 0x84,0x84,0x84,0x84,0x7e,0x04,0x04,0x04,0x04,0x00 ; 4
             04 04 00
      008471 7E 80 80 80 7C 02 02    53     .byte 0x7e,0x80,0x80,0x80,0x7c,0x02,0x02,0x02,0xfe,0x00 ; 5
             02 FE 00
      00847B 78 84 80 80 FC 82 82    54     .byte 0x78,0x84,0x80,0x80,0xfc,0x82,0x82,0x82,0x7c,0x00 ; 6
             82 7C 00
      008485 7E 82 04 08 08 08 08    55     .byte 0x7e,0x82,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x00 ; 7
             08 08 00
      00848F 38 44 82 82 7C 82 82    56     .byte 0x38,0x44,0x82,0x82,0x7c,0x82,0x82,0x44,0x38,0x00 ; 8
             44 38 00
      008499 38 44 82 82 46 3A 02    57     .byte 0x38,0x44,0x82,0x82,0x46,0x3a,0x02,0x04,0x38,0x00 ; 9
             04 38 00
      0084A3 38 44 82 82 FE 82 82    58     .byte 0x38,0x44,0x82,0x82,0xfe,0x82,0x82,0x82,0x82,0x00 ; A
             82 82 00
      0084AD FC 82 82 82 FC 82 82    59     .byte 0xfc,0x82,0x82,0x82,0xfc,0x82,0x82,0x82,0xfc,0x00 ; B
             82 FC 00
      0084B7 3E 40 80 80 80 80 80    60     .byte 0x3e,0x40,0x80,0x80,0x80,0x80,0x80,0x40,0x3e,0x00 ; C
             40 3E 00
      0084C1 F8 84 82 82 82 82 82    61     .byte 0xf8,0x84,0x82,0x82,0x82,0x82,0x82,0x84,0xf8,0x00 ; D
             84 F8 00
      0084CB FE 80 80 80 FE 80 80    62     .byte 0xfe,0x80,0x80,0x80,0xfe,0x80,0x80,0x80,0xfe,0x00 ; E
             80 FE 00
      0084D5 FE 80 80 80 FE 80 80    63     .byte 0xfe,0x80,0x80,0x80,0xfe,0x80,0x80,0x80,0x80,0x00 ; F
             80 80 00
                                     64 
                                     65 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 56.
Hexadecimal [24-Bits]



                                      1 ; rotated 6x8 pixels font to use with ssd1306 oled display
                                      2  
                                      3 ;
                                      4 ; Copyright Jacques Deschênes 2023 
                                      5 ; This file is part of stm8_tinyForth 
                                      6 ;
                                      7 ;     stm8_tinyForth is free software: you can redistribute it and/or modify
                                      8 ;     it under the terms of the GNU General Public License as published by
                                      9 ;     the Free Software Foundation, either version 3 of the License, or
                                     10 ;     (at your option) any later version.
                                     11 ;
                                     12 ;     stm8_tinyForth is distributed in the hope that it will be useful,
                                     13 ;     but WITHOUT ANY WARRANTY; without even the implied warranty of
                                     14 ;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
                                     15 ;     GNU General Public License for more details.
                                     16 ;
                                     17 ;     You should have received a copy of the GNU General Public License
                                     18 ;     along with stm8_tinyForth.  If not, see <http://www.gnu.org/licenses/>.
                                     19 ;;
                                     20 
                                     21 ; ASCII font 6x8 
                           000008    22 OLED_FONT_HEIGHT=8 
                           000006    23 OLED_FONT_WIDTH=6 
      0084DF                         24 oled_font_6x8: 
      0084DF 00 00 00 00 00 00       25 .byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; space ASCII 32
      0084E5 00 00 5F 00 00 00       26 .byte 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 ; !
      0084EB 00 07 00 07 00 00       27 .byte 0x00, 0x07, 0x00, 0x07, 0x00, 0x00 ; "
      0084F1 14 7F 14 7F 14 00       28 .byte 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 ; #
      0084F7 24 2A 7F 2A 12 00       29 .byte 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 ; $
      0084FD 23 13 08 64 62 00       30 .byte 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 ; %
      008503 36 49 55 22 50 00       31 .byte 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 ; &
      008509 00 05 03 00 00 00       32 .byte 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 ; '
      00850F 00 1C 22 41 00 00       33 .byte 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 ; (
      008515 00 41 22 1C 00 00       34 .byte 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 ; )
      00851B 14 08 3E 08 14 00       35 .byte 0x14, 0x08, 0x3E, 0x08, 0x14, 0x00 ; *
      008521 08 08 3E 08 08 00       36 .byte 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 ; +
      008527 00 D8 78 38 00 00       37 .byte 0x00, 0xD8, 0x78, 0x38, 0x00, 0x00 ; ,
      00852D 08 08 08 08 00 00       38 .byte 0x08, 0x08, 0x08, 0x08, 0x00, 0x00 ; -
      008533 00 60 60 60 00 00       39 .byte 0x00, 0x60, 0x60, 0x60, 0x00, 0x00 ; .
      008539 00 20 34 18 0C 06       40 .byte 0x00, 0x20, 0x34, 0x18, 0x0C, 0x06 ; /
      00853F 3E 51 49 45 3E 00       41 .byte 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 ; 0
      008545 40 42 7F 40 40 00       42 .byte 0x40, 0x42, 0x7F, 0x40, 0x40, 0x00 ; 1
      00854B 62 51 49 45 42 00       43 .byte 0x62, 0x51, 0x49, 0x45, 0x42, 0x00 ; 2
      008551 49 49 49 49 36 00       44 .byte 0x49, 0x49, 0x49, 0x49, 0x36, 0x00 ; 3
      008557 18 14 12 7F 10 00       45 .byte 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 ; 4
      00855D 4F 49 49 49 31 00       46 .byte 0x4F, 0x49, 0x49, 0x49, 0x31, 0x00 ; 5
      008563 3C 4A 49 49 30 00       47 .byte 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 ; 6
      008569 01 71 09 05 03 00       48 .byte 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 ; 7
      00856F 36 49 49 49 36 00       49 .byte 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 ; 8
      008575 06 49 49 49 36 00       50 .byte 0x06, 0x49, 0x49, 0x49, 0x36, 0x00 ; 9
      00857B 00 36 36 36 00 00       51 .byte 0x00, 0x36, 0x36, 0x36, 0x00, 0x00 ; :
      008581 00 F6 76 36 00 00       52 .byte 0x00, 0xF6, 0x76, 0x36, 0x00, 0x00 ; ;
      008587 08 14 22 41 00 00       53 .byte 0x08, 0x14, 0x22, 0x41, 0x00, 0x00 ; <
      00858D 14 14 14 14 14 00       54 .byte 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 ; =
      008593 00 41 22 14 08 00       55 .byte 0x00, 0x41, 0x22, 0x14, 0x08, 0x00 ; >
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 57.
Hexadecimal [24-Bits]



      008599 02 01 51 09 06 00       56 .byte 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 ; ?
      00859F 32 49 79 41 3E 00       57 .byte 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 ; @
      0085A5 7E 09 09 09 7E 00       58 .byte 0x7E, 0x09, 0x09, 0x09, 0x7E, 0x00 ; A
      0085AB 7F 49 49 49 36 00       59 .byte 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 ; B
      0085B1 3E 41 41 41 41 00       60 .byte 0x3E, 0x41, 0x41, 0x41, 0x41, 0x00 ; C
      0085B7 7F 41 41 41 3E 00       61 .byte 0x7F, 0x41, 0x41, 0x41, 0x3E, 0x00 ; D
      0085BD 7F 49 49 49 49 00       62 .byte 0x7F, 0x49, 0x49, 0x49, 0x49, 0x00 ; E
      0085C3 7F 09 09 09 09 00       63 .byte 0x7F, 0x09, 0x09, 0x09, 0x09, 0x00 ; F
      0085C9 3E 41 49 49 31 00       64 .byte 0x3E, 0x41, 0x49, 0x49, 0x31, 0x00 ; G
      0085CF 7F 08 08 08 7F 00       65 .byte 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 ; H
      0085D5 00 41 7F 41 00 00       66 .byte 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 ; I
      0085DB 20 41 41 21 1F 00       67 .byte 0x20, 0x41, 0x41, 0x21, 0x1F, 0x00 ; J
      0085E1 7F 08 14 22 41 00       68 .byte 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 ; K
      0085E7 7F 40 40 40 40 00       69 .byte 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 ; L
      0085ED 7F 02 04 02 7F 00       70 .byte 0x7F, 0x02, 0x04, 0x02, 0x7F, 0x00 ; M
      0085F3 7F 04 08 10 7F 00       71 .byte 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 ; N
      0085F9 3E 41 41 41 3E 00       72 .byte 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 ; O
      0085FF 7F 09 09 09 06 00       73 .byte 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 ; P
      008605 3E 41 51 61 7E 00       74 .byte 0x3E, 0x41, 0x51, 0x61, 0x7E, 0x00 ; Q
      00860B 7F 09 19 29 46 00       75 .byte 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 ; R
      008611 46 49 49 49 31 00       76 .byte 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 ; S
      008617 01 01 01 7F 01 01       77 .byte 0x01, 0x01, 0x01, 0x7F, 0x01, 0x01 ; T
      00861D 3F 40 40 40 3F 00       78 .byte 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 ; U
      008623 1F 20 40 20 1F 00       79 .byte 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 ; V
      008629 7F 20 18 20 7F 00       80 .byte 0x7F, 0x20, 0x18, 0x20, 0x7F, 0x00 ; W
      00862F 63 14 08 14 63 00       81 .byte 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 ; X
      008635 07 08 70 08 07 00       82 .byte 0x07, 0x08, 0x70, 0x08, 0x07, 0x00 ; Y
      00863B 71 49 45 43 41 00       83 .byte 0x71, 0x49, 0x45, 0x43, 0x41, 0x00 ; Z
      008641 00 7F 41 00 00 00       84 .byte 0x00, 0x7F, 0x41, 0x00, 0x00, 0x00 ; [
      008647 02 04 08 10 20 00       85 .byte 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 ; '\'
      00864D 00 00 00 41 7F 00       86 .byte 0x00, 0x00, 0x00, 0x41, 0x7F, 0x00 ; ]
      008653 04 02 01 02 04 00       87 .byte 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 ; ^
      008659 80 80 80 80 80 80       88 .byte 0x80, 0x80, 0x80, 0x80, 0x80, 0x80 ; _
      00865F 00 01 02 04 00 00       89 .byte 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 ; `
      008665 20 54 54 54 78 00       90 .byte 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 ; a
      00866B 7F 50 48 48 30 00       91 .byte 0x7F, 0x50, 0x48, 0x48, 0x30, 0x00 ; b
      008671 38 44 44 44 20 00       92 .byte 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 ; c
      008677 30 48 48 50 7F 00       93 .byte 0x30, 0x48, 0x48, 0x50, 0x7F, 0x00 ; d
      00867D 38 54 54 54 18 00       94 .byte 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 ; e
      008683 08 7E 09 01 02 00       95 .byte 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 ; f
      008689 18 A4 A4 A4 7C 00       96 .byte 0x18, 0xA4, 0xA4, 0xA4, 0x7C, 0x00 ; g
      00868F 7F 08 04 04 78 00       97 .byte 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 ; h
      008695 00 00 7A 00 00 00       98 .byte 0x00, 0x00, 0x7A, 0x00, 0x00, 0x00 ; i
      00869B 20 40 44 3D 00 00       99 .byte 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 ; j
      0086A1 7F 10 28 44 00 00      100 .byte 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00 ; k
      0086A7 00 41 7F 40 00 00      101 .byte 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 ; l
      0086AD 7C 04 18 04 78 00      102 .byte 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 ; m
      0086B3 7C 08 04 04 78 00      103 .byte 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 ; n
      0086B9 38 44 44 44 38 00      104 .byte 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 ; o
      0086BF FC 24 24 24 18 00      105 .byte 0xFC, 0x24, 0x24, 0x24, 0x18, 0x00 ; p
      0086C5 38 44 24 F8 84 00      106 .byte 0x38, 0x44, 0x24, 0xF8, 0x84, 0x00 ; q
      0086CB 7C 08 04 04 08 00      107 .byte 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 ; r
      0086D1 48 54 54 54 20 00      108 .byte 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 ; s
      0086D7 04 3F 44 40 20 00      109 .byte 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 ; t
      0086DD 3C 40 40 20 7C 00      110 .byte 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 ; u
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 58.
Hexadecimal [24-Bits]



      0086E3 1C 20 40 20 1C 00      111 .byte 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 ; v
      0086E9 3C 40 30 40 3C 00      112 .byte 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 ; w
      0086EF 44 28 10 28 44 00      113 .byte 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 ; x
      0086F5 1C A0 A0 A0 7C 00      114 .byte 0x1C, 0xA0, 0xA0, 0xA0, 0x7C, 0x00 ; y
      0086FB 44 64 54 4C 44 00      115 .byte 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 ; z
      008701 08 36 41 00 00 00      116 .byte 0x08, 0x36, 0x41, 0x00, 0x00, 0x00 ; {
      008707 00 00 7F 00 00 00      117 .byte 0x00, 0x00, 0x7F, 0x00, 0x00, 0x00 ; |
      00870D 00 41 36 08 00 00      118 .byte 0x00, 0x41, 0x36, 0x08, 0x00, 0x00 ; }
      008713 08 04 08 10 08 00      119 .byte 0x08, 0x04, 0x08, 0x10, 0x08, 0x00 ; ~  ASCII 127 
      008719 FF FF FF FF FF FF      120 .byte 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF ; 95 block cursor  128 
      00871F 08 49 2A 1C 08 00      121 .byte 0x08, 0x49, 0x2A, 0x1C, 0x08, 0x00 ; 96 flèche droite 129 
      008725 08 1C 2A 49 08 00      122 .byte 0x08, 0x1C, 0x2A, 0x49, 0x08, 0x00 ; 97 flèche gauche 130
      00872B 04 02 3F 02 04 00      123 .byte 0x04, 0x02, 0x3F, 0x02, 0x04, 0x00 ; 98 flèche haut   131
      008731 10 20 7E 20 10 00      124 .byte 0x10, 0x20, 0x7E, 0x20, 0x10, 0x00 ; 99 flèche bas    132
      008737 1C 3E 3E 3E 1C 00      125 .byte 0x1C, 0x3E, 0x3E, 0x3E, 0x1C, 0x00 ; 100 rond         133 
      00873D 00 00 00 80 80 80      126 .byte 0x00, 0x00, 0x00, 0x80, 0x80, 0x80 ; 101 underline cursor 134
      008743 FF 00 00 00 00 00      127 .byte 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00 ; 102 insert cursor 135 
      008749                        128 oled_font_end:
                                    129 
                                    130 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 59.
Hexadecimal [24-Bits]



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
                                     18 
                                     19 ;-------------------------------
                                     20 ;  OLED diplay functions 
                                     21 ;
                                     22 ;  display buffer is 1024 bytes 
                                     23 ;  below stack 
                                     24 ;-------------------------------
                                     25 
                                     26 
                                     27 ;--------------------------
                                     28 ;  zero fill display buffer 
                                     29 ;--------------------------
      008749                         30 display_clear:
      008749 89               [ 2]   31     pushw x 
      00874A 90 89            [ 2]   32     pushw y 
      00874C AE 13 7F         [ 2]   33     ldw x,#disp_buffer
      00874F 90 AE 04 00      [ 2]   34     ldw y,#DISPLAY_BUFFER_SIZE
      008753                         35 1$:
      008753 7F               [ 1]   36     clr (x)
      008754 5C               [ 1]   37     incw x 
      008755 90 5A            [ 2]   38     decw y 
      008757 26 FA            [ 1]   39     jrne 1$
      0006D9                         40     _clrz cur_x 
      008759 3F 1E                    1     .byte 0x3f, cur_x 
      0006DB                         41     _clrz cur_y 
      00875B 3F 1D                    1     .byte 0x3f, cur_y 
      00875D 90 85            [ 2]   42     popw y 
      00875F 85               [ 2]   43     popw x 
      008760 81               [ 4]   44     ret 
                                     45 
                                     46 
                                     47 ;------------------------------
                                     48 ; refresh OLED with buffer data 
                                     49 ;------------------------------
      008761                         50 display_refresh:
      008761 89               [ 2]   51     pushw x 
      008762 90 89            [ 2]   52     pushw y 
      008764 CD 83 B0         [ 4]   53     call all_display 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 60.
Hexadecimal [24-Bits]



      008767 90 AE 04 01      [ 2]   54     ldw y,#DISPLAY_BUFFER_SIZE+1
      00876B AE 13 7E         [ 2]   55     ldw x,#(disp_buffer-1) 
      00876E CD 83 E8         [ 4]   56     call oled_data 
      008771 90 85            [ 2]   57     popw y 
      008773 85               [ 2]   58     popw x 
      008774 81               [ 4]   59     ret 
                                     60 
                                     61 ;----------------------------
                                     62 ; crate bit mask 
                                     63 ; input:
                                     64 ;    A   bit position n{0..7}
                                     65 ; output:
                                     66 ;    A    mask,  2^^n 
                                     67 ;----------------------------
      008775                         68 bit_mask:
      008775 88               [ 1]   69     push a 
      008776 A6 01            [ 1]   70     ld a,#1 
      008778 0D 01            [ 1]   71     tnz (1,sp)
      00877A 27 05            [ 1]   72     jreq 9$ 
      00877C 48               [ 1]   73 1$: sll a 
      00877D 0A 01            [ 1]   74     dec (1,sp)
      00877F 26 FB            [ 1]   75     jrne 1$
      000701                         76 9$: _drop 1
      008781 5B 01            [ 2]    1     addw sp,#1 
      008783 81               [ 4]   77     ret 
                                     78 
                                     79 ;--------------------------------
                                     80 ; translate x,y coordinates 
                                     81 ; to buffer address 
                                     82 ; and bit mask  
                                     83 ; parameters:
                                     84 ;     XL  x coord 
                                     85 ;     XH  y coord 
                                     86 ; output:
                                     87 ;     A   bit mask  
                                     88 ;     X   buffer address  
                                     89 ;---------------------------------
      008784                         90 buffer_addr:
      008784 4F               [ 1]   91     clr a 
      008785 01               [ 1]   92     rrwa x ; x coord    
      008786 88               [ 1]   93     push a 
      008787 4B 00            [ 1]   94     push #0  
      008789 A6 08            [ 1]   95     ld a,#8 
      00878B 62               [ 2]   96     div x,a ; xl=page 
      00878C 88               [ 1]   97     push a  ; remainder=bit position 
      00878D A6 80            [ 1]   98     ld a,#128 
      00878F 42               [ 4]   99     mul x,a 
      008790 1C 13 7F         [ 2]  100     addw x,#disp_buffer 
      008793 72 FB 02         [ 2]  101     addw x,(2,sp) ; x=buffer_addr 
      008796 84               [ 1]  102     pop a 
      008797 CD 87 75         [ 4]  103     call bit_mask  
      00071A                        104     _drop 2
      00879A 5B 02            [ 2]    1     addw sp,#2 
      00879C 81               [ 4]  105     ret 
                                    106 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 61.
Hexadecimal [24-Bits]



                                    107 ;-----------------------------------
                                    108 ; set a single pixel in disp_buffer 
                                    109 ; parameters:
                                    110 ;     XL      x coord 
                                    111 ;     XY      y coord
                                    112 ;-----------------------------------
      00879D                        113 set_pixel:
      00879D CD 87 84         [ 4]  114     call buffer_addr
      0087A0 FA               [ 1]  115     or a,(x)
      0087A1 F7               [ 1]  116     ld (x),a 
      0087A2 81               [ 4]  117     ret 
                                    118 
                                    119 ;-----------------------------------
                                    120 ; reset a single pixel in disp_buffer 
                                    121 ; parameters:
                                    122 ;     XL      x coord 
                                    123 ;     XH      y coord
                                    124 ;-----------------------------------
      0087A3                        125 reset_pixel:
      0087A3 CD 87 84         [ 4]  126     call buffer_addr
      0087A6 43               [ 1]  127     cpl a 
      0087A7 F4               [ 1]  128     and a,(x)
      0087A8 F7               [ 1]  129     ld (x),a 
      0087A9 81               [ 4]  130     ret 
                                    131 
                                    132 ;-----------------------------------
                                    133 ; invert a single pixel in disp_buffer 
                                    134 ; parameters:
                                    135 ;     XL      x coord 
                                    136 ;     XH      y coord
                                    137 ; output:
                                    138 ;     A    bit state, 0 if bit reset 
                                    139 ;-----------------------------------
      0087AA                        140 invert_pixel:
      0087AA CD 87 84         [ 4]  141     call buffer_addr
      0087AD 88               [ 1]  142     push a 
      0087AE F8               [ 1]  143     xor a,(x)
      0087AF F7               [ 1]  144     ld (x),a 
      0087B0 14 01            [ 1]  145     and a,(1,sp)
      0087B2 84               [ 1]  146     pop a 
      0087B3 81               [ 4]  147     ret 
                                    148 
                                    149 ;--------------------------------
                                    150 ; read pixel at x,y coordinates 
                                    151 ; input:
                                    152 ;    XL    x coord 
                                    153 ;    XH    y coord 
                                    154 ; ouput:
                                    155 ;     A    0|1 
                                    156 ;--------------------------------
      0087B4                        157 get_pixel:
      0087B4 CD 87 84         [ 4]  158     call buffer_addr 
      0087B7 F4               [ 1]  159     and a,(x)
      0087B8 27 07            [ 1]  160     jreq 9$
      0087BA A1 01            [ 1]  161 1$: cp a,#1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 62.
Hexadecimal [24-Bits]



      0087BC 27 03            [ 1]  162     jreq 9$
      0087BE 44               [ 1]  163     srl a 
      0087BF 20 F9            [ 2]  164     jra 1$  
      0087C1                        165 9$:    
      0087C1 81               [ 4]  166     ret 
                                    167 
                           000000   168 .if 0
                                    169 ;-------------------------------
                                    170 ; line drawing 
                                    171 ;  X0<=X1 
                                    172 ;  Y0<=Y1 
                                    173 ; input:
                                    174 ;     XH  x0 
                                    175 ;     XL  x1 
                                    176 ;     YH  y0 
                                    177 ;     YL  y1 
                                    178 ;--------------------------------
                                    179     X0=1  ; int8 
                                    180     X1=2  ; int8 
                                    181     Y0=3  ; int8 
                                    182     Y1=4  ; int8 
                                    183     DX=5   ; int16 
                                    184     DY=7   ; int16 
                                    185     DELTA=9 ; int16 
                                    186     VAR_SIZE=10
                                    187 line:
                                    188     _vars VAR_SIZE 
                                    189     ldw (X0,sp),x 
                                    190     ldw (Y0,sp),y
                                    191     ld a,(X1,sp)
                                    192     sub a,(X0,sp)
                                    193     clrw x 
                                    194     ld xl,a 
                                    195     ldw (DX,sp),x 
                                    196     ld a,(Y1,sp)
                                    197     sub a,(Y0,sp)
                                    198     ld xl,a 
                                    199     ldw (DY,sp),x 
                                    200     sllw x 
                                    201     subw x,(DX,sp)
                                    202     ldw (DELTA,sp),x 
                                    203 1$:  
                                    204     ld a,(X0,sp)
                                    205     cp a,(X1,sp)
                                    206     jreq 9$ 
                                    207     ld xl,a 
                                    208     ld a,(Y0,sp)
                                    209     ld xh,a
                                    210     call set_pixel 
                                    211     ldw x,(DELTA,sp)
                                    212     tnzw x
                                    213     jrmi 2$
                                    214     inc (Y0,sp)
                                    215     subw x,(DX,sp)
                                    216     subw x,(DX,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 63.
Hexadecimal [24-Bits]



                                    217 2$: 
                                    218     addw x,(DY,sp)
                                    219     addw x,(DY,sp)
                                    220     ldw (DELTA,sp),x  
                                    221     inc (X0,sp)
                                    222     jra 1$
                                    223 9$:
                                    224     _drop VAR_SIZE 
                                    225     ret 
                                    226 .endif 
                                    227 
                                    228 ;-----------------------
                                    229 ; send text cursor 
                                    230 ; at next line 
                                    231 ;------------------------
      0087C2                        232 crlf:
      000742                        233     _ldaz cur_y
      0087C2 B6 1D                    1     .byte 0xb6,cur_y 
      0087C4 AB 08            [ 1]  234     add a,#OLED_FONT_HEIGHT 
      0087C6 A1 38            [ 1]  235     cp a,#DISP_HEIGHT-OLED_FONT_HEIGHT
      0087C8 2D 07            [ 1]  236     jrsle 6$
      0087CA A6 08            [ 1]  237     ld a,#OLED_FONT_HEIGHT
      0087CC CD 89 10         [ 4]  238     call up_n_lines
      0087CF A6 38            [ 1]  239     ld a,#DISP_HEIGHT-OLED_FONT_HEIGHT  
      000751                        240 6$: _straz cur_y 
      0087D1 B7 1D                    1     .byte 0xb7,cur_y 
      0087D3 4F               [ 1]  241     clr a 
      000754                        242 8$: _straz cur_x 
      0087D4 B7 1E                    1     .byte 0xb7,cur_x 
      0087D6 81               [ 4]  243     ret 
                                    244 
                                    245 ;----------------------------
                                    246 ; set text cursor position 
                                    247 ; input:
                                    248 ;    XL   coloumn {0..20}
                                    249 ;    XH   line {0..7}
                                    250 ;----------------------------
      0087D7                        251 curpos:
      0087D7 89               [ 2]  252     pushw x 
      0087D8 A6 06            [ 1]  253     ld a,#OLED_FONT_WIDTH 
      0087DA 42               [ 4]  254     mul x,a 
      0087DB 9F               [ 1]  255     ld a,xl 
      00075C                        256     _straz cur_x 
      0087DC B7 1E                    1     .byte 0xb7,cur_x 
      0087DE A6 08            [ 1]  257     ld a,#OLED_FONT_HEIGHT 
      0087E0 97               [ 1]  258     ld xl,a 
      0087E1 7B 01            [ 1]  259     ld a,(1,sp)
      0087E3 42               [ 4]  260     mul x,a
      0087E4 9F               [ 1]  261     ld a,xl  
      000765                        262     _straz cur_y
      0087E5 B7 1D                    1     .byte 0xb7,cur_y 
      000767                        263     _drop 2
      0087E7 5B 02            [ 2]    1     addw sp,#2 
      0087E9 81               [ 4]  264     ret 
                                    265 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 64.
Hexadecimal [24-Bits]



                                    266 ;-----------------------
                                    267 ; move cursor right 
                                    268 ; 1 character position
                                    269 ; scroll up if needed 
                                    270 ;-----------------------
      0087EA                        271 cursor_right:
      00076A                        272     _ldaz cur_x 
      0087EA B6 1E                    1     .byte 0xb6,cur_x 
      0087EC AB 06            [ 1]  273     add a,#OLED_FONT_WIDTH  
      00076E                        274     _straz cur_x 
      0087EE B7 1E                    1     .byte 0xb7,cur_x 
      0087F0 A1 7A            [ 1]  275     cp a,#DISP_WIDTH-OLED_FONT_WIDTH 
      0087F2 2D 03            [ 1]  276     jrsle 9$
      0087F4 CD 87 C2         [ 4]  277     call crlf 
      0087F7 81               [ 4]  278 9$: ret 
                                    279 
                                    280 ;----------------------------
                                    281 ; put char using rotated font 
                                    282 ; input:
                                    283 ;    A    character 
                                    284 ;-----------------------------
      0087F8                        285 put_char:
      0087F8 89               [ 2]  286     pushw x
      0087F9 90 89            [ 2]  287     pushw y 
      0087FB A0 20            [ 1]  288 	sub a,#32
      0087FD AE 00 06         [ 2]  289 	ldw x,#6
      008800 42               [ 4]  290 	mul x,a 
      008801 1C 84 DF         [ 2]  291 	addw x,#oled_font_6x8
      008804 90 93            [ 1]  292     ldw y,x 
      000786                        293     _ldxz cur_y 
      008806 BE 1D                    1     .byte 0xbe,cur_y 
      008808 CD 87 84         [ 4]  294     call buffer_addr 
      00880B 4B 06            [ 1]  295     push #OLED_FONT_WIDTH
      00880D                        296 1$:
      00880D 90 F6            [ 1]  297     ld a,(y)
      00880F F7               [ 1]  298     ld (x),a 
      008810 5C               [ 1]  299     incw x 
      008811 90 5C            [ 1]  300     incw y 
      008813 0A 01            [ 1]  301     dec (1,sp)
      008815 26 F6            [ 1]  302     jrne 1$ 
      000797                        303     _drop 1
      008817 5B 01            [ 2]    1     addw sp,#1 
      008819 CD 87 EA         [ 4]  304     call cursor_right 
      00881C 90 85            [ 2]  305     popw y
      00881E 85               [ 2]  306     popw x 
      00881F 81               [ 4]  307     ret 
                                    308 
                                    309 
                                    310 ;----------------------
                                    311 ; put string in display 
                                    312 ; buffer 
                                    313 ; input:
                                    314 ;    y  .asciz  
                                    315 ;----------------------
      008820                        316 put_string:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 65.
Hexadecimal [24-Bits]



      008820 90 F6            [ 1]  317 1$: ld a,(y)
      008822 27 10            [ 1]  318     jreq 9$
      008824 A1 0A            [ 1]  319     cp a,#'\n'
      008826 26 05            [ 1]  320     jrne 2$
      008828 CD 87 C2         [ 4]  321     call crlf 
      00882B 20 03            [ 2]  322     jra 4$
      00882D                        323 2$:
      00882D CD 87 F8         [ 4]  324     call put_char 
      008830                        325 4$:
      008830 90 5C            [ 1]  326     incw y 
      008832 20 EC            [ 2]  327     jra 1$
                                    328 
      008834                        329 9$:  
      008834 81               [ 4]  330     ret 
                                    331 
                                    332 ;-------------------
                                    333 ; put byte in hex 
                                    334 ; input:
                                    335 ;   A 
                                    336 ;------------------
      008835                        337 put_byte:
      008835 88               [ 1]  338     push a 
      008836 4E               [ 1]  339     swap a 
      008837 CD 88 3B         [ 4]  340     call put_hex 
      00883A 84               [ 1]  341     pop a 
      00883B                        342 put_hex:    
      00883B A4 0F            [ 1]  343     and a,#0xf 
      00883D AB 30            [ 1]  344     add a,#'0 
      00883F A1 3A            [ 1]  345     cp a,#'9+1 
      008841 2B 02            [ 1]  346     jrmi 2$ 
      008843 AB 07            [ 1]  347     add a,#7 
      008845 CD 87 F8         [ 4]  348 2$: call put_char 
      008848 81               [ 4]  349     ret 
                                    350 
                                    351 ;----------------------------
                                    352 ; put integer in display 
                                    353 ; buffer 
                                    354 ; input:
                                    355 ;    X    integer to display 
                                    356 ;---------------------------
      008849                        357 put_hex_int:
      008849 9E               [ 1]  358     ld a,xh 
      00884A CD 88 35         [ 4]  359     call put_byte 
      00884D 9F               [ 1]  360     ld a,xl 
      00884E CD 88 35         [ 4]  361     call put_byte 
      008851 81               [ 4]  362     ret 
                                    363 
                                    364 ;-----------------------
                                    365 ; shift diplay page  
                                    366 ; 4 pixel left 
                                    367 ; input:
                                    368 ;    A    page {0..7} 
                                    369 ;-----------------------
      008852                        370 pageleft4pixels:
      008852 89               [ 2]  371     pushw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 66.
Hexadecimal [24-Bits]



      008853 AE 00 80         [ 2]  372     ldw x,#128 
      008856 42               [ 4]  373     mul x,a 
      008857 1C 13 7F         [ 2]  374     addw x,#disp_buffer
      00885A 4B 7C            [ 1]  375     push #128-4
      00885C E6 04            [ 1]  376 1$: ld a,(4,x)
      00885E F7               [ 1]  377     ld (x),a 
      00885F 5C               [ 1]  378     incw x 
      008860 0A 01            [ 1]  379     dec (1,sp)
      008862 26 F8            [ 1]  380     jrne 1$
      008864 A6 04            [ 1]  381     ld a,#4 
      008866 6B 01            [ 1]  382     ld (1,sp),a 
      008868 7F               [ 1]  383 2$: clr (x)
      008869 5C               [ 1]  384     incw x 
      00886A 0A 01            [ 1]  385     dec (1,sp)
      00886C 26 FA            [ 1]  386     jrne 2$
      0007EE                        387     _drop 1    
      00886E 5B 01            [ 2]    1     addw sp,#1 
      008870 85               [ 2]  388     popw x
      008871 81               [ 4]  389     ret 
                                    390 
                                    391 
                                    392 ;-----------------------
                                    393 ; shift display 4 pixels 
                                    394 ; left with 4 right left 
                                    395 ; blank
                                    396 ;-----------------------
      008872                        397 left_4_pixels:
      008872 88               [ 1]  398     push a 
      008873 4B 07            [ 1]  399     push #7 
      008875 7B 01            [ 1]  400 1$: ld a,(1,sp)
      008877 CD 88 52         [ 4]  401     call pageleft4pixels
      00887A 0A 01            [ 1]  402     dec (1,sp)
      00887C 2A F7            [ 1]  403     jrpl 1$
      0007FE                        404     _drop 1
      00887E 5B 01            [ 2]    1     addw sp,#1 
      008880 84               [ 1]  405     pop a 
      008881 81               [ 4]  406     ret 
                                    407 
                                    408 
                                    409 ;---------------------
                                    410 ; shift display page 
                                    411 ; 4 pixel right 
                                    412 ; input:
                                    413 ;     A   page 
                                    414 ;---------------------
      008882                        415 pageright4pixels:
      008882 89               [ 2]  416     pushw x 
      008883 AE 00 80         [ 2]  417     ldw x,#128 
      008886 42               [ 4]  418     mul x,a 
      008887 1C 13 7F         [ 2]  419     addw x,#disp_buffer 
      00888A 1C 00 7B         [ 2]  420     addw x,#127-4
      00888D 4B 7C            [ 1]  421     push #128-4 
      00888F F6               [ 1]  422 1$: ld a,(x)
      008890 E7 04            [ 1]  423     ld (4,x),a 
      008892 5A               [ 2]  424     decw x 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 67.
Hexadecimal [24-Bits]



      008893 0A 01            [ 1]  425     dec (1,sp)
      008895 26 F8            [ 1]  426     jrne 1$ 
      008897 A6 04            [ 1]  427     ld a,#4 
      008899 6B 01            [ 1]  428     ld (1,sp),a
      00889B 5C               [ 1]  429     incw x  
      00889C                        430 2$:
      00889C 7F               [ 1]  431     clr (x)
      00889D 5C               [ 1]  432     incw x 
      00889E 0A 01            [ 1]  433     dec (1,sp)
      0088A0 26 FA            [ 1]  434     jrne 2$
      000822                        435     _drop 1 
      0088A2 5B 01            [ 2]    1     addw sp,#1 
      0088A4 85               [ 2]  436     popw x
      0088A5 81               [ 4]  437     ret 
                                    438 
                                    439 ;-------------------------
                                    440 ; shift display 4 pixels 
                                    441 ; right with 4 left pixels 
                                    442 ; left blank 
                                    443 ;-------------------------
      0088A6                        444 right_4_pixels:
      0088A6 88               [ 1]  445     push a 
      0088A7 4B 07            [ 1]  446     push #7 
      0088A9                        447 1$:
      0088A9 7B 01            [ 1]  448     ld a,(1,sp)
      0088AB CD 88 82         [ 4]  449     call pageright4pixels
      0088AE 0A 01            [ 1]  450     dec (1,sp)
      0088B0 2A F7            [ 1]  451     jrpl 1$
      000832                        452     _drop 1
      0088B2 5B 01            [ 2]    1     addw sp,#1 
      0088B4 84               [ 1]  453     pop a 
      0088B5 81               [ 4]  454     ret 
                                    455 
                                    456 
                                    457 
                                    458 ;-----------------------------
                                    459 ; shift column down 1 pixel 
                                    460 ; input:
                                    461 ;    A    column number {0..127} 
                                    462 ;-----------------------------
      0088B6                        463 column_down:
      0088B6 89               [ 2]  464     pushw x 
      0088B7 5F               [ 1]  465     clrw x 
      0088B8 97               [ 1]  466     ld xl,a 
      0088B9 1C 13 7F         [ 2]  467     addw x,#disp_buffer
      0088BC 4B 08            [ 1]  468     push #8 
      0088BE 98               [ 1]  469     rcf 
      0088BF 8A               [ 1]  470     push cc 
      0088C0 86               [ 1]  471 1$: pop cc 
      0088C1 79               [ 1]  472     rlc (x)
      0088C2 8A               [ 1]  473     push cc 
      0088C3 1C 00 80         [ 2]  474     addw x,#128 
      0088C6 0A 02            [ 1]  475     dec (2,sp)
      0088C8 26 F6            [ 1]  476     jrne 1$ 
      00084A                        477     _drop 2
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 68.
Hexadecimal [24-Bits]



      0088CA 5B 02            [ 2]    1     addw sp,#2 
      0088CC 85               [ 2]  478     popw x 
      0088CD 81               [ 4]  479     ret 
                                    480 
                                    481 ;------------------------------------
                                    482 ; shift 1 column up 1 bit 
                                    483 ; input:
                                    484 ;    A      c  
                                    485 ;------------------------------------
      0088CE                        486 column_up:
      0088CE 89               [ 2]  487     pushw x 
      0088CF 5F               [ 1]  488     clrw x 
      0088D0 97               [ 1]  489     ld xl,a 
      0088D1 1C 16 FF         [ 2]  490     addw x,#disp_buffer+7*128
      0088D4 4B 08            [ 1]  491     push #8 
      0088D6 98               [ 1]  492     rcf 
      0088D7 8A               [ 1]  493     push cc
      0088D8 86               [ 1]  494 2$: pop cc 
      0088D9 F6               [ 1]  495     ld a,(x)
      0088DA 46               [ 1]  496     rrc a 
      0088DB F7               [ 1]  497     ld (x),a 
      0088DC 8A               [ 1]  498     push cc 
      0088DD 1D 00 80         [ 2]  499     subw x,#128 
      0088E0 0A 02            [ 1]  500     dec (2,sp)
      0088E2 26 F4            [ 1]  501     jrne 2$
      000864                        502     _drop 2 
      0088E4 5B 02            [ 2]    1     addw sp,#2 
      0088E6 85               [ 2]  503     popw x 
      0088E7 81               [ 4]  504     ret 
                                    505 
                                    506 
                                    507 ;-------------------------------
                                    508 ; up or down display shift 
                                    509 ; input:
                                    510 ;   A      n  lines shift count 
                                    511 ;   Y      routine vector 
                                    512 ;--------------------------------
                           000001   513     COL=1 
                           000002   514     N=2 
                           000003   515     SHIFT_CNTR=3
                           000003   516     VAR_SIZE=3
      0088E8                        517 vertical_shift:
      000868                        518     _vars VAR_SIZE 
      0088E8 52 03            [ 2]    1     sub sp,#VAR_SIZE 
      0088EA 4D               [ 1]  519     tnz a 
      0088EB 27 14            [ 1]  520     jreq 9$ 
      0088ED 6B 02            [ 1]  521     ld (N,sp),a 
      0088EF 0F 01            [ 1]  522     clr (COL,sp)
      0088F1                        523 2$:
      0088F1 7B 02            [ 1]  524     ld a,(N,sp)
      0088F3 6B 03            [ 1]  525     ld (SHIFT_CNTR,sp),a
      0088F5                        526 4$:
      0088F5 7B 01            [ 1]  527     ld a,(COL,sp)
      0088F7 90 FD            [ 4]  528     call (y) 
      0088F9 0A 03            [ 1]  529     dec (SHIFT_CNTR,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 69.
Hexadecimal [24-Bits]



      0088FB 26 F8            [ 1]  530     jrne 4$  
      0088FD 0C 01            [ 1]  531     inc (COL,sp)
      0088FF 2A F0            [ 1]  532     jrpl 2$ 
      008901                        533 9$:
      000881                        534     _drop VAR_SIZE 
      008901 5B 03            [ 2]    1     addw sp,#VAR_SIZE 
      008903 81               [ 4]  535     ret 
                                    536 
                                    537 ;-----------------------------
                                    538 ; shift down display 
                                    539 ; n lines leaving top n lines 
                                    540 ; blank
                                    541 ; input:
                                    542 ;    A     n 
                                    543 ;----------------------------
      008904                        544 down_n_lines:
      008904 90 89            [ 2]  545     pushw y 
      008906 90 AE 88 B6      [ 2]  546     ldw y,#column_down
      00890A CD 88 E8         [ 4]  547     call vertical_shift
      00890D 90 85            [ 2]  548     popw y 
      00890F 81               [ 4]  549     ret 
                                    550 
                                    551 ;------------------------------------
                                    552 ; shift up diplay 
                                    553 ; n lines leaving bottom lines blank
                                    554 ; input:
                                    555 ;    A     n 
                                    556 ;------------------------------------
      008910                        557 up_n_lines:
      008910 90 89            [ 2]  558     pushw y 
      008912 90 AE 88 CE      [ 2]  559     ldw y,#column_up
      008916 CD 88 E8         [ 4]  560     call vertical_shift
      008919 90 85            [ 2]  561     popw y 
      00891B 81               [ 4]  562     ret 
                                    563 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 70.
Hexadecimal [24-Bits]



                                      1     .module STM8_MON 
                                      2 
                                      3 ;--------------------------------------
                                      4     .area DATA
      000001                          5 mode: .blkb 1 ; command mode 
      000002                          6 xamadr: .blkw 1 ; examine address 
      000004                          7 storadr: .blkw 1 ; store address 
      000006                          8 last: .blkw 1   ; last address parsed from input 
                                      9 
                                     10     .area  CODE
                                     11 
                                     12 ;----------------------------------------------------------------------------------------
                                     13 ; command line interface
                                     14 ; input formats:
                                     15 ;       hex_number  -> display byte at that address 
                                     16 ;       hex_number.hex_number -> display bytes in that range 
                                     17 ;       hex_number: hex_byte [hex_byte]*  -> modify content of RAM or peripheral registers 
                                     18 ;       R  -> run binary code at xamadr address  
                                     19 ;------------------------------------------------------------------------------------------
                                     20 ; operatiing modes 
                           000000    21     NOP=0
                           000001    22     READ=1 ; single address or block
                           000002    23     STORE=2 
                                     24 
                                     25     ; get next character from input buffer 
                                     26     .macro _next_char 
                                     27     ld a,(y)
                                     28     incw y 
                                     29     .endm ; 4 bytes, 2 cy 
                                     30 
      00891C                         31 cli: 
      00891C A6 0D            [ 1]   32     ld a,#CR 
      00891E CD 8A 3F         [ 4]   33     call putchar 
      008921 A6 23            [ 1]   34     ld a,#'# 
      008923 CD 8A 3F         [ 4]   35     call putchar ; prompt character 
      008926 CD 8A 48         [ 4]   36     call getline
                                     37 ; analyze input line      
      008929 90 AE 00 31      [ 2]   38     ldw y,#tib  
      0008AD                         39     _clrz mode 
      00892D 3F 01                    1     .byte 0x3f, mode 
      00892F                         40 next_char:     
      0008AF                         41     _next_char
      00892F 90 F6            [ 1]    1     ld a,(y)
      008931 90 5C            [ 1]    2     incw y 
      008933 4D               [ 1]   42     tnz a     
      008934 26 0B            [ 1]   43     jrne parse01
                                     44 ; at end of line 
      008936 72 5D 00 01      [ 1]   45     tnz mode 
      00893A 27 E0            [ 1]   46     jreq cli 
      00893C CD 89 94         [ 4]   47     call exam_block 
      00893F 20 DB            [ 2]   48     jra cli 
      008941                         49 parse01:
      008941 A1 52            [ 1]   50     cp a,#'R 
      008943 26 03            [ 1]   51     jrne 4$
      0008C5                         52     _ldxz xamadr   
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 71.
Hexadecimal [24-Bits]



      008945 BE 02                    1     .byte 0xbe,xamadr 
      008947 FD               [ 4]   53     call (x) ; run program 
      008948 A1 3A            [ 1]   54 4$: cp a,#':
      00894A 26 05            [ 1]   55     jrne 5$ 
      00894C CD 89 7A         [ 4]   56     call modify 
      00894F 20 CB            [ 2]   57     jra cli     
      008951                         58 5$:
      008951 A1 2E            [ 1]   59     cp a,#'. 
      008953 26 08            [ 1]   60     jrne 8$ 
      008955 72 5D 00 01      [ 1]   61     tnz mode 
      008959 27 C1            [ 1]   62     jreq cli ; here mode should be set to 1 
      00895B 20 D2            [ 2]   63     jra next_char 
      00895D                         64 8$: 
      00895D A1 20            [ 1]   65     cp a,#SPACE 
      00895F 2B CE            [ 1]   66     jrmi next_char ; skip separator and invalids characters  
      008961 CD 89 BB         [ 4]   67     call parse_hex ; maybe an hexadecimal number 
      008964 4D               [ 1]   68     tnz a ; unknown token ignore rest of line
      008965 27 B5            [ 1]   69     jreq cli 
      008967 72 5D 00 01      [ 1]   70     tnz mode 
      00896B 27 05            [ 1]   71     jreq 9$
      00896D CD 89 94         [ 4]   72     call exam_block
      008970 20 BD            [ 2]   73     jra next_char
      008972                         74 9$:
      0008F2                         75     _strxz xamadr 
      008972 BF 02                    1     .byte 0xbf,xamadr 
      0008F4                         76     _strxz storadr
      008974 BF 04                    1     .byte 0xbf,storadr 
      0008F6                         77     _incz mode
      008976 3C 01                    1     .byte 0x3c, mode 
      008978 20 B5            [ 2]   78     jra next_char 
                                     79 
                                     80 ;-------------------------------------
                                     81 ; modify RAM or peripheral register 
                                     82 ; read byte list from input buffer
                                     83 ;--------------------------------------
      00897A                         84 modify:
      00897A                         85 1$: 
                                     86 ; skip spaces 
      0008FA                         87     _next_char 
      00897A 90 F6            [ 1]    1     ld a,(y)
      00897C 90 5C            [ 1]    2     incw y 
      00897E A1 20            [ 1]   88     cp a,#SPACE 
      008980 27 F8            [ 1]   89     jreq 1$ 
      008982 CD 89 BB         [ 4]   90     call parse_hex
      008985 4D               [ 1]   91     tnz a 
      008986 27 09            [ 1]   92     jreq 9$ 
      008988 9F               [ 1]   93     ld a,xl 
      000909                         94     _ldxz storadr 
      008989 BE 04                    1     .byte 0xbe,storadr 
      00898B F7               [ 1]   95     ld (x),a 
      00898C 5C               [ 1]   96     incw x 
      00090D                         97     _strxz storadr
      00898D BF 04                    1     .byte 0xbf,storadr 
      00898F 20 E9            [ 2]   98     jra 1$ 
      000911                         99 9$: _clrz mode 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 72.
Hexadecimal [24-Bits]



      008991 3F 01                    1     .byte 0x3f, mode 
      008993 81               [ 4]  100     ret 
                                    101 
                                    102 ;-------------------------------------------
                                    103 ; display memory in range 'xamadr'...'last' 
                                    104 ;-------------------------------------------    
                           000001   105     ROW_SIZE=1
                           000001   106     VSIZE=1
      008994                        107 exam_block:
      000914                        108     _vars VSIZE
      008994 52 01            [ 2]    1     sub sp,#VSIZE 
      000916                        109     _ldxz xamadr
      008996 BE 02                    1     .byte 0xbe,xamadr 
      008998                        110 new_row: 
      008998 A6 08            [ 1]  111     ld a,#8
      00899A 6B 01            [ 1]  112     ld (ROW_SIZE,sp),a ; bytes per row 
      00899C A6 0D            [ 1]  113     ld a,#CR 
      00899E CD 8A 3F         [ 4]  114     call putchar 
      0089A1 CD 89 E6         [ 4]  115     call print_adr ; display address and first byte of row 
      0089A4 CD 89 EE         [ 4]  116     call print_mem ; display byte at address  
      0089A7                        117 row:
      0089A7 5C               [ 1]  118     incw x 
      0089A8 C3 00 06         [ 2]  119     cpw x,last 
      0089AB 22 09            [ 1]  120     jrugt 9$ 
      0089AD 0A 01            [ 1]  121     dec (ROW_SIZE,sp)
      0089AF 27 E7            [ 1]  122     jreq new_row  
      0089B1 CD 89 EE         [ 4]  123     call print_mem  
      0089B4 20 F1            [ 2]  124     jra row 
      0089B6                        125 9$:
      000936                        126     _clrz mode 
      0089B6 3F 01                    1     .byte 0x3f, mode 
      000938                        127     _drop VSIZE 
      0089B8 5B 01            [ 2]    1     addw sp,#VSIZE 
      0089BA 81               [ 4]  128     ret  
                                    129 
                                    130 ;----------------------------
                                    131 ; parse hexadecimal number 
                                    132 ; from input buffer 
                                    133 ; input:
                                    134 ;    A   first character 
                                    135 ;    Y   pointer to TIB 
                                    136 ; output: 
                                    137 ;    X     number 
                                    138 ;    Y     point after number 
                                    139 ;-----------------------------      
      0089BB                        140 parse_hex:
      0089BB 4B 00            [ 1]  141     push #0 ; digits count 
      0089BD 5F               [ 1]  142     clrw x
      0089BE                        143 1$:    
      0089BE A8 30            [ 1]  144     xor a,#0x30
      0089C0 A1 0A            [ 1]  145     cp a,#10 
      0089C2 2B 06            [ 1]  146     jrmi 2$   ; 0..9 
      0089C4 A1 71            [ 1]  147     cp a,#0x71
      0089C6 2B 15            [ 1]  148     jrmi 9$
      0089C8 A0 67            [ 1]  149     sub a,#0x67  
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 73.
Hexadecimal [24-Bits]



      0089CA 4B 04            [ 1]  150 2$: push #4
      0089CC 4E               [ 1]  151     swap a 
      0089CD                        152 3$:
      0089CD 48               [ 1]  153     sll a 
      0089CE 59               [ 2]  154     rlcw x 
      0089CF 0A 01            [ 1]  155     dec (1,sp)
      0089D1 26 FA            [ 1]  156     jrne 3$
      0089D3 84               [ 1]  157     pop a
      0089D4 0C 01            [ 1]  158     inc (1,sp) ; digits count  
      000956                        159     _next_char 
      0089D6 90 F6            [ 1]    1     ld a,(y)
      0089D8 90 5C            [ 1]    2     incw y 
      0089DA 4D               [ 1]  160     tnz a 
      0089DB 26 E1            [ 1]  161     jrne 1$
      0089DD                        162 9$: ; end of hex number
      0089DD 90 5A            [ 2]  163     decw y  ; put back last character  
      0089DF 84               [ 1]  164     pop a 
      0089E0 4D               [ 1]  165     tnz a 
      0089E1 27 02            [ 1]  166     jreq 10$
      000963                        167     _strxz last 
      0089E3 BF 06                    1     .byte 0xbf,last 
      0089E5                        168 10$:
      0089E5 81               [ 4]  169     ret 
                                    170 
                                    171 ;-----------------------------------
                                    172 ;  print address in xamadr variable
                                    173 ;  followed by ': '  
                                    174 ;  input: 
                                    175 ;    X     address to print 
                                    176 ;  output:
                                    177 ;   X      not modified 
                                    178 ;-------------------------------------
      0089E6                        179 print_adr: 
      0089E6 AD 0F            [ 4]  180     callr print_word 
      0089E8 A6 3A            [ 1]  181     ld a,#': 
      0089EA AD 53            [ 4]  182     callr putchar 
      0089EC 20 04            [ 2]  183     jra space
                                    184 
                                    185 ;-------------------------------------
                                    186 ;  print byte at memory location 
                                    187 ;  pointed by X followed by ' ' 
                                    188 ;  input:
                                    189 ;     X     memory address 
                                    190 ;  output:
                                    191 ;    X      not modified 
                                    192 ;-------------------------------------
      0089EE                        193 print_mem:
      0089EE F6               [ 1]  194     ld a,(x) 
      0089EF CD 8A 00         [ 4]  195     call print_byte 
                                    196     
                                    197 
                                    198 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    199 ;;     TERMIO 
                                    200 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    201 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 74.
Hexadecimal [24-Bits]



                                    202 ;--------------------------------
                                    203 ; print blank space 
                                    204 ;-------------------------------
      0089F2                        205 space:
      0089F2 A6 20            [ 1]  206     ld a,#SPACE 
      0089F4 AD 49            [ 4]  207     callr putchar 
      0089F6 81               [ 4]  208     ret 
                                    209 
                                    210 ;-------------------------------
                                    211 ;  print hexadecimal number 
                                    212 ; input:
                                    213 ;    X  number to print 
                                    214 ; output:
                                    215 ;    none 
                                    216 ;--------------------------------
      0089F7                        217 print_word: 
      0089F7 9E               [ 1]  218     ld a,xh
      0089F8 CD 8A 00         [ 4]  219     call print_byte 
      0089FB 9F               [ 1]  220     ld a,xl 
      0089FC CD 8A 00         [ 4]  221     call print_byte 
      0089FF 81               [ 4]  222     ret 
                                    223 
                                    224 ;---------------------
                                    225 ; print byte value 
                                    226 ; in hexadecimal 
                                    227 ; input:
                                    228 ;    A   value to print 
                                    229 ; output:
                                    230 ;    none 
                                    231 ;-----------------------
      008A00                        232 print_byte:
      008A00 88               [ 1]  233     push a 
      008A01 4E               [ 1]  234     swap a 
      008A02 CD 8A 06         [ 4]  235     call print_digit 
      008A05 84               [ 1]  236     pop a 
                                    237 
                                    238 ;-------------------------
                                    239 ; print lower nibble 
                                    240 ; as digit 
                                    241 ; input:
                                    242 ;    A     hex digit to print
                                    243 ; output:
                                    244 ;   none:
                                    245 ;---------------------------
      008A06                        246 print_digit: 
      008A06 A4 0F            [ 1]  247     and a,#15 
      008A08 AB 30            [ 1]  248     add a,#'0 
      008A0A A1 3A            [ 1]  249     cp a,#'9+1 
      008A0C 2B 02            [ 1]  250     jrmi 1$
      008A0E AB 07            [ 1]  251     add a,#7 
      008A10                        252 1$:
      008A10 CD 8A 3F         [ 4]  253     call putchar 
      008A13                        254 9$:
      008A13 81               [ 4]  255     ret 
                                    256 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 75.
Hexadecimal [24-Bits]



                                    257 
                                    258 ;---------------------------------
                                    259 ; Query for character in rx1_queue
                                    260 ; input:
                                    261 ;   none 
                                    262 ; output:
                                    263 ;   A     0 no charcter available
                                    264 ;   Z     1 no character available
                                    265 ;---------------------------------
      008A14                        266 uart_qgetc:
      000994                        267 	_ldaz rx1_head 
      008A14 B6 2F                    1     .byte 0xb6,rx1_head 
      008A16 C0 00 30         [ 1]  268 	sub a,rx1_tail 
      008A19 81               [ 4]  269 	ret 
                                    270 
                                    271 ;---------------------------------
                                    272 ; wait character from UART 
                                    273 ; input:
                                    274 ;   none
                                    275 ; output:
                                    276 ;   A 			char  
                                    277 ;--------------------------------	
      008A1A                        278 uart_getc::
      008A1A CD 8A 14         [ 4]  279 	call uart_qgetc
      008A1D 27 FB            [ 1]  280 	jreq uart_getc 
      008A1F 89               [ 2]  281 	pushw x 
      0009A0                        282 	_clrz acc16 
      008A20 3F 10                    1     .byte 0x3f, acc16 
      0009A2                        283     _movz acc8,rx1_head 
      008A22 45 2F 11                 1     .byte 0x45,rx1_head,acc8 
      008A25 AE 00 1F         [ 2]  284     ldw x,#rx1_queue
      0009A8                        285 	_ldaz rx1_head 
      008A28 B6 2F                    1     .byte 0xb6,rx1_head 
      008A2A 4C               [ 1]  286 	inc a 
      008A2B A4 0F            [ 1]  287 	and a,#RX_QUEUE_SIZE-1
      0009AD                        288 	_straz rx1_head 
      008A2D B7 2F                    1     .byte 0xb7,rx1_head 
      008A2F 72 D6 00 10      [ 4]  289 	ld a,([acc16],x)
      008A33 A1 61            [ 1]  290 	cp a,#'a 
      008A35 2B 06            [ 1]  291     jrmi 2$ 
      008A37 A1 7B            [ 1]  292     cp a,#'z+1 
      008A39 2A 02            [ 1]  293     jrpl 2$
      008A3B A4 DF            [ 1]  294 	and a,#0xDF ; uppercase letter 
      008A3D                        295 2$:
      008A3D 85               [ 2]  296 	popw x
      008A3E 81               [ 4]  297 	ret 
                                    298 
                                    299 
                                    300 ;---------------------------------------
                                    301 ; send character to terminal 
                                    302 ; input:
                                    303 ;    A    character to send 
                                    304 ; output:
                                    305 ;    none 
                                    306 ;----------------------------------------    
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 76.
Hexadecimal [24-Bits]



      008A3F                        307 putchar:
      008A3F 72 0F 52 40 FB   [ 2]  308     btjf UART_SR,#UART_SR_TXE,. 
      008A44 C7 52 41         [ 1]  309     ld UART_DR,a 
      008A47 81               [ 4]  310     ret 
                                    311 
                                    312 ;------------------------------------
                                    313 ;  read text line from terminal 
                                    314 ;  put it in tib buffer 
                                    315 ;  CR to terminale input.
                                    316 ;  BS to deleter character left 
                                    317 ;  input:
                                    318 ;   none 
                                    319 ;  output:
                                    320 ;    tib      input line ASCIZ no CR  
                                    321 ;-------------------------------------
      008A48                        322 getline:
      008A48 90 AE 00 31      [ 2]  323     ldw y,#tib 
      008A4C                        324 1$:
      008A4C 90 7F            [ 1]  325     clr (y) 
      008A4E AD CA            [ 4]  326     callr uart_getc 
      008A50 A1 0D            [ 1]  327     cp a,#CR 
      008A52 27 1F            [ 1]  328     jreq 9$ 
      008A54 A1 08            [ 1]  329     cp a,#BS 
      008A56 26 04            [ 1]  330     jrne 2$
      008A58 AD 1C            [ 4]  331     callr delback 
      008A5A 20 F0            [ 2]  332     jra 1$ 
      008A5C                        333 2$: 
      008A5C A1 1B            [ 1]  334     cp a,#ESC 
      008A5E 26 07            [ 1]  335     jrne 3$
      008A60 90 AE 00 31      [ 2]  336     ldw y,#tib
      008A64 90 7F            [ 1]  337     clr(y)
      008A66 81               [ 4]  338     ret 
      008A67                        339 3$:    
      008A67 A1 20            [ 1]  340     cp a,#SPACE 
      008A69 2B E1            [ 1]  341     jrmi 1$  ; ignore others control char 
      008A6B AD D2            [ 4]  342     callr putchar
      008A6D 90 F7            [ 1]  343     ld (y),a 
      008A6F 90 5C            [ 1]  344     incw y 
      008A71 20 D9            [ 2]  345     jra 1$
      008A73 AD CA            [ 4]  346 9$: callr putchar 
      008A75 81               [ 4]  347     ret 
                                    348 
                                    349 ;-----------------------------------
                                    350 ; delete character left of cursor 
                                    351 ; decrement Y 
                                    352 ; input:
                                    353 ;   none 
                                    354 ; output:
                                    355 ;   none 
                                    356 ;-----------------------------------
      008A76                        357 delback:
      008A76 90 A3 00 31      [ 2]  358     cpw y,#tib 
      008A7A 27 0C            [ 1]  359     jreq 9$     
      008A7C AD C1            [ 4]  360     callr putchar ; backspace 
      008A7E A6 20            [ 1]  361     ld a,#SPACE    
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 77.
Hexadecimal [24-Bits]



      008A80 AD BD            [ 4]  362     callr putchar ; overwrite with space 
      008A82 A6 08            [ 1]  363     ld a,#BS 
      008A84 AD B9            [ 4]  364     callr putchar ;  backspace
      008A86 90 5A            [ 2]  365     decw y
      008A88                        366 9$:
      008A88 81               [ 4]  367     ret 
                                    368 
                                    369 
                                    370 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    371 ;;   UART subroutines
                                    372 ;;   used for user interface 
                                    373 ;;   communication channel.
                                    374 ;;   settings: 
                                    375 ;;		115200 8N1 no flow control
                                    376 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    377 
                                    378 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    379 ;;; Uart intterrupt handler 
                                    380 ;;; on receive character 
                                    381 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                    382 ;--------------------------
                                    383 ; UART receive character
                                    384 ; in a FIFO buffer 
                                    385 ; CTRL+X reboot system 
                                    386 ;--------------------------
      008A89                        387 UartRxHandler: ; console receive char 
      008A89 72 0B 52 40 2B   [ 2]  388 	btjf UART_SR,#UART_SR_RXNE,5$ 
      008A8E C6 52 41         [ 1]  389 	ld a,UART_DR 
      008A91 A1 03            [ 1]  390 	cp a,#CTRL_C 
      008A93 26 09            [ 1]  391 	jrne 2$ 
      008A95 AE 89 1C         [ 2]  392 	ldw x,#cli  
      008A98 0F 07            [ 1]  393 	clr (7,sp)
      008A9A 1F 08            [ 2]  394 	ldw (8,sp),x 
      008A9C 20 1B            [ 2]  395 	jra 5$
      008A9E                        396 2$:
      008A9E A1 18            [ 1]  397 	cp a,#CAN ; CTRL_X 
      008AA0 26 04            [ 1]  398 	jrne 3$
      000A22                        399 	_swreset 	
      008AA2 35 80 50 D1      [ 1]    1     mov WWDG_CR,#0X80
      008AA6 88               [ 1]  400 3$:	push a 
      008AA7 A6 1F            [ 1]  401 	ld a,#rx1_queue 
      008AA9 CB 00 30         [ 1]  402 	add a,rx1_tail 
      008AAC 5F               [ 1]  403 	clrw x 
      008AAD 97               [ 1]  404 	ld xl,a 
      008AAE 84               [ 1]  405 	pop a 
      008AAF F7               [ 1]  406 	ld (x),a 
      008AB0 C6 00 30         [ 1]  407 	ld a,rx1_tail 
      008AB3 4C               [ 1]  408 	inc a 
      008AB4 A4 0F            [ 1]  409 	and a,#RX_QUEUE_SIZE-1
      008AB6 C7 00 30         [ 1]  410 	ld rx1_tail,a 
      008AB9 80               [11]  411 5$:	iret 
                                    412 
                                    413 
                                    414 ;---------------------------------------------
                                    415 ; initialize UART, 115200 8N1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 78.
Hexadecimal [24-Bits]



                                    416 ; called from cold_start in hardware_init.asm 
                                    417 ; input:
                                    418 ;	none
                                    419 ; output:
                                    420 ;   none
                                    421 ;---------------------------------------------
      008ABA                        422 uart_init:
                                    423 ; enable UART clock
      008ABA 72 16 50 C7      [ 1]  424 	bset CLK_PCKENR1,#UART_PCKEN 	
      008ABE 72 11 00 02      [ 1]  425 	bres UART,#UART_CR1_PIEN
                                    426 ; baud rate 115200
                                    427 ; BRR value = 16Mhz/115200 ; 139 (0x8b) 
      008AC2 A6 0B            [ 1]  428 	ld a,#0xb
      008AC4 C7 52 43         [ 1]  429 	ld UART_BRR2,a 
      008AC7 A6 08            [ 1]  430 	ld a,#0x8 
      008AC9 C7 52 42         [ 1]  431 	ld UART_BRR1,a 
      008ACC                        432 3$:
      008ACC 72 5F 52 41      [ 1]  433     clr UART_DR
      008AD0 35 2C 52 45      [ 1]  434 	mov UART_CR2,#((1<<UART_CR2_TEN)|(1<<UART_CR2_REN)|(1<<UART_CR2_RIEN));
      008AD4 72 10 52 45      [ 1]  435 	bset UART_CR2,#UART_CR2_SBK
      008AD8 72 0D 52 40 FB   [ 2]  436     btjf UART_SR,#UART_SR_TC,.
      008ADD 72 5F 00 2F      [ 1]  437     clr rx1_head 
      008AE1 72 5F 00 30      [ 1]  438 	clr rx1_tail
      008AE5 72 10 00 02      [ 1]  439 	bset UART,#UART_CR1_PIEN
      008AE9 81               [ 4]  440 	ret
                                    441 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 79.
Hexadecimal [24-Bits]



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
                                     18 
                                     19 ;---------------------------------------
                                     20 ; move memory block 
                                     21 ; input:
                                     22 ;   X 		destination 
                                     23 ;   Y 	    source 
                                     24 ;   acc16	bytes count 
                                     25 ; output:
                                     26 ;   none 
                                     27 ;--------------------------------------
                           000001    28 	INCR=1 ; incrament high byte 
                           000002    29 	LB=2 ; increment low byte 
                           000002    30 	VSIZE=2
      008AEA                         31 move::
      008AEA 88               [ 1]   32 	push a 
      000A6B                         33 	_vars VSIZE 
      008AEB 52 02            [ 2]    1     sub sp,#VSIZE 
      008AED 0F 01            [ 1]   34 	clr (INCR,sp)
      008AEF 0F 02            [ 1]   35 	clr (LB,sp)
      008AF1 90 89            [ 2]   36 	pushw y 
      008AF3 13 01            [ 2]   37 	cpw x,(1,sp) ; compare DEST to SRC 
      008AF5 90 85            [ 2]   38 	popw y 
      008AF7 27 2F            [ 1]   39 	jreq move_exit ; x==y 
      008AF9 2B 0E            [ 1]   40 	jrmi move_down
      008AFB                         41 move_up: ; start from top address with incr=-1
      008AFB 72 BB 00 10      [ 2]   42 	addw x,acc16
      008AFF 72 B9 00 10      [ 2]   43 	addw y,acc16
      008B03 03 01            [ 1]   44 	cpl (INCR,sp)
      008B05 03 02            [ 1]   45 	cpl (LB,sp)   ; increment = -1 
      008B07 20 05            [ 2]   46 	jra move_loop  
      008B09                         47 move_down: ; start from bottom address with incr=1 
      008B09 5A               [ 2]   48     decw x 
      008B0A 90 5A            [ 2]   49 	decw y
      008B0C 0C 02            [ 1]   50 	inc (LB,sp) ; incr=1 
      008B0E                         51 move_loop:	
      000A8E                         52     _ldaz acc16 
      008B0E B6 10                    1     .byte 0xb6,acc16 
      008B10 CA 00 11         [ 1]   53 	or a, acc8
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 80.
Hexadecimal [24-Bits]



      008B13 27 13            [ 1]   54 	jreq move_exit 
      008B15 72 FB 01         [ 2]   55 	addw x,(INCR,sp)
      008B18 72 F9 01         [ 2]   56 	addw y,(INCR,sp) 
      008B1B 90 F6            [ 1]   57 	ld a,(y)
      008B1D F7               [ 1]   58 	ld (x),a 
      008B1E 89               [ 2]   59 	pushw x 
      000A9F                         60 	_ldxz acc16 
      008B1F BE 10                    1     .byte 0xbe,acc16 
      008B21 5A               [ 2]   61 	decw x 
      008B22 CF 00 10         [ 2]   62 	ldw acc16,x 
      008B25 85               [ 2]   63 	popw x 
      008B26 20 E6            [ 2]   64 	jra move_loop
      008B28                         65 move_exit:
      000AA8                         66 	_drop VSIZE
      008B28 5B 02            [ 2]    1     addw sp,#VSIZE 
      008B2A 84               [ 1]   67 	pop a 
      008B2B 81               [ 4]   68 	ret 	
                                     69 
                                     70 ;-------------------------------------
                                     71 ; retrun string length
                                     72 ; input:
                                     73 ;   X         .asciz  pointer 
                                     74 ; output:
                                     75 ;   X         not affected 
                                     76 ;   A         length 
                                     77 ;-------------------------------------
      008B2C                         78 strlen::
      008B2C 89               [ 2]   79 	pushw x 
      008B2D 4F               [ 1]   80 	clr a
      008B2E 7D               [ 1]   81 1$:	tnz (x) 
      008B2F 27 04            [ 1]   82 	jreq 9$ 
      008B31 4C               [ 1]   83 	inc a 
      008B32 5C               [ 1]   84 	incw x 
      008B33 20 F9            [ 2]   85 	jra 1$ 
      008B35 85               [ 2]   86 9$:	popw x 
      008B36 81               [ 4]   87 	ret 
                                     88 
                                     89 ;------------------------
                                     90 ; suspend execution 
                                     91 ; input:
                                     92 ;   A     n/60 seconds  
                                     93 ;-------------------------
      008B37                         94 pause:
      000AB7                         95 	_straz delay_timer 
      008B37 B7 0A                    1     .byte 0xb7,delay_timer 
      008B39 72 1E 00 14      [ 1]   96 	bset flags,#F_GAME_TMR 
      008B3D 8F               [10]   97 1$: wfi 	
      008B3E 72 0E 00 14 FA   [ 2]   98 	btjt flags,#F_GAME_TMR,1$ 
      008B43 81               [ 4]   99 	ret 
                                    100 
                                    101 ;--------------------------
                                    102 ; sound timer blocking 
                                    103 ; delay 
                                    104 ; input:
                                    105 ;   A    n*10 msec
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 81.
Hexadecimal [24-Bits]



                                    106 ;--------------------------
      008B44                        107 sound_pause:
      000AC4                        108 	_straz sound_timer  
      008B44 B7 0B                    1     .byte 0xb7,sound_timer 
      008B46 72 1C 00 14      [ 1]  109 	bset flags,#F_SOUND_TMR 
      008B4A 8F               [10]  110 1$: wfi 
      008B4B 72 0C 00 14 FA   [ 2]  111 	btjt flags,#F_SOUND_TMR,1$
      008B50 72 11 53 00      [ 1]  112 	bres TIM2_CR1,#TIM2_CR1_CEN 
      008B54 72 11 53 08      [ 1]  113 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      008B58 72 10 53 04      [ 1]  114 	bset TIM2_EGR,#TIM2_EGR_UG
      008B5C 81               [ 4]  115 9$:	ret 
                                    116 
                                    117 ;-----------------------
                                    118 ; tone generator 
                                    119 ; Ft2clk=62500 hertz 
                                    120 ; input:
                                    121 ;   A   duration n*10 msec    
                                    122 ;   X   frequency 
                                    123 ;------------------------
                           00F424   124 FR_T2_CLK=62500
      008B5D                        125 tone:
      008B5D 90 89            [ 2]  126 	pushw y 
      008B5F 88               [ 1]  127 	push a 
      008B60 90 93            [ 1]  128 	ldw y,x 
      008B62 AE F4 24         [ 2]  129 	ldw x,#FR_T2_CLK 
      008B65 65               [ 2]  130 	divw x,y 
      008B66 9E               [ 1]  131 	ld a,xh 
      008B67 C7 53 0D         [ 1]  132 	ld TIM2_ARRH,a 
      008B6A 9F               [ 1]  133 	ld a,xl 
      008B6B C7 53 0E         [ 1]  134 	ld TIM2_ARRL,a 
      008B6E 54               [ 2]  135 	srlw x 
      008B6F 9E               [ 1]  136 	ld a,xh 
      008B70 C7 53 0F         [ 1]  137 	ld TIM2_CCR1H,a 
      008B73 9F               [ 1]  138 	ld a,xl 
      008B74 C7 53 10         [ 1]  139 	ld TIM2_CCR1L,a 
      008B77 72 10 53 08      [ 1]  140 	bset TIM2_CCER1,#TIM2_CCER1_CC1E
      008B7B 72 10 53 00      [ 1]  141 	bset TIM2_CR1,#TIM2_CR1_CEN 
      008B7F 84               [ 1]  142 	pop a 
      008B80 CD 8B 44         [ 4]  143 	call sound_pause 
      008B83 90 85            [ 2]  144 	popw y 
      008B85 81               [ 4]  145 	ret 
                                    146 
                                    147 ;-----------------
                                    148 ; 1Khz beep 
                                    149 ;-----------------
      008B86                        150 beep:
      008B86 AE 03 E8         [ 2]  151 	ldw x,#1000 ; hertz 
      008B89 A6 14            [ 1]  152 	ld a,#20
      008B8B CD 8B 5D         [ 4]  153 	call tone  
      008B8E 81               [ 4]  154 	ret 
                                    155 
                                    156 ; tempered scale 
      008B8F                        157 scale: 
      008B8F 01 06 01 15 01 26 01   158     .word 262,277,294,311,330,349,370,392,415,440,466,494 ; C4..B4 
             37 01 4A 01 5D 01 72
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 82.
Hexadecimal  01-Bits]



             01 88 01 9F 01 B8 01
             D2 01 EE
      008B9E 88 01 9F 01 B8 01 D2   159     .word 523,554,587,622,659,698,740,784,831,880,932,988 ; c5..B5
             01 EE 02 0B 02 2A 02
             4B 02 6E 02 93 02 BA
             02 E4 03
                                    160 
                                    161 ;---------------------------
                                    162 ; generate white noise using
                                    163 ; 16 bits lfsr 
                                    164 ; input:
                                    165 ;    A   duration 
                                    166 ;----------------------------
      000B3F                        167 noise:
      008BB6 10 03 3F 03      [ 1]  168 	bres TIM2_CCER1,#TIM2_CCER1_CC1E
      000B43                        169 	_straz sound_timer 
      008BBA 70 03                    1     .byte 0xb7,sound_timer 
      008BBC A4 03 DC         [ 4]  170 	call prng 
      008BBF 89               [ 2]  171 	pushw x 
      008BBF 72 11 53 08      [ 1]  172 	bset flags,#F_SOUND_TMR
      008BC3 B7 0B CD         [ 1]  173 1$: ld a,SOUND_PORT+GPIO_ODR 
      008BC6 81               [ 1]  174 	swap a 
      008BC7 43               [ 1]  175 	srl a 
      008BC8 89 72            [ 1]  176 	rlc (2,sp)
      008BCA 1C 00            [ 1]  177 	rlc (1,sp)
      008BCC 14 C6 50 0F      [ 1]  178 	bccm SOUND_PORT+GPIO_ODR,#SOUND_BIT 
      008BD0 4E 44            [ 1]  179 	jrc 2$ 
      008BD2 09 02            [ 1]  180 	ld a,(1,sp)
      008BD4 09 01            [ 1]  181 	xor a,#0xAC 
      008BD6 90 19            [ 1]  182 	ld (1,sp),a 
      008BD8 50 0F            [ 1]  183 	ld a,(2,sp)
      008BDA 25 0C            [ 1]  184 	xor a,#0xE1
      008BDC 7B 01            [ 1]  185 	ld (2,sp),a 
      008BDE A8 AC 6B 01 7B   [ 2]  186 2$: btjf flags,#F_SOUND_TMR,4$
      000B6D                        187 	_usec_dly 500 
      008BE3 02 A8 E1         [ 2]    1     ldw x,#(16*500-2)/4 ; 2 cy 
      008BE6 6B               [ 2]    2     decw x  ; 1 cy 
      008BE7 02               [ 1]    3     nop     ; 1 cy 
      008BE8 72 0D            [ 1]    4     jrne .-2 ; 2 cy 
      008BEA 00 14            [ 2]  188 	jra 1$
      000B76                        189 4$: 
      008BEC 09               [ 2]  190 	popw x 
      008BED AE               [ 4]  191 	ret 
                                    192 
                           000001   193 .if DEBUG 
                                    194 ; print x,y,a 
      000B78                        195 debug_print:
      008BEE 07               [ 2]  196     pushw x
      008BEF CF 5A            [ 2]  197     pushw y 
      008BF1 9D               [ 1]  198     push a  
      008BF2 26 FC 20         [ 4]  199     call print_word 
      008BF5 D7 20            [ 1]  200     ld a,#SPACE 
      008BF6 CD 09 BF         [ 4]  201     call putchar 
      008BF6 85 81            [ 2]  202     ldw x,(2,sp)
      008BF8 CD 09 77         [ 4]  203 	call print_word 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 83.
Hexadecimal [24-Bits]



      008BF8 89 90            [ 1]  204 	ld a,#SPACE 
      008BFA 89 88 CD         [ 4]  205 	call putchar 
      008BFD 89 F7            [ 1]  206 	ld a,(1,sp) 	
      008BFF A6 20 CD         [ 4]  207     call print_byte 
      008C02 8A 3F            [ 1]  208     ld a,#CR 
      008C04 1E 02 CD         [ 4]  209     call putchar 
      008C07 89               [ 1]  210     pop a
      008C08 F7 A6            [ 2]  211 	popw y 
      008C0A 20               [ 2]  212     popw x 
      008C0B CD               [ 4]  213     ret 
                                    214 .endif 
                                    215 
                                    216 
      000B9D                        217 main:
      008C0C 8A 3F 7B         [ 4]  218 	call beep 
      008C0F 01 CD 8A         [ 4]  219 	call oled_init
                           000001   220 .if DEBUG
      008C12 00 A6            [ 1]  221 	ld a,#ESC 
      008C14 0D CD 8A         [ 4]  222 	call putchar 
      008C17 3F 84            [ 1]  223 	ld a,#'c 
      008C19 90 85 85         [ 4]  224 	call putchar 
      000BAD                        225 test1:  
      000BAD                        226 	_ldxz ticks 
      008C1C 81 08                    1     .byte 0xbe,ticks 
      008C1D 89               [ 2]  227 	pushw x 
      008C1D CD 8B            [ 1]  228 	push #21*8 
      008C1F 86 CD            [ 1]  229 1$: ld a,#'1 
      008C21 83 32 A6         [ 4]  230 	call put_char 
      008C24 1B CD            [ 1]  231 	dec (1,sp)
      008C26 8A 3F            [ 1]  232 	jrne 1$
      000BBB                        233 	_drop 1 
      008C28 A6 63            [ 2]    1     addw sp,#1 
      008C2A CD 8A 3F         [ 4]  234 	call display_refresh 
      008C2D                        235 	_ldxz ticks 
      008C2D BE 08                    1     .byte 0xbe,ticks 
      008C2F 89 4B A8         [ 2]  236 	subw x,(1,sp)
      008C32 A6 31 CD         [ 4]  237 	call print_word
      008C35 87 F8            [ 1]  238 	ld a,#SPACE 
      008C37 0A 01 26         [ 4]  239 	call putchar 
      000BCD                        240 test2: 
      008C3A F7 5B 01         [ 4]  241 	call display_clear
      000BD0                        242 	_ldxz ticks 
      008C3D CD 87                    1     .byte 0xbe,ticks 
      008C3F 61 BE            [ 2]  243 	ldw (1,sp),x 
      008C41 08 72            [ 1]  244 	push #21*8
      008C43 F0 01            [ 1]  245 1$:	ld a,#'2 
      008C45 CD 89 F7         [ 4]  246 	call put_char 
      008C48 A6 20            [ 1]  247 	dec (1,sp)
      008C4A CD 8A            [ 1]  248 	jrne 1$
      000BDF                        249 	_drop 1 
      008C4C 3F 01            [ 2]    1     addw sp,#1 
      008C4D CD 06 E1         [ 4]  250 	call display_refresh
      000BE4                        251 	_ldxz ticks 
      008C4D CD 87                    1     .byte 0xbe,ticks 
      008C4F 49 BE 08         [ 2]  252 	subw x,(1,sp)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 84.
Hexadecimal [24-Bits]



      008C52 1F 01 4B         [ 4]  253 	call print_word
      008C55 A8 A6            [ 1]  254 	ld a,#SPACE 
      008C57 32 CD 87         [ 4]  255 	call putchar 
      000BF1                        256 test3: ; display_refresh time 
      000BF1                        257 	_ldxz ticks 
      008C5A F8 0A                    1     .byte 0xbe,ticks 
      008C5C 01 26            [ 2]  258 	ldw (1,sp),x 
      008C5E F7 5B 01         [ 4]  259 	call display_refresh
      000BF8                        260 	_ldxz ticks  
      008C61 CD 87                    1     .byte 0xbe,ticks 
      008C63 61 BE 08         [ 2]  261 	subw x,(1,sp)
      008C66 72 F0 01         [ 4]  262 	call print_word
      000C00                        263 	_drop 2 
      008C69 CD 89            [ 2]    1     addw sp,#2 
      000C02                        264 test4: ; print all char in loop 
      008C6B F7 A6 20         [ 4]  265 	call display_clear 
      008C6E CD 8A            [ 1]  266 	push #SPACE 
      008C70 3F 01            [ 1]  267 1$:	ld a,(1,sp)
      008C71 A1 80            [ 1]  268 	cp a,#128 
      008C71 BE 08            [ 1]  269 	jreq test5
      008C73 1F 01 CD         [ 4]  270 	call put_char
      008C76 87 61 BE         [ 4]  271 	call display_refresh
      008C79 08 72            [ 1]  272 	inc (1,sp)
      008C7B F0 01            [ 2]  273 	jra 1$ 
      000C17                        274 test5:
      000C17                        275 	_drop 1 
      008C7D CD 89            [ 2]    1     addw sp,#1 
      008C7F F7 5B 02         [ 4]  276 	call display_clear 
      008C82 90 AE 0C 28      [ 2]  277 1$: ldw y,#hello 
      008C82 CD 87 49         [ 4]  278 	call put_string 
      008C85 4B 20 7B         [ 4]  279 	call display_refresh
      008C88 01 A1            [ 2]  280 	jra 1$ 
      008C8A 80 27 0A CD 87 F8 CD   281 hello: .asciz "HELLO "
      000C2F                        282 end_test: 	 
                                    283 .endif 
                                    284 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 85.
Hexadecimal  87-Bits]

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
    CLK_ECKR=  000000     |     CLK_ECKR=  000001     |     CLK_FREQ=  0000D5 
    CLK_HSIT=  0050CC     |     CLK_ICKR=  0050C0     |     CLK_ICKR=  000002 
    CLK_ICKR=  000000     |     CLK_ICKR=  000001     |     CLK_ICKR=  000003 
    CLK_ICKR=  000004     |     CLK_ICKR=  000005     |     CLK_PCKE=  0050C7 
    CLK_PCKE=  000000     |     CLK_PCKE=  000001     |     CLK_PCKE=  000007 
    CLK_PCKE=  000005     |     CLK_PCKE=  000006     |     CLK_PCKE=  000004 
    CLK_PCKE=  000002     |     CLK_PCKE=  000003     |     CLK_PCKE=  0050CA 
    CLK_PCKE=  000003     |     CLK_PCKE=  000002     |     CLK_PCKE=  000007 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 86.
Hexadecimal [24-Bits]

Symbol Table

    CLK_SWCR=  0050C5     |     CLK_SWCR=  000000     |     CLK_SWCR=  000001 
    CLK_SWCR=  000002     |     CLK_SWCR=  000003     |     CLK_SWIM=  0050CD 
    CLK_SWR =  0050C4     |     CLK_SWR_=  0000B4     |     CLK_SWR_=  0000E1 
    CLK_SWR_=  0000D2     |     COL     =  000001     |     COLON   =  00003A 
    COL_WND =  000021     |     COMMA   =  00002C     |     COM_CFG =  0000DA 
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
    DEBUG_BA=  007F00     |     DEBUG_EN=  007FFF     |     DEVID_BA=  0048CD 
    DEVID_EN=  0048D8     |     DEVID_LO=  0048D2     |     DEVID_LO=  0048D3 
    DEVID_LO=  0048D4     |     DEVID_LO=  0048D5     |     DEVID_LO=  0048D6 
    DEVID_LO=  0048D7     |     DEVID_LO=  0048D8     |     DEVID_WA=  0048D1 
    DEVID_XH=  0048CE     |     DEVID_XL=  0048CD     |     DEVID_YH=  0048D0 
    DEVID_YL=  0048CF     |     DISPLAY_=  000400     |     DISP_ALL=  0000A5 
    DISP_CHA=  00008D     |     DISP_CON=  000081     |     DISP_HEI=  000040 
    DISP_INV=  0000A7     |     DISP_NOR=  0000A6     |     DISP_OFF=  0000AE 
    DISP_OFF=  0000D3     |     DISP_ON =  0000AF     |     DISP_RAM=  0000A4 
    DISP_WID=  000080     |     DLE     =  000010     |     DM_BK1RE=  007F90 
    DM_BK1RH=  007F91     |     DM_BK1RL=  007F92     |     DM_BK2RE=  007F93 
    DM_BK2RH=  007F94     |     DM_BK2RL=  007F95     |     DM_CR1  =  007F96 
    DM_CR2  =  007F97     |     DM_CSR1 =  007F98     |     DM_CSR2 =  007F99 
    DM_ENFCT=  007F9A     |     EEPROM_B=  004000     |     EEPROM_E=  0043FF 
    EEPROM_S=  000400     |     EM      =  000019     |     ENQ     =  000005 
    EOF     =  00001A     |     EOT     =  000004     |     ESC     =  00001B 
    ETB     =  000017     |     ETX     =  000003     |     EXTI_CR1=  0050A0 
    EXTI_CR2=  0050A1     |     FF      =  00000C     |     FHSE    =  7A1200 
    FHSI    =  F42400     |     FLASH_BA=  008000     |     FLASH_CR=  00505A 
    FLASH_CR=  000002     |     FLASH_CR=  000000     |     FLASH_CR=  000003 
    FLASH_CR=  000001     |     FLASH_CR=  00505B     |     FLASH_CR=  000005 
    FLASH_CR=  000004     |     FLASH_CR=  000007     |     FLASH_CR=  000000 
    FLASH_CR=  000006     |     FLASH_DU=  005064     |     FLASH_DU=  0000AE 
    FLASH_DU=  000056     |     FLASH_EN=  017FFF     |     FLASH_FP=  00505D 
    FLASH_FP=  000000     |     FLASH_FP=  000001     |     FLASH_FP=  000002 
    FLASH_FP=  000003     |     FLASH_FP=  000004     |     FLASH_FP=  000005 
    FLASH_IA=  00505F     |     FLASH_IA=  000003     |     FLASH_IA=  000002 
    FLASH_IA=  000006     |     FLASH_IA=  000001     |     FLASH_IA=  000000 
    FLASH_NC=  00505C     |     FLASH_NF=  00505E     |     FLASH_NF=  000000 
    FLASH_NF=  000001     |     FLASH_NF=  000002     |     FLASH_NF=  000003 
    FLASH_NF=  000004     |     FLASH_NF=  000005     |     FLASH_PU=  005062 
    FLASH_PU=  000056     |     FLASH_PU=  0000AE     |     FLASH_SI=  010000 
    FLASH_WS=  00480D     |     FLSI    =  01F400     |     FMSTR   =  000010 
    FR_T2_CL=  00F424     |     FS      =  00001C     |     F_DISP_M=  000005 
    F_GAME_T=  000007     |     F_SOUND_=  000006     |     GPIO_BAS=  005000 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 87.
Hexadecimal [24-Bits]

Symbol Table

    GPIO_CR1=  000003     |     GPIO_CR2=  000004     |     GPIO_DDR=  000002 
    GPIO_IDR=  000001     |     GPIO_ODR=  000000     |     GPIO_SIZ=  000005 
    GS      =  00001D     |     HSECNT  =  004809     |     I2C_BASE=  005210 
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
    I2C_WRIT=  000000     |   7 I2cIntHa   00015E R   |     INCR    =  000001 
    INPUT_DI=  000000     |     INPUT_EI=  000001     |     INPUT_FL=  000000 
    INPUT_PU=  000001     |     INT_ADC2=  000016     |     INT_AUAR=  000012 
    INT_AWU =  000001     |     INT_CAN_=  000008     |     INT_CAN_=  000009 
    INT_CLK =  000002     |     INT_EXTI=  000003     |     INT_EXTI=  000004 
    INT_EXTI=  000005     |     INT_EXTI=  000006     |     INT_EXTI=  000007 
    INT_FLAS=  000018     |     INT_I2C =  000013     |     INT_SPI =  00000A 
    INT_TIM1=  00000C     |     INT_TIM1=  00000B     |     INT_TIM2=  00000E 
    INT_TIM2=  00000D     |     INT_TIM3=  000010     |     INT_TIM3=  00000F 
    INT_TIM4=  000017     |     INT_TLI =  000000     |     INT_UART=  000011 
    INT_UART=  000015     |     INT_UART=  000014     |     INT_VECT=  008060 
    INT_VECT=  00800C     |     INT_VECT=  008028     |     INT_VECT=  00802C 
    INT_VECT=  008010     |     INT_VECT=  008014     |     INT_VECT=  008018 
    INT_VECT=  00801C     |     INT_VECT=  008020     |     INT_VECT=  008024 
    INT_VECT=  008068     |     INT_VECT=  008054     |     INT_VECT=  008000 
    INT_VECT=  008030     |     INT_VECT=  008038     |     INT_VECT=  008034 
    INT_VECT=  008040     |     INT_VECT=  00803C     |     INT_VECT=  008048 
    INT_VECT=  008044     |     INT_VECT=  008064     |     INT_VECT=  008008 
    INT_VECT=  008004     |     INT_VECT=  008050     |     INT_VECT=  00804C 
    INT_VECT=  00805C     |     INT_VECT=  008058     |     ITC_SPR1=  007F70 
    ITC_SPR2=  007F71     |     ITC_SPR3=  007F72     |     ITC_SPR4=  007F73 
    ITC_SPR5=  007F74     |     ITC_SPR6=  007F75     |     ITC_SPR7=  007F76 
    ITC_SPR8=  007F77     |     ITC_SPR_=  000001     |     ITC_SPR_=  000000 
    ITC_SPR_=  000003     |     IWDG_KEY=  000055     |     IWDG_KEY=  0000CC 
    IWDG_KEY=  0000AA     |     IWDG_KR =  0050E0     |     IWDG_PR =  0050E1 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 88.
Hexadecimal [24-Bits]

Symbol Table

    IWDG_RLR=  0050E2     |     KPAD    =  000001     |     LB      =  000002 
    LED_BIT =  000005     |     LED_MASK=  000020     |     LED_PORT=  00500A 
    LF      =  00000A     |     LF_HEIGH=  00000A     |     LF_WIDTH=  000008 
    MAJOR   =  000001     |     MAP_SEG0=  0000A0     |     MAP_SEG0=  0000A1 
    MASKED  =  000005     |     MINOR   =  000000     |     MUX_RATI=  0000A8 
    N       =  000002     |     NAFR    =  004804     |     NAK     =  000015 
    NCLKOPT =  004808     |     NFLASH_W=  00480E     |     NHSECNT =  00480A 
    NOP     =  000000     |     NOPT1   =  004802     |     NOPT2   =  004804 
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
    PAG_WND =  000022     |     PA_BASE =  005000     |     PA_CR1  =  005003 
    PA_CR2  =  005004     |     PA_DDR  =  005002     |     PA_IDR  =  005001 
    PA_ODR  =  005000     |     PB      =  000005     |     PB_BASE =  005005 
    PB_CR1  =  005008     |     PB_CR2  =  005009     |     PB_DDR  =  005007 
    PB_IDR  =  005006     |     PB_ODR  =  005005     |     PC      =  00000A 
    PC_BASE =  00500A     |     PC_CR1  =  00500D     |     PC_CR2  =  00500E 
    PC_DDR  =  00500C     |     PC_IDR  =  00500B     |     PC_ODR  =  00500A 
    PD      =  00000F     |     PD_BASE =  00500F     |     PD_CR1  =  005012 
    PD_CR2  =  005013     |     PD_DDR  =  005011     |     PD_IDR  =  005010 
    PD_ODR  =  00500F     |     PE      =  000014     |     PE_BASE =  005014 
    PE_CR1  =  005017     |     PE_CR2  =  005018     |     PE_DDR  =  005016 
    PE_IDR  =  005015     |     PE_ODR  =  005014     |     PF      =  000019 
    PF_BASE =  005019     |     PF_CR1  =  00501C     |     PF_CR2  =  00501D 
    PF_DDR  =  00501B     |     PF_IDR  =  00501A     |     PF_ODR  =  005019 
    PG      =  00001E     |     PG_BASE =  00501E     |     PG_CR1  =  005021 
    PG_CR2  =  005022     |     PG_DDR  =  005020     |     PG_IDR  =  00501F 
    PG_ODR  =  00501E     |     PH      =  000023     |     PH_BASE =  005023 
    PH_CR1  =  005026     |     PH_CR2  =  005027     |     PH_DDR  =  005025 
    PH_IDR  =  005024     |     PH_ODR  =  005023     |     PI      =  000028 
    PI_BASE =  005028     |     PI_CR1  =  00502B     |     PI_CR2  =  00502C 
    PI_DDR  =  00502A     |     PI_IDR  =  005029     |     PI_ODR  =  005028 
    PRE_CHAR=  0000D9     |     PRIORITY=  000003     |     RAM_BASE=  000000 
    RAM_END =  0017FF     |     RAM_SIZE=  001800     |     READ    =  000001 
    REV     =  000000     |     ROP     =  004800     |     ROW_SIZE=  000001 
    RS      =  00001E     |     RST_SR  =  0050B3     |     RX_QUEUE=  000010 
    SCAN_REV=  0000C8     |     SCAN_TOP=  0000C0     |     SCL_BIT =  000004 
    SCROLL_L=  000027     |     SCROLL_R=  000026     |     SCROLL_S=  00002F 
    SCROLL_S=  00002E     |     SCROLL_V=  00002A     |     SCROLL_V=  000029 
    SDA_BIT =  000005     |     SEMIC   =  00003B     |     SEPARATE=  000000 
    SFR_BASE=  005000     |     SFR_END =  0057FF     |     SF_HEIGH=  000005 
    SF_WIDTH=  000004     |     SHARP   =  000023     |     SHIFT_CN=  000003 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 89.
Hexadecimal [24-Bits]

Symbol Table

    SI      =  00000F     |     SLOT    =  000004     |     SO      =  00000E 
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
    SPI_SR_W=  000003     |     SPI_TXCR=  005207     |     SPR_ADDR=  000001 
    STACK_EM=  0017FF     |     STACK_SI=  000080     |     START_LI=  000040 
    STORE   =  000002     |     STX     =  000002     |     SUB     =  00001A 
    SWIM_CSR=  007F80     |     SYN     =  000016     |     TAB     =  000009 
    TIB_SIZE=  000028     |     TICK    =  000027     |     TIM1_ARR=  005262 
    TIM1_ARR=  005263     |     TIM1_BKR=  00526D     |     TIM1_CCE=  00525C 
    TIM1_CCE=  00525D     |     TIM1_CCM=  005258     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCM=  005259     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCM=  00525A     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCM=  00525B     |     TIM1_CCM=  000000 
    TIM1_CCM=  000001     |     TIM1_CCM=  000004     |     TIM1_CCM=  000005 
    TIM1_CCM=  000006     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000003     |     TIM1_CCM=  000007     |     TIM1_CCM=  000002 
    TIM1_CCM=  000004     |     TIM1_CCM=  000005     |     TIM1_CCM=  000006 
    TIM1_CCM=  000003     |     TIM1_CCR=  005265     |     TIM1_CCR=  005266 
    TIM1_CCR=  005267     |     TIM1_CCR=  005268     |     TIM1_CCR=  005269 
    TIM1_CCR=  00526A     |     TIM1_CCR=  00526B     |     TIM1_CCR=  00526C 
    TIM1_CNT=  00525E     |     TIM1_CNT=  00525F     |     TIM1_CR1=  005250 
    TIM1_CR2=  005251     |     TIM1_CR2=  000000     |     TIM1_CR2=  000002 
    TIM1_CR2=  000004     |     TIM1_CR2=  000005     |     TIM1_CR2=  000006 
    TIM1_DTR=  00526E     |     TIM1_EGR=  005257     |     TIM1_EGR=  000007 
    TIM1_EGR=  000001     |     TIM1_EGR=  000002     |     TIM1_EGR=  000003 
    TIM1_EGR=  000004     |     TIM1_EGR=  000005     |     TIM1_EGR=  000006 
    TIM1_EGR=  000000     |     TIM1_ETR=  005253     |     TIM1_ETR=  000006 
    TIM1_ETR=  000000     |     TIM1_ETR=  000001     |     TIM1_ETR=  000002 
    TIM1_ETR=  000003     |     TIM1_ETR=  000007     |     TIM1_ETR=  000004 
    TIM1_ETR=  000005     |     TIM1_IER=  005254     |     TIM1_IER=  000007 
    TIM1_IER=  000001     |     TIM1_IER=  000002     |     TIM1_IER=  000003 
    TIM1_IER=  000004     |     TIM1_IER=  000005     |     TIM1_IER=  000006 
    TIM1_IER=  000000     |     TIM1_OIS=  00526F     |     TIM1_PSC=  005260 
    TIM1_PSC=  005261     |     TIM1_RCR=  005264     |     TIM1_SMC=  005252 
    TIM1_SMC=  000007     |     TIM1_SMC=  000000     |     TIM1_SMC=  000001 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 90.
Hexadecimal [24-Bits]

Symbol Table

    TIM1_SMC=  000002     |     TIM1_SMC=  000004     |     TIM1_SMC=  000005 
    TIM1_SMC=  000006     |     TIM1_SR1=  005255     |     TIM1_SR1=  000007 
    TIM1_SR1=  000001     |     TIM1_SR1=  000002     |     TIM1_SR1=  000003 
    TIM1_SR1=  000004     |     TIM1_SR1=  000005     |     TIM1_SR1=  000006 
    TIM1_SR1=  000000     |     TIM1_SR2=  005256     |     TIM1_SR2=  000001 
    TIM1_SR2=  000002     |     TIM1_SR2=  000003     |     TIM1_SR2=  000004 
    TIM2_ARR=  00530D     |     TIM2_ARR=  00530E     |     TIM2_CCE=  005308 
    TIM2_CCE=  000000     |     TIM2_CCE=  000001     |     TIM2_CCE=  000004 
    TIM2_CCE=  000005     |     TIM2_CCE=  005309     |     TIM2_CCM=  005305 
    TIM2_CCM=  005306     |     TIM2_CCM=  005307     |     TIM2_CCM=  000000 
    TIM2_CCM=  000004     |     TIM2_CCM=  000003     |     TIM2_CCR=  00530F 
    TIM2_CCR=  005310     |     TIM2_CCR=  005311     |     TIM2_CCR=  005312 
    TIM2_CCR=  005313     |     TIM2_CCR=  005314     |     TIM2_CLK=  00F424 
    TIM2_CNT=  00530A     |     TIM2_CNT=  00530B     |     TIM2_CR1=  005300 
    TIM2_CR1=  000007     |     TIM2_CR1=  000000     |     TIM2_CR1=  000003 
    TIM2_CR1=  000001     |     TIM2_CR1=  000002     |     TIM2_EGR=  005304 
    TIM2_EGR=  000001     |     TIM2_EGR=  000002     |     TIM2_EGR=  000003 
    TIM2_EGR=  000006     |     TIM2_EGR=  000000     |     TIM2_IER=  005301 
    TIM2_PSC=  00530C     |     TIM2_SR1=  005302     |     TIM2_SR2=  005303 
    TIM3_ARR=  00532B     |     TIM3_ARR=  00532C     |     TIM3_CCE=  005327 
    TIM3_CCE=  000000     |     TIM3_CCE=  000001     |     TIM3_CCE=  000004 
    TIM3_CCE=  000005     |     TIM3_CCE=  000000     |     TIM3_CCE=  000001 
    TIM3_CCM=  005325     |     TIM3_CCM=  005326     |     TIM3_CCM=  000000 
    TIM3_CCM=  000004     |     TIM3_CCM=  000003     |     TIM3_CCR=  00532D 
    TIM3_CCR=  00532E     |     TIM3_CCR=  00532F     |     TIM3_CCR=  005330 
    TIM3_CNT=  005328     |     TIM3_CNT=  005329     |     TIM3_CR1=  005320 
    TIM3_CR1=  000007     |     TIM3_CR1=  000000     |     TIM3_CR1=  000003 
    TIM3_CR1=  000001     |     TIM3_CR1=  000002     |     TIM3_EGR=  005324 
    TIM3_IER=  005321     |     TIM3_PSC=  00532A     |     TIM3_SR1=  005322 
    TIM3_SR2=  005323     |     TIM4_ARR=  005346     |     TIM4_CNT=  005344 
    TIM4_CR1=  005340     |     TIM4_CR1=  000007     |     TIM4_CR1=  000000 
    TIM4_CR1=  000003     |     TIM4_CR1=  000001     |     TIM4_CR1=  000002 
    TIM4_EGR=  005343     |     TIM4_EGR=  000000     |     TIM4_IER=  005341 
    TIM4_IER=  000000     |     TIM4_PSC=  005345     |     TIM4_PSC=  000000 
    TIM4_PSC=  000007     |     TIM4_PSC=  000004     |     TIM4_PSC=  000001 
    TIM4_PSC=  000005     |     TIM4_PSC=  000002     |     TIM4_PSC=  000006 
    TIM4_PSC=  000003     |     TIM4_PSC=  000000     |     TIM4_PSC=  000001 
    TIM4_PSC=  000002     |     TIM4_SR =  005342     |     TIM4_SR_=  000000 
    TIM_CR1_=  000007     |     TIM_CR1_=  000000     |     TIM_CR1_=  000006 
    TIM_CR1_=  000005     |     TIM_CR1_=  000004     |     TIM_CR1_=  000003 
    TIM_CR1_=  000001     |     TIM_CR1_=  000002     |   7 Timer4Up   000001 R
    UART    =  000002     |     UART1   =  000000     |     UART1_BA=  005230 
    UART1_BR=  005232     |     UART1_BR=  005233     |     UART1_CR=  005234 
    UART1_CR=  005235     |     UART1_CR=  005236     |     UART1_CR=  005237 
    UART1_CR=  005238     |     UART1_DR=  005231     |     UART1_GT=  005239 
    UART1_PO=  000000     |     UART1_PS=  00523A     |     UART1_RX=  000004 
    UART1_SR=  005230     |     UART1_TX=  000005     |     UART2   =  000001 
    UART3   =  000002     |     UART3_BA=  005240     |     UART3_BR=  005242 
    UART3_BR=  005243     |     UART3_CR=  005244     |     UART3_CR=  005245 
    UART3_CR=  005246     |     UART3_CR=  005247     |     UART3_CR=  004249 
    UART3_DR=  005241     |     UART3_PO=  00000F     |     UART3_RX=  000006 
    UART3_SR=  005240     |     UART3_TX=  000005     |     UART_BRR=  005242 
    UART_BRR=  005243     |     UART_CR1=  005244     |     UART_CR1=  000004 
    UART_CR1=  000002     |     UART_CR1=  000000     |     UART_CR1=  000001 
    UART_CR1=  000007     |     UART_CR1=  000006     |     UART_CR1=  000005 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 91.
Hexadecimal [24-Bits]

Symbol Table

    UART_CR1=  000003     |     UART_CR2=  005245     |     UART_CR2=  000004 
    UART_CR2=  000002     |     UART_CR2=  000005     |     UART_CR2=  000001 
    UART_CR2=  000000     |     UART_CR2=  000006     |     UART_CR2=  000003 
    UART_CR2=  000007     |     UART_CR3=  000003     |     UART_CR3=  000001 
    UART_CR3=  000002     |     UART_CR3=  000000     |     UART_CR3=  000006 
    UART_CR3=  000004     |     UART_CR3=  000005     |     UART_CR4=  000000 
    UART_CR4=  000001     |     UART_CR4=  000002     |     UART_CR4=  000003 
    UART_CR4=  000004     |     UART_CR4=  000006     |     UART_CR4=  000005 
    UART_CR5=  000003     |     UART_CR5=  000001     |     UART_CR5=  000002 
    UART_CR5=  000004     |     UART_CR5=  000005     |     UART_CR6=  000004 
    UART_CR6=  000007     |     UART_CR6=  000001     |     UART_CR6=  000002 
    UART_CR6=  000000     |     UART_CR6=  000005     |     UART_DR =  005241 
    UART_PCK=  000003     |     UART_POR=  005012     |     UART_POR=  005013 
    UART_POR=  005011     |     UART_POR=  005010     |     UART_POR=  00500F 
    UART_RX_=  000006     |     UART_SR =  005240     |     UART_SR_=  000001 
    UART_SR_=  000004     |     UART_SR_=  000002     |     UART_SR_=  000003 
    UART_SR_=  000000     |     UART_SR_=  000005     |     UART_SR_=  000006 
    UART_SR_=  000007     |     UART_TX_=  000005     |     UBC     =  004801 
    US      =  00001F     |   7 UartRxHa   000A09 R   |     VAR_SIZE=  000003 
    VCOM_DES=  0000DB     |     VERT_SCR=  0000A3     |     VSIZE   =  000002 
    VT      =  00000B     |     WANT_TER=  000001     |     WDGOPT  =  004805 
    WDGOPT_I=  000002     |     WDGOPT_L=  000003     |     WDGOPT_W=  000000 
    WDGOPT_W=  000001     |     WWDG_CR =  0050D1     |     WWDG_WR =  0050D2 
    XOFF    =  000013     |     XON     =  000011     |   5 acc16      000010 GR
  5 acc8       000011 GR  |   7 all_disp   000330 R   |   7 beep       000B06 R
  7 bit_mask   0006F5 R   |   7 blink      000222 R   |   7 blink0     00021A R
  7 blink1     00021F R   |   7 buffer_a   000704 R   |   7 cli        00089C R
  7 clock_in   00002F R   |   6 cmd_buff   000100 R   |   7 cold_sta   000125 R
  7 column_d   000836 R   |   7 column_u   00084E R   |   5 count      000059 R
  7 crlf       000742 R   |   5 cur_x      00001E R   |   5 cur_y      00001D R
  7 curpos     000757 R   |   7 cursor_r   00076A R   |   7 debug_pr   000B78 R
  5 delay_ti   00000A R   |   7 delback    0009F6 R   |   2 disp_buf   00137F R
  7 display_   0006C9 R   |   7 display_   0006E1 R   |   7 down_n_l   000884 R
  7 end_of_t   0001CB R   |   7 end_test   000C2F R   |   7 evt_addr   0001A4 R
  7 evt_btf    0001BF R   |   7 evt_rxne   0001D8 R   |   7 evt_sb     00019E R
  7 evt_stop   0001F3 R   |   7 evt_txe    0001AA R   |   7 evt_txe_   0001AF R
  7 exam_blo   000914 R   |   7 fast       00026B R   |   5 flags      000014 GR
  7 font_hex   00036F R   |   7 font_hex   0003BF R   |   6 free_ram   000181 R
  2 free_ram   00137E R   |   7 get_pixe   000734 R   |   7 getline    0009C8 R
  7 hello      000C28 R   |   5 i2c_buf    000015 R   |   5 i2c_coun   000017 R
  5 i2c_devi   00001C R   |   7 i2c_erro   000207 R   |   5 i2c_idx    000019 R
  7 i2c_init   00027C R   |   7 i2c_scl_   000255 R   |   7 i2c_scl_   000277 R
  7 i2c_star   00029B R   |   5 i2c_stat   00001B R   |   7 i2c_writ   00023D R
  7 invert_p   00072A R   |   7 key        0000FA R   |   4 last       000005 R
  7 left_4_p   0007F2 R   |   7 main       000B9D R   |   4 mode       000000 R
  7 modify     0008FA R   |   7 move       000A6A GR  |   7 move_dow   000A89 R
  7 move_exi   000AA8 R   |   7 move_loo   000A8E R   |   7 move_up    000A7B R
  7 new_row    000918 R   |   7 next_cha   0008AF R   |   7 nibble_l   00020F R
  7 noise      000B3F R   |   7 oled_cmd   00034F R   |   2 oled_co    00137E R
  7 oled_dat   000368 R   |   7 oled_fon   00045F R   |   7 oled_fon   0006C9 R
  7 oled_ini   0002B2 GR  |   7 oled_sen   00035B R   |   7 pageleft   0007D2 R
  7 pagerigh   000802 R   |   7 parse01    0008C1 R   |   7 parse_he   00093B R
  7 pause      000AB7 R   |   7 print_ad   000966 R   |   7 print_by   000980 R
  7 print_di   000986 R   |   7 print_me   00096E R   |   7 print_wo   000977 R
  7 prng       0000C3 GR  |   5 ptr16      000012 GR  |   5 ptr8       000013 R
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 92.
Hexadecimal [24-Bits]

Symbol Table

  7 put_byte   0007B5 R   |   7 put_char   000778 R   |   7 put_hex    0007BB R
  7 put_hex_   0007C9 R   |   7 put_stri   0007A0 R   |   7 putchar    0009BF R
  7 reset_pi   000723 R   |   7 right_4_   000826 R   |   7 row        000927 R
  5 rx1_head   00002F R   |   5 rx1_queu   00001F R   |   5 rx1_tail   000030 R
  7 scale      000B0F R   |   5 seedx      00000C R   |   5 seedy      00000E R
  7 set_int_   000062 GR  |   7 set_pixe   00071D R   |   7 set_seed   0000E5 R
  7 sll_xy_3   0000B5 R   |   7 sound_pa   000AC4 R   |   5 sound_ti   00000B R
  7 space      000972 R   |   7 srl_xy_3   0000BC R   |   2 stack_fu   00177F R
  2 stack_un   0017FF R   |   7 std        00025D R   |   4 storadr    000003 R
  7 strlen     000AAC GR  |   7 test1      000BAD R   |   7 test2      000BCD R
  7 test3      000BF1 R   |   7 test4      000C02 R   |   7 test5      000C17 R
  5 tib        000031 R   |   5 ticks      000008 R   |   7 timer2_i   00004D R
  7 timer4_i   000034 R   |   7 tone       000ADD R   |   7 uart_get   00099A GR
  7 uart_ini   000A3A R   |   7 uart_qge   000994 R   |   7 up_n_lin   000890 R
  7 vertical   000868 R   |   7 wait_key   000100 R   |   4 xamadr     000001 R
  7 xor_seed   000099 R

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (STMicroelectronics STM8), page 93.
Hexadecimal [24-Bits]

Area Table

   0 _CODE      size      0   flags    0
   1 SSEG       size      0   flags    8
   2 SSEG0      size    481   flags    8
   3 HOME       size     80   flags    0
   4 DATA       size      7   flags    8
   5 DATA1      size     52   flags    8
   6 DATA2      size     81   flags    8
   7 CODE       size    C2F   flags    0

