PIC EQU 20H
EOI EQU 20H
TIMER EQU 10H
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H
N_CLK EQU 10

ORG 40
    IP_CLK DW RUT_CLK

ORG 1000H
    LUZ DB 1

ORG 3000H
    RUT_CLK: PUSH AX

    PRENDER: MOV AL, LUZ
    CMP DL, 0                ;Si DL = 0, desplazo a izq, sino a derecha
    JNZ DESPLAZARDER
    ADD AL, AL               ;DESPLAZO BIT A IZQ
    CMP AL, 80H
    JNZ FALTA1
    MOV DL, 1                ;INDICO QUE LLEGO A EL SEPTIMO BIT
    FALTA1: MOV LUZ, AL
    JMP MOSTRAR

    DESPLAZARDER: MOV CL, 7 
    SEGUIRDD: ADD AL, AL
    JNC NOCARRY
    INC AL
    NOCARRY: DEC CL
    JNZ SEGUIRDD         ;DESPLAZO BIT A DERECHA
    CMP AL, 1
    JNZ FALTA2
    MOV DL, 0                ;INDICO QUE LLEGO AL BIT 0
    FALTA2: MOV LUZ, AL

    MOSTRAR: MOV AL, LUZ
    OUT PB, AL
    MOV AL, 0
    OUT TIMER, AL            ;Reinicio CONT
    MOV AL, EOI
    OUT EOI, AL
    POP AX
    IRET

ORG 2000H
    CLI
    MOV AL, 0FDH
    OUT PIC+1, AL    ;Permito nada mas en el IMR a TIMER

    MOV AL, N_CLK
    OUT PIC+5, AL    ;INT1 = 10 --> DIREC 40 (10 * 4)

    MOV AL, 1
    OUT TIMER+1, AL  ;COMP EN 1
    OUT PB, AL       ;Primera luz encendida

    MOV AL, 0FFH
    OUT CA, AL       ;PA como ENTRADA (Microconmutadores)

    MOV AL, 0
    OUT CB, AL       ;PB como Salida (Luces)
    OUT TIMER, AL    ;CONT EN 0
    STI
    MOV DL, 0
    LOOP: JMP LOOP

    INT 0
    END
