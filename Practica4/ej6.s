.data
A: .word 3
B: .word 2
C: .word 4
D: .word 0

.code
;Traigo valores
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
dadd r4, r0, r0 ;Resultado

xor r5, r1, r2
bnez r5, no1
daddi r4, r4, 2

no1: xor r5, r1, r3
bnez r5, no2
bnez r4, inc1
daddi r4, r4, 2
j no2
inc1: daddi r4, r4, 1

daddi r6, r0, 3
beq r4, r6, no3 ;Si ya tiene 3, termina pq son todos iguales

no2: xor r5, r2, r3
bnez r5, no3
bnez r4, inc2
daddi r4, r4, 2
j no3
inc2: daddi r4, r4, 1

no3: sd r4, D(r0)

halt
