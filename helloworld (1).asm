

.DATA                    ; Start of the data segment
    msg DB 'Hello, World!$'   ; Define the message to be printed

.CODE                    ; Start of the code segment
MAIN PROC
    MOV AX, @DATA        ; Initialize data segment
    MOV DS, AX

    MOV AH, 09H          ; DOS function to display a string
    LEA DX, msg          ; Load address of the message into DX
    INT 21H              ; Call DOS interrupt to print the string

    MOV AH, 4CH          ; DOS function to terminate program
    INT 21H              ; Call DOS interrupt to terminate

MAIN ENDP
END MAIN                 ; End of the program



