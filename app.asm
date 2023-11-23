
; fake application 

app:
    call beep 
    call oled_init 
    call display_clear 
    ldw y,#hello 
    call put_string 
    jra .

hello: .asciz "HELLO WORLD!"

