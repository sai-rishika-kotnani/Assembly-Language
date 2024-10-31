
org 100h

.data
    num1 db 025h            ; First 8-bit number
    num2 db 027h             ; Second 8-bit number
    msg db 'Result: $'      ; Message to print before the result
    ovf db 'ARITHMETIC OVERFLOW! $'    ; overflow message

.code
    ; Initialize data segment
    mov ax, @data
    mov ds, ax   
    
    ;Print Message
    lea dx, msg
    mov ah, 09
    int 21h
    
    xor ax,ax        ; clear ax
    
    ; Load numbers into registers
    mov al, num1     ; Load first number into AL
    add al, num2     ; Add second number (AL = AL + num2)
    daa
    jno noverflow      ; jump to noverflow label if there is an overflow

    ;print overflow message
    lea dx, ovf
    mov ah, 09h
    int 21h
    jmp exit
    
    noverflow:
        ;split the result into two digits by dividing it with 10h                
        ;quotient in al (10s digit) and reminder in ah (1s digit)                    
        mov bl, 010h     
        div bl           ; divide al with 10h 
                         
        
        mov bx, ax       ; save the result in bx
        
        add bl, '0'      ; Convert to ASCII ('0' = 48 in decimal)
        cmp bl, '9'
        jle print_digit10s
        add bl, 7 
                     
        print_digit10s:    
            ; Print 10's digit
            mov dl, bl
            mov ah, 02h        ; DOS function to print character
            int 21h            ; DOS interrupt
        
        add bh, '0'
        cmp bh, '9'
        jle print_digit1s
        add bh, 7
        
        print_digit1s:    
            ; Print 1's digit
            mov dl, bh
            mov ah, 02h        ; DOS function to print character
            int 21h            ; DOS interrupt
           
    exit:
    ; Exit program
    mov ah, 4Ch        ; DOS function to exit
    int 21h            ; DOS interrupt

ret




