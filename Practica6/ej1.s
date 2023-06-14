.data
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
    string: .asciiz ""
.text
    lwu $s0, DATA(r0) ; $s0 = dirección de DATA
    lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL
    daddi $t0, $0, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica
    sd $t0, 0($s1) ; CONTROL recibe 6 y limpia la pantalla
    daddi $t2, $zero, 13 ; Ascii Enter
    daddi $t3, $zero, string ; $t3 = dirección de string

    LOOP: daddi $t0, $0, 9 ; $t0 = 9 -> función 9: entrada de un caracter
        sd $t0, 0($s1) ; CONTROL recibe 9 y espera un caracter
        ld $t1, 0($s0) ; $t1 = caracter ingresado
        sb $t1, 0($t3) ; nuevo caracter en tabla
        daddi $t3, $t3, 1 ; $t3 = $t3 + 1
        bne $t1, $t2, LOOP

    daddi $t0, $0, string ; $t0 = dirección de string
    sd $t0, 0($s0) ; DATA recibe la dirección de string
    daddi $t0, $0, 4 ; $t0 = 4 -> función 4: salida de un string
    sd $t0, 0($s1) ; CONTROL recibe 4 e imprime el string
halt