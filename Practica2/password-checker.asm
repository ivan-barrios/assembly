ORG 1000H
MSJ1 DB "Ingresar clave : "
MSJ2 DB "Acceso Permitido"
MSJ3 DB "Acceso Denegado"
CLAVE DB "TIBU"

ORG 1500H
INPUT DB ?

ORG 2000H
MOV BX, OFFSET MSJ1
MOV AL, OFFSET MSJ2- OFFSET MSJ1
INT 7                                ;Ingresar Clave :

MOV AH, 4
MOV BX, OFFSET INPUT
LEER: INT 6
INC BX
DEC AH
JNZ LEER                             ;Se ingresa la clave

MOV AH, 3
VERIFY: MOV BX, OFFSET CLAVE
ADD BL, AH
MOV DH, [BX]                         ;DH clave

MOV BX, OFFSET INPUT
ADD BL, AH
MOV DL, [BX]                         ;DL input

CMP DH, DL
JNZ DENEGADO
DEC AH
JNS VERIFY                           ;Mientras no se terminen los 4 digitos, se sigue

MOV BX, OFFSET MSJ2
MOV AL, OFFSET MSJ3-OFFSET MSJ2
INT 7                                ;Imprime Acceso permitido
JMP FIN

DENEGADO: MOV BX, OFFSET MSJ3
MOV AL, OFFSET CLAVE-OFFSET MSJ3
INT 7

FIN: INT 0
END
