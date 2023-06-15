.data
cant1: .word 5
tabla1: .double 2.55, 6.8, 98.2, 43.5, 44.7
tabla2: .double 0.0
.code
ld $t0, cant1($0) ; Cant elementos
daddi $t1, $0, tabla1 ; direc tabla 1
daddi $t2, $0, tabla2

loop: l.d f1, 0($t1)
s.d f1, 0($t2)
daddi $t0, $t0, -1
daddi $t1, $t1, 8
daddi $t2, $t2, 8
bnez $t0, loop

halt