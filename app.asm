
;-------------------------
; temperature sensor demo 
; using MCP9701-E/TO 
;-------------------------
ZERO_OFS=400 ; Vout offset at 0 degr.  400mV 
SLOPE10=195 ; 10x19.5mv/degr. C sensor slope   
VREF10=33 ; ADC Vref*10 

    XSAVE=1
    REPCNT=3
    VAR_SIZE=3
app:
    _vars VAR_SIZE 
    call beep 
    call oled_init 
    call display_clear 
    ldw y,#prompt 
    call put_string 
    bset ADC2_CR2,#ADC2_CR2_ALIGN 
    bset ADC2_CR1,#ADC2_CR1_ADON 
    ld a,#10 ; ADC wake up delay  
    call pause 
1$: ; start conversion 
    bset ADC2_CR1,#ADC2_CR1_ADON 
    btjf ADC2_CSR,#ADC2_CSR_EOC,. 
    bres ADC2_CSR,#ADC2_CSR_EOC
    ld a,#3
    ld (REPCNT,sp),a 
    ld a,ADC2_DRL
    ld xl,a 
    ld a,ADC2_DRH 
    ld xh,a 
    ld a,#VREF10 ; 3.3*10 ref. voltage 
    call mul16x8
    ldw y,#1024 
    divw x,y
2$:
    ld a,#10
    call mul16x8  
    ldw (XSAVE,sp),x
    dec (REPCNT,sp)
    jreq 4$    
    ldw x,y
    ld a,#10 
    call mul16x8  
    ldw y,#1024 
    divw x,y
    addw x,(XSAVE,sp)
    jra 2$ 
4$:  
    ldw x,(XSAVE,sp)
    subw x,#ZERO_OFS*10      
    ld a,#SLOPE10 
    div x,a
    sllw y 
    cpw y,#SLOPE10 
    jrmi 5$
    incw x
5$:
    pushw x  
    call itoa
    ld a,#4 
    call set_line 
    call put_string 
    ldw y,#celcius 
    call put_string 
    popw x 
    ld a,#9
    mul x,a 
    ld a,#5 
    div x,a 
    addw x,#32
    call itoa 
    ld a,#6 
    call set_line 
    call put_string 
    ldw y,#fahrenheit
    call put_string 
    ld a,#50 
    call pause 
    jp 1$  


;------------------------
; input:
;    x   
;    a 
; output:
;    X   X*A 
;------------------------
mul16x8:
    _strxz acc16 
    mul x,a 
    pushw x 
    _ldxz acc16 
    swapw x 
    mul x,a 
    clr a 
    rlwa x 
    addw x,(1,sp)
    _drop 2 
    ret 

;-----------------------
; convert integer to 
; ASCII string 
; input:
;   X    integer 
;------------------------
    SIGN=1
itoa:
    push #0 
    tnzw x 
    jrpl 1$ 
    cpl (SIGN,SP)
    negw x 
1$: ldw y,#free_ram+8
    clr(y)
2$:
    decw y 
    ld a,#10 
    div x,a 
    add a,#'0 
    ld (y),a 
    tnzw x 
    jrne 2$
    tnz (SIGN,sp)
    jrpl 4$
    decw y 
    ld a,#'-
    ld (y),a 
4$: _drop 1 
    ret 

prompt: .asciz "demo MCP9701 sensor\nroom temperature"
celcius: .byte DEGREE,'C',0  
fahrenheit: .byte DEGREE,'F',0 
