PIC EQU 20H
EOI EQU 20H
TIMER EQU 10H
N_F10 EQU 9
N_CLK EQU 10

ORG 36
IP_F10 DW RUT_F10
ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
NUM DB ?
FIN DB ?

ORG 3000H
RUT_F10: PUSH AX           ;Debe prender el timer   
MOV AL, 0FDH               ;Deja solo activo el timer
OUT PIC+1, AL
MOV AL, EOI
OUT EOI, AL
POP AX
IRET

RUT_CLK: PUSH AX
INT 7
DEC NUM
MOV AL, 0
OUT TIMER, AL
CMP NUM, 30H
JNZ SEGUIR
MOV AL, 0FFH
OUT PIC+1, AL
SEGUIR: MOV AL, EOI
OUT EOI, AL
POP AX
IRET


ORG 2000H
CLI
MOV BX, OFFSET NUM
INT 6                      ;Leo numero

MOV AL, 0FEH
OUT PIC+1, AL              ;PIC: registro IMR (F10 habilitado)
MOV AL, N_F10
OUT PIC+4, AL              ;PIC: registro INT0 (Direc de gestor)
MOV AL, N_CLK
OUT PIC+5, AL              ;PIC: registro INT1 (Direc de gestor)
MOV AL, 1
OUT TIMER+1, AL            ;TIMER: registro COMP
MOV AL, 0
OUT TIMER, AL              ;TIMER: registro CONT
MOV BX, OFFSET NUM
MOV AL, 1
STI
LAZO: CMP NUM, 30H
JNZ LAZO

INT 0
END
