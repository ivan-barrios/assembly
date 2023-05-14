.data
A: .word 1
B: .word 6
TABLE: .word 1

.code
ld r1, A(r0)
ld r2, B(r0)
dadd r3 ,r3, r3 ;Es lo que se va a sumar para el modo de almacenamiento (en TABLE + r3)
sd r1, TABLE(r3) ;Guardo el elemento inicializado.

loop: daddi r3, r3, 8 ; se avanza de a 8 porque son 8 bytes (word)?
daddi r2, r2, -1
dsll r1, r1, 1
sd r1, TABLE(r3)
bnez r2, loop
halt
