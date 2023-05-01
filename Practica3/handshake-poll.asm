HAND EQU 40H
ORG 1000H
MSJ DB "INGENIERIA E "
DB "INFORMATICA"
FIN DB ?
ORG 2000H
IN AL, HAND+1 
AND AL, 7FH
OUT HAND+1, AL ; Pongo en 0 el bit mas significativo -> Por POLLING
MOV BX, OFFSET MSJ
MOV CL, OFFSET FIN-OFFSET MSJ
POLL: IN AL, HAND+1
AND AL, 1
JNZ POLL ; Hasta que este desocupado, hago POLLING
MOV AL, [BX]
OUT HAND, AL ; En DATOS pongo el caracter
INC BX
DEC CL
JNZ POLL ; Hago esto hasta que se terminen los caracteres
INT 0
END