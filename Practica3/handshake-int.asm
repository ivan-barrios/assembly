PIC EQU 20H
HAND EQU 40H
N_HND EQU 10

ORG 40
    IP_HND DW RUT_HND

ORG 1000H
    MSJ DB "UNIVERSIDAD "
    DB "NACIONAL DE LA PLATA"
    FIN DB ?

ORG 3000H
    RUT_HND: PUSH AX
    MOV AL, [BX]
    OUT HAND, AL
    INC BX
    DEC CL
    MOV AL, 20H
    OUT PIC, AL
    POP AX
    IRET

ORG 2000H
    MOV BX, OFFSET MSJ
    MOV CL, OFFSET FIN-OFFSET MSJ

    CLI
    MOV AL, 0FBH
    OUT PIC+1, AL ; IMR para HANDSHAKE
    MOV AL, N_HND
    OUT PIC+6, AL ; Configuro INT2 para RUT_HND (40 = 10*4)
    MOV AL, 80H
    OUT HAND+1, AL ; Bit mas significativo en 1 --> Por interrupcion
    STI

    LAZO: CMP CL, 0
    JNZ LAZO
    
    IN AL, HAND+1
    AND AL, 7FH
    OUT HAND+1, AL ; Bit mas significativo en 0 --> Por polling
    INT 0
    END

