PIO EQU 30H

ORG 1000H
    NUM_CAR DB 5
    CAR DB ?

;SUBRUTINA DE INICIALIZACION
;PIO PARA IMPRESORA
ORG 3000H
    INI_IMP: MOV AL, 0FDH
    OUT PIO+2, AL ; BUSY de salida y STROBE de entrada (CA)
    MOV AL, 0
    OUT PIO+3, AL ; DATOS de salida (CB)
    IN AL, PIO
    AND AL, 0FDH
    OUT PIO, AL ; STROBE en 0
    RET

;SUBRUTINA DE GENERACION
;DE PULSO 'STROBE'
ORG 4000H
    PULSO: IN AL, PIO
    OR AL, 02H
    OUT PIO, AL ; Pongo STROBE en 1 (Pulso de STROBE para que reciba caracter)
    IN AL, PIO
    AND AL, 0FDH
    OUT PIO, AL ; Pongo STROBE en 0 (Reseteo para siguiente caracter)
    RET

;PROGRAMA PRINCIPAL
ORG 2000H
    PUSH AX ; Salvo registros
    CALL INI_IMP ; INICIALIZO
    POP AX ; Vuelvo a tener registros
    MOV BX, OFFSET CAR
    MOV CL, NUM_CAR
    LAZO: INT 6 ; Leo en CAR
    POLL: IN AL, PIO
    AND AL, 1 ; Me fijo si esta BUSY (1) o no (0)
    JNZ POLL ; Cuando se libere, sigo
    MOV AL, [BX]
    OUT PIO+1, AL ; En PB (DATOS) mando el caracter
    PUSH AX
    CALL PULSO ; PULSO 'STROBE' para avisar que mande caracter
    POP AX
    DEC CL
    JNZ LAZO ; Hasta que no termine con los caracteres, hace lo mismo
    INT 0
    END
