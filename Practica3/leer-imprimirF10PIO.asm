PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H
PIC EQU 20H
EOI EQU 20H
N_F10 EQU 9

ORG 36
    IP_F10 DW RUT_F10

ORG 1000H
    CAR DB ?

ORG 3000H
    RUT_F10: PUSH AX

    IN AL, PA
    OR AL, 2
    OUT PA, AL ; Pongo STROBE en 1 para que sepa que puse un dato
    IN AL, PA
    AND AL, 0FDH
    OUT PA, AL ; Pongo STROBE en 0 para poder avisar sobre el proximo
    MOV CL, 0
    MOV AL, EOI
    OUT EOI, AL
    POP AX
    IRET

ORG 4000H
    INI_IMP: PUSH AX
    MOV AL, 0FDH
    OUT CA, AL ; BUSY de entrada y STROBE de salida (CA)
    MOV AL, 0
    OUT CB, AL ; DATOS de salida (CB)
    IN AL, PA
    AND AL, 0FDH
    OUT PA, AL ; STROBE en 0 (Para avisar, STROBE tiene que estar en 1)
    POP AX
    RET

ORG 2000H
    CLI
    MOV AL, 0FEH
    OUT PIC+1, AL ; Habilito INT de F10
    MOV AL, 9
    OUT PIC+4, AL ; Mando 9 a INT0 --> Direc 36 (Tiene direc de Gestor)
    STI
    CALL INI_IMP ; Inicializo para Impresora
    MOV BX, OFFSET CAR
    LAZO: INT 6 ; Leer caracter
    POLL: IN AL, PA
    AND AL, 1
    JNZ POLL ; Hago POLL hasta que este desocupada la impresora
    MOV AL, [BX]
    OUT PB, AL ; En DATOS pongo el caracter
    MOV CL, 1 ; En CL voy a tener 1 si todavia no se interrumpio con F10, 0 en caso contrario
    LAZOINTERNO: CMP CL, 0
    JNZ LAZOINTERNO ; Hasta que se aprete F10, no se leerá otro caracter
    JMP LAZO
    INT 0
END
