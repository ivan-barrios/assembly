PIC EQU 20H
TIMER EQU 10H
PIO EQU 30H
N_CLK EQU 10

ORG 40
    IP_CLK DW RUT_CLK

ORG 1000H
    INICIO DB 0

ORG 2000H
    CLI
    MOV AL, 0FDH
    OUT PIC+1, AL      ;IMR = 1111 1101
    MOV AL, N_CLK
    OUT PIC+5, AL      ;INT 1 = 10  --> Se multiplica por 4 y se va a esa direccion(Que tiene la direc del gestor)
    MOV AL, 1
    OUT TIMER+1, AL    ;COMP = 1
    MOV AL, 0
    OUT TIMER, AL      ;CONT = 0
    OUT PIO+3, AL      ;CB = 0000 0000  (PB Salidas) -> Luces
    OUT PIO+1, AL      ;CA = 0000 0000  (PA Salidas(Apagado)) -> Microconmutadores
    STI
    LAZO: JMP LAZO


ORG 3000H
    RUT_CLK: INC INICIO
    CMP INICIO, 0FFH
    JNZ LUCES
    MOV INICIO, 0

    LUCES: MOV AL, INICIO
    OUT PIO+1, AL              ;Incrementa (Pone PA respecto al contador (INICIO))
    MOV AL, 0
    OUT TIMER, AL              ;Resetea CONT
    MOV AL, 20H
    OUT PIC, AL                ;Termine de gestionar interrupcion

    IRET
    END
