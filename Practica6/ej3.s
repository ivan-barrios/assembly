.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
.code
lwu $s0, CONTROL($0) ; Direccion de control como argumento
lwu $s1, DATA($0) ; Direccion de datos como argumento

jal ingreso ; Solicito Ingreso de los dos numeros
dadd $a2, $0, $v0 ; Registro de argumento 1
dadd $a3, $0, $v1 ; Registro de argumento 2

jal suma ; Sumo los dos numeros


halt

ingreso: daddi $t0, $0, 8 ; Function de lectura de numero
    sd $t0, 0($s0) ; Solicito ingreso
    ld $v0, 0($s1) ; Me guardo en v0 el numero ingresado
    sd $t0, 0($s0) ; Solicito ingreso
    ld $v1, 0($s1) ; Me guardo en v1 el numero ingresado
jr $ra

suma: dadd $t0, $a2, $a3 ; SUmo los dos numeros y lo pongo en $t0
    sd $t0, 0($s1) ; Guardo res en DATA
    daddi $t1, $0, 1
    sd $t1, 0($s0); Imprimo resultado
jr $ra