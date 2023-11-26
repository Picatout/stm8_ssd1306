
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
    ld a,#SMALL  
    call select_font 
    ldw y,#prompt 
    call put_string 
    ld a,#BIG 
    call select_font 
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
    ld a,#2 
    _straz line
    ld a,#2 
    _straz col  
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
    ld a,#3 
    _straz line
    ld a,#2 
    _straz col  
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

prompt: .asciz "demo MCP9701 sensor\nroom temperature"
celcius: .byte DEGREE,'C',0  
fahrenheit: .byte DEGREE,'F',0 
