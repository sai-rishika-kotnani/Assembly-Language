
org 100h

.DATA
    NUM1 DB 5       ; First 8-bit number
    NUM2 DB 6       ; Second 8-bit number
    RESULT DW ?     ; 16-bit result (since multiplication of two 8-bit numbers can give 16-bit result)

.CODE
START:
    MOV AX, @DATA   ; Initialize data segment
    MOV DS, AX

    ; Load the first number into AL
    MOV AL, NUM1

    ; Multiply AL by the second number
    ; The result will be stored in AX (AL will hold the lower byte, AH will hold the higher byte)
    MOV BL, NUM2    ; Load the second number into BL
    MUL BL          ; Multiply AL by BL (AX = AL * BL)

    ; Store the result in RESULT
    MOV RESULT, AX  ; Store 16-bit result
    
    CALL PRINT_HEX   ; Call the procedure to print AX in hex 
    


    ; Exit program
    MOV AH, 4CH     ; DOS interrupt to exit program
    INT 21H         ; DOS interrupt
    
; Procedure to print the 16-bit value in AX in hexadecimal
PRINT_HEX PROC

    ; Convert and print the high byte (AH)
    MOV CX, 4        ; Loop counter (for 4 hex digits)
    MOV BX, AX       ; Copy AX to BX

PRINT_DIGIT:
    MOV DX, BX
    AND DH, 0F0H     ; Mask upper nibble
    SHR DH, 4
    ADD DH, 30H      ; Convert to ASCII (0-9)
    CMP DH, 39H      ; Check if the digit is greater than 9
    JBE PRINT_CHAR   ; If it's <= 9, print it
    ADD DH, 7        ; Else, convert to 'A'-'F'
PRINT_CHAR:
    MOV DL, DH       ; Move ASCII character to DL
    MOV AH, 02H      ; DOS interrupt to print a single character
    INT 21H
    SHL BX, 4
    LOOP PRINT_DIGIT ; Repeat for the next 
    
    RET
PRINT_HEX ENDP

END START

ret       






