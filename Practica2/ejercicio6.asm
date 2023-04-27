ORG 1000H
CERO DB "Cero  "      ;6 caracteres cada numero
UNO DB "Uno   "    
DOS DB "Dos   "
TRES DB "Tres  "
CUATRO DB "Cuatro"
CINCO DB "Cinco "
SEIS DB "Seis  "
SIETE DB "Siete "
OCHO DB "Ocho  "
NUEVE DB "Nueve "

ORG 1500H
NUM DB ?

ORG 2000H
MOV AL, 6          ;Por los 6 caracteres de cada numero
MOV AH, 0          ;Contador de ceros consecutivos (Si es 2, cortamos)

INGRESAR: MOV BX, OFFSET NUM
INT 6                             ;Leo y se guarda en la direccion de NUM
MOV CL, [BX]
CMP CL, 30H
JNZ SEGUIR                        ;Si es 0, me fijo si tengo que cortar o no

INC AH
CMP AH, 2
JNZ SEGUIR                        ;Va para imprimir el "Cero"
JMP FIN

SEGUIR: CMP CL, 30H
JZ PROCESAR
MOV AH, 0                        ;Se reinicia contador de ceros

PROCESAR: MOV BX, OFFSET CERO               ;Arranco por la 1000H

WHILE: CMP CL, 30H
JZ IMPRIME
DEC CL
ADD BX, 6
JMP WHILE

IMPRIME: INT 7
JMP INGRESAR

FIN: INT 0
END
