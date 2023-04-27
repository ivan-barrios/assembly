ORG 1000H
MSJ DB "Ingrese numero :"
FIN DB ?
UNO DB "1"

ORG 1500H
NUM1 DB ?
NUM2 DB ?
RESULT DB ?

ORG 2000H

MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
INT 7                  ;Ingresar Numero:

MOV BX, OFFSET NUM1
INT 6                  ;Leo en NUM1
MOV DH, NUM1           ;Lo guardo en DH
SUB DH, 30H            ;Para poder ver el numero decimal

MOV BX, OFFSET MSJ    ;Ingresar otro numero:
INT 7

MOV BX, OFFSET NUM2
INT 6                  ;Leo en NUM2
MOV DL, NUM2           ;Lo guardo en DL
SUB DL, 30H            ;Para poder ver el numero decimal

ADD DH, DL             ;Suma hecha en DH
ADD DH, 30H            ;Pra ver el numero decimal

CMP DH, 0AH            ;Me fijo si tiene dos digitos
JS TERMINA
MOV BX, OFFSET UNO
MOV AL, 1
INT 7
SUB DH, 0AH            ;Obtengo la unidad

MOV RESULT, DH         ;Se guarda la suma en RESULT

TERMINA: MOV BX, OFFSET RESULT
MOV AL, 1
INT 7

INT 0
END
