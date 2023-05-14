.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10

.code
ld r1, long(r0) ; r1 tiene 10 (Cantidad de elementos)
ld r2, num(r0) ; r2 tiene 7
dadd r3, r0, r0 ;r3 se encarga del index de la tabla
dadd r10, r0, r0
loop: ld r4, tabla(r3)
beq r4, r2, listo ; si r4 es igual a r2(7) termina
daddi r1, r1, -1 ; restante cantidad de elementos
daddi r3, r3, 8 ; r3 para obtener el siguiente en la tabla
bnez r1, loop ; si no se quedo sin elementos, sigue
j fin ; si no se salta nunca a listo, entonces termino sin realizar la instruccion de la linea 17
listo: daddi r10, r0, 1 ; si se encuentra el 7, se guarda 1 en r10
fin: halt

;a) Este programa busca en la tabla el numero 7, si se encuentra, entonces r10 = 1, sino r10 = 0

;b) El metodo de Branch target buffer lo que hace es intentar predecir el salto, por lo que pasó la ultima vez en ese salto.
; por lo que no falla cada vez que quiere saltar. Esto nos ahorra CPI ya que hay mas veces que se ejecuta el salto de las que no.
; Por lo que predice bien la mayor parte de las veces (Siempre hay por lo menos un Cycle perdido).


;c)          Con BTB      ||      Sin BTB
        ______________________________________
       |                 ||                   |
Cycles |      67         ||        71         |
       |                 ||                   |
CPI    |      1.6        ||        1.65       |
       |                 ||                   |
RAWs   |      16         ||        16         |
       |                 ||                   |
BTS    |      4          ||        8          |
       ________________________________________















