.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
coordX: .byte 5
coordY: .byte 5
color: .byte 0, 255, 0, 1
.code
;$t1 = base
;$t2 = altura
;$s0 = coordX
;$s1 = coordY
;$s2 = color
lwu $s6, CONTROL($0)
lwu $s7, DATA($0)

;Leo la base
daddi $t0, $0, 8
sd $t0, 0($s6) ; Ingrese la base
ld $t1, 0($s7) ; Agarro la base en t1

;Leo la altura
sd $t0, 0($s6) ; Ingrese la altura
ld $t2, 0($s7) ; Agarro la altura en t2

lbu $s0, coordX($0)
lbu $s1, coordY($0)
lwu $s2, color($0)
sb $s2, 0($s7) ; Seteo color de una

dadd $t1, $t1, $s0 ;Sumo la base con la coordenada en x
dadd $t2, $t2, $s1 ;Sumo la altura con la coordenada en y


daddi $t3, $0, 5

dadd $t4, $0, $s1 ; Auxiliar para resetar coordenada en y

loopX: sb $s0, 5($s7) ; Guardo en DATA coordX
    
    loopY: sb $s1, 4($s7) ; Guardo en DATA coordY
        sd $t3, 0($s6) ; Pongo el pixel
        daddi $s1, $s1, 1 ; Le sumo una coordenada en y
        bne $s1, $t2, loopY ; Si no termino con la altura, vuelvo a empezar

    dadd $s1, $0, $t4

    daddi $s0, $s0, 1 ;Le sumo una coordenada en x
    bne $s0, $t1, loopX ;Si no termino con la base, vuelvo a empezar

halt
