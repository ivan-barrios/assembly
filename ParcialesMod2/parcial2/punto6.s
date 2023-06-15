.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
color1: .byte 255, 0, 0, 0
color2: .byte 0, 255, 0, 0
cX1: .byte 0
cY1: .byte 0
cX2: .byte 0
cY2: .byte 0
tabla_1: .word 21, 12, 5, 16, 8, 39, 10, 41, 4, 33
tabla_2: .word 32, 24, 15, 32, 17, 28, 11, 20, 44, 21

.code
daddi $a0, $0, tabla_1
daddi $a1, $0, 10
jal MIN_MAX
sb $v1, cX1($0)
sb $v0, cY2($0)

daddi $a0, $0, tabla_2
daddi $a1, $0, 10
jal MIN_MAX
sb $v0, cY1($0)
sb $v1, cX2($0)

lwu $s6, CONTROL($0)
lwu $s7, DATA($0)

daddi $t3, $0, 5

lbu $t0, cX1($0)
sb $t0, 5($s7)
lbu $t1, cY1($0)
sb $t1, 4($s7)
lwu $t2, color1($0)
sw $t2, 0($s7)
sd $t3, 0($s6)

lbu $t0, cX2($0)
sb $t0, 5($s7)
lbu $t1, cY2($0)
sb $t1, 4($s7)
lwu $t2, color2($0)
sw $t2, 0($s7)
sd $t3, 0($s6)


halt

MIN_MAX: daddi $v0, $0, 0
daddi $v1, $0, 49
loop: ld $t0, 0($a0) ; $t0 = Elemento
slt $t1, $t0, $v1 ; $t1 = 1 si ($t0 < $v1)
beq $t1, $0, noMin 
dadd $v1, $0, $t0
noMin: slt $t2, $v0, $t0 ; $t2 = 1 si ($t0 > $v0)
beq $t2, $0, noMax 
dadd $v0, $0, $t0
noMax: daddi $a1, $a1, -1
daddi $a0, $a0, 8
bnez $a1, loop
jr $ra