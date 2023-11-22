;;
; Copyright Jacques Deschênes 2019 
; This file is part of STM8_NUCLEO 
;
;     STM8_NUCLEO is free software: you can redistribute it and/or modify
;     it under the terms of the GNU General Public License as published by
;     the Free Software Foundation, either version 3 of the License, or
;     (at your option) any later version.
;
;     STM8_NUCLEO is distributed in the hope that it will be useful,
;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;     GNU General Public License for more details.
;
;     You should have received a copy of the GNU General Public License
;     along with STM8_NUCLEO.  If not, see <http://www.gnu.org/licenses/>.
;;
;--------------------------------------
;   console Input/Output module
;   DATE: 2019-12-11
;    
;   General usage macros.   
;
;--------------------------------------

    ; microseconds delay 
    .macro usec n, ?loop 
        ldw x,#4*n 
    loop:
        decw x 
        nop 
        jrne loop
    .endm 

    ; reserve space on stack
    ; for local variables
    .macro _vars n 
    sub sp,#n 
    .endm 
    
    ; free space on stack
    .macro _drop n 
    addw sp,#n 
    .endm

    ; declare ARG_OFS for arguments 
    ; displacement on stack. This 
    ; value depend on local variables 
    ; size.
    .macro _argofs n 
    ARG_OFS=2+n 
    .endm 

    ; declare a function argument 
    ; position relative to stack pointer 
    ; _argofs must be called before it.
    .macro _arg name ofs 
    name=ARG_OFS+ofs 
    .endm 

    ; increment zero page variable 
    .macro _incz v 
    .byte 0x3c, v 
    .endm 

    ; decrement zero page variable 
    .macro _decz v 
    .byte 0x3a,v 
    .endm 

    ; clear zero page variable 
    .macro _clrz v 
    .byte 0x3f, v 
    .endm 

    ; load A zero page variable 
    .macro _ldaz v 
    .byte 0xb6,v 
    .endm 

    ; store A zero page variable 
    .macro _straz v 
    .byte 0xb7,v 
    .endm 

    ; load x from variable in zero page 
    .macro _ldxz v 
    .byte 0xbe,v 
    .endm 

    ; load y from variable in zero page 
    .macro _ldyz v 
    .byte 0x90,0xbe,v 
    .endm 

    ; store x in zero page variable 
    .macro _strxz v 
    .byte 0xbf,v 
    .endm 

    ; store y in zero page variable 
    .macro _stryz v 
    .byte 0x90,0xbf,v 
    .endm 

    ;  increment 16 bits variable
    ;  use 10 bytes  
    .macro _incwz  v 
        _incz v+1   ; 1 cy, 2 bytes 
        jrne .+4  ; 1|2 cy, 2 bytes 
        _incz v     ; 1 cy, 2 bytes  
    .endm ; 3 cy 

    ; xor op with zero page variable 
    .macro _xorz v 
    .byte 0xb8,v 
    .endm 
    
    ; mov memory to memory page 0 
    .macro _movz m1,m2 
    .byte 0x45,m2,m1 
    .endm 
    
    ; software reset 
    .macro _swreset
    mov WWDG_CR,#0X80
    .endm 


