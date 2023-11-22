;;
; Copyright Jacques Deschênes 2019 
; This file is part of MONA 
;
;     MONA is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     MONA is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with MONA.  If not, see <http://www.gnu.org/licenses/>.
;;

;-------------------------------------------------------
;     ASCII control  values
;     CTRL_x   are VT100 keyboard values  
; REF: https://en.wikipedia.org/wiki/ASCII    
;-------------------------------------------------------
		CTRL_A = 1
		SOH=CTRL_A  ; start of heading 
		CTRL_B = 2
		STX=CTRL_B  ; start of text 
		CTRL_C = 3
		ETX=CTRL_C  ; end of text 
		CTRL_D = 4
		EOT=CTRL_D  ; end of transmission 
		CTRL_E = 5
		ENQ=CTRL_E  ; enquery 
		CTRL_F = 6
		ACK=CTRL_F  ; acknowledge
		CTRL_G = 7
        BELL = 7    ; vt100 terminal generate a sound.
		CTRL_H = 8  
		BS = 8     ; back space 
        CTRL_I = 9
    	TAB = 9     ; horizontal tabulation
        CTRL_J = 10 
		LF = 10     ; line feed
		CTRL_K = 11
        VT = 11     ; vertical tabulation 
		CTRL_L = 12
        FF = 12      ; new page
		CTRL_M = 13
		CR = 13      ; carriage return 
		CTRL_N = 14
		SO=CTRL_N    ; shift out 
		CTRL_O = 15
		SI=CTRL_O    ; shift in 
		CTRL_P = 16
		DLE=CTRL_P   ; data link escape 
		CTRL_Q = 17
		DC1=CTRL_Q   ; device control 1 
		XON=DC1 
		CTRL_R = 18
		DC2=CTRL_R   ; device control 2 
		CTRL_S = 19
		DC3=CTRL_S   ; device control 3
		XOFF=DC3 
		CTRL_T = 20
		DC4=CTRL_T   ; device control 4 
		CTRL_U = 21
		NAK=CTRL_U   ; negative acknowledge
		CTRL_V = 22
		SYN=CTRL_V   ; synchronous idle 
		CTRL_W = 23
		ETB=CTRL_W   ; end of transmission block
		CTRL_X = 24
		CAN=CTRL_X   ; cancel 
		CTRL_Y = 25
		EM=CTRL_Y    ; end of medium
		CTRL_Z = 26
		SUB=CTRL_Z   ; substitute 
		EOF=SUB      ; end of text file in MSDOS 
		ESC = 27     ; escape 
		FS=28        ; file separator 
		GS=29        ; group separator 
		RS=30		 ; record separator 
		US=31 		 ; unit separator 
		SPACE = 32
		COMMA = 44
		COLON = 58 
		SEMIC = 59  
		SHARP = 35
		TICK = 39
