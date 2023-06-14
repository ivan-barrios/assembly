.data
    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008
    clave:      .asciiz     "cont" ;DE 4 CARACTERES
    exito:      .asciiz     "Bienvenido"
    error:      .asciiz     "Error"
    claveIngresada: .asciiz "" ;DE 4 CARACTERES 
.code
lwu $s0, CONTROL($0) ;$s0 = 0x10000
lwu $s1, DATA($0) ;$s1 = 0x10008
daddi $t0, $0, 4
daddi $t3, $0, claveIngresada

ingresoClave: daddi $t0, $t0, -1 ; Resto 1 a $t0
    jal char ; Ingreso de caracter
    sb $v0, 0($t3) ;Guardo caracter en claveIngresada
    daddi $t3, $t3, 1 ; Incremento en 1 la posicion de claveIngresada
    bnez $t0, ingresoClave ; Si $t0 != 0, vuelve a ingresoClave
sb $0, 0($t3) ; Guardo el caracter nulo en claveIngresada

daddi $t0, $0, 4
daddi $t1, $0, clave
daddi $t2, $0, claveIngresada

comparar: daddi $t0, $t0, -1
    lbu $t3, 0($t1)  ;Caracter de clave
    lbu $t4, 0($t2)  ;Caracter de claveIngresada
    daddi $t1, $t1, 1
    daddi $t2, $t2, 1
    bne $t3, $t4, noEsIgual ;Si son distintos
    bnez $t0, comparar ;Si $t0 != 0, vuelve a comparar

j imprimoRespuesta ;Si son iguales

noEsIgual: daddi $t0, $0, 1 ;En el caso de que el ultimo no sea igual y $t0 = 0
imprimoRespuesta: dadd $a0, $0, $t0
jal respuesta
halt



char: daddi $t1, $0, 9
    sd $t1, 0($s0)
    lbu $v0, 0($s1) ; devuelvo el caracter ingresado
jr $ra


respuesta: lwu $t1, DATA($0)
    bnez $a0, mostrarError
    daddi $t2, $0, exito
    sd $t2, 0($t1)
    j fin

    mostrarError: daddi $t3, $0, error
        sd $t3, 0($t1)

    fin: daddi $t0, $0, 4
        lwu $t1, CONTROL($0)
        sd $t0, 0($t1)
        jr $ra