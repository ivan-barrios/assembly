.data
TABLA: .word 4,11,18,6,17,28,9,0,11,23,15,6,37,29,14
MENOR: .word 20
MAYOR: .word 10
CANTIDAD: .word 15
TOTAL: .word 0
NUEVO: .word 0

.code
ld $s0, MENOR($0) ; $s0 = MENOR
ld $s1, MAYOR($0) ; $s1 = MAYOR

ld $s3, CANTIDAD($0)
dadd $t0, $0, $0  ; $t0 = SUMDIR TABLA
dadd $t1, $0, $0  ; $t1 = SUMDIR NUEVA

daddi $s2, $0, 0  ; $s2 = CANTNUEVO

loop: ld $t2, TABLA($t0)
slt $t3, $s1, $t2
beq $t3, $0, noCumple
slt $t3, $t2, $s0
beq $t3, $0, noCumple
daddi $s2, $s2, 1
sd $t2, NUEVO($t1)
daddi $t1, $t1, 8
noCumple: daddi $t0, $t0, 8
daddi $s3, $s3, -1
bnez $s3, loop
sd $s2, CANTIDAD($0)
halt
