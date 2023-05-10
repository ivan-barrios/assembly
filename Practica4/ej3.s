.data
A: .word 1
B: .word 6
.code
ld r1, A(r0)
ld r2, B(r0)
loop: dsll r1, r1, 1 ; el dsll desplaza a la izquierda el contenido de r1
daddi r2, r2, -1
bnez r2, loop ; el bnez salta a la etiqueta loop si r2 es distinto de cero
halt

;este programa desplaza a la izquierda el contenido de r1 tantas veces como indique el contenido de r2
