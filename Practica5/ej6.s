.data
valor1: .word 16
valor2: .word 4
result: .word 0
.text
ld $a0, valor1($0)
ld $a1, valor2($0)
jal a_la_potencia
sd $v0, result($0)
halt
a_la_potencia: daddi $v0, $0, 1
lazo: slt $t1, $a1, $0
bnez $t1, terminar
daddi $a1, $a1, -1
dmul $v0, $v0, $a0
j lazo
terminar: jr $ra

;a) Este programa calcula la potencia de un numero elevado a otro
;numero +1 (16^4)

;b) jal salta a la subrutina dejando en $ra la direccion de la 
; siguiente instruccion a ejecutar, y jr salta a la direccion que
; hay en $ra

;c) En $ra se almacena la direccion de retorno de una subrutina
; a0 y a1 son argumentos de la subrutina y v0 es el valor de retorno

;d) Preguntar. Se pasa una direccion a otro lado?