ORG 1000H
MSJ DB "Ingrese un numero : "
FIN DB ?
POSITIVE DB "+"
NEGATIVE DB "-"
RESULT DB ?

ORG 1500H
NUM DB ?

ORG 2000H

MOV AL, OFFSET FIN-OFFSET MSJ   ;Ingrese un numero : 
MOV BX, OFFSET MSJ
INT 7

MOV BX, NUM
INT 6            ;Lee en NUM el numero1
MOV DH, [BX]     ;DH = NUM1

MOV BX, OFFSET MSJ
INT 7

MOV BX, NUM
INT 6            ;Sobreescribe en NUM el numero2 para ocupar menos espacio
MOV DL, [BX]     ;DL = NUM2

CMP DH, DL
JNS ISPOSITIVE


SUB DL, DH
ADD DL, 30H
MOV RESULT, DL    ;Guardo mi resultado
MOV BX, OFFSET NEGATIVE
MOV AL, 1
INT 7
MOV BX, OFFSET RESULT
INT 7
JMP TERMINA

ISPOSITIVE: SUB DH, DL
ADD DH, 30H
MOV RESULT, DH
MOV BX, OFFSET POSITIVE
MOV AL, 1
INT 7
MOV BX, OFFSET RESULT
INT 7

TERMINA: INT 0
END
