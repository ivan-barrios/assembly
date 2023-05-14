.data 
A: .word 2
X: .word 5
Y: .word 5
resultado: .word 0

.code
ld r1, X(r0)
ld r2, Y(r0)
ld r3, A(r0)

loop: beqz r3, fin
daddi r3, r3, -1
j loop
dadd r1, r1, r2 ;Esta despues del jump por el delay slot (Para aprovechar el ciclo)

fin: sd r1, resultado(r0)

halt