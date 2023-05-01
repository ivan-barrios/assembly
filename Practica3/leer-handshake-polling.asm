HAND EQU 40H

ORG 1000H
    CANT_CAR DB 5
    CAR DB ?

ORG 3000H
POLL: IN AL, HAND+1
    AND AL, 1
    JNZ POLL
    RET


ORG 2000H
IN AL, HAND+1
AND AL, 7FH
OUT HAND+1, AL ; Configuro para hacer por POLLING

MOV BX, OFFSET CAR
MOV CL, CANT_CAR

;Leo Caracteres y los mando a memoria
READLOOP: INT 6
    INC BX
    DEC CL
    JNZ READLOOP

MOV BX, OFFSET CAR
IMPRIMIR1: PUSH BX
    PUSH AX
    CALL POLL
    POP AX
    POP BX
    ;Si llega a este punto, es porque no esta mas BUSY
    MOV AL, [BX]
    OUT HAND, AL ; Manda al buffer
    INC BX
    INC CL
    CMP CL, 5H
    JNZ IMPRIMIR1

DEC BX ; Para tener el ultimo caracter (En el loop me paso 1)

IMPRIMIR2: PUSH BX
    PUSH AX
    CALL POLL
    POP AX
    POP BX
    ;Si llega a este punto, esta libre
    MOV AL, [BX]
    OUT HAND, AL
    DEC BX
    DEC CL
    JNZ IMPRIMIR2

PUSH BX
PUSH AX
CALL POLL
POP AX
POP BX

INT 0
END
