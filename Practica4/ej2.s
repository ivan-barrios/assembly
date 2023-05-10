.data
A: .word 1
B: .word 2
.code
ld r1, A(r0)
ld r2, B(r0)
sd r2, A(r0)
sd r1, B(r0)      
halt

;a) ;Aca tiene que esperar 2 ciclos para poder ejecutarse (Genera stall) [Sin Forwarding]
;      porque quiere guardar algo que todavia no se leyo.
; Es un RAW
; Es 11 cycles / 5 instrucciones = 2.2 CPI

;b) El forwarding hace que no se produzcan atascos porque en la etapa execute de ambos loads, se guarda
;      el valor de cada instruccion en un buffer y se lo pasa a la etapa de memoria de la instruccion por
;      lo que pueden acceder las demas instrucciones sin tener que ir a buscar lo que todavia no se escribio.
; El color verde en los registros significa que se hizo el WB (Write back) de los loads.
; Es 9 cycles / 5 instrucciones = 1.8 CPI
