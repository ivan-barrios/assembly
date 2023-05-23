.data
valor: .word 10
result: .word 0
.text
daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1)
ld $a0, valor($0) ; Guardo numero a calcular el factorial
jal factorial ; Llamo a la subrutina factorial
sd $v0, result($0) ; Guardo el resultado
halt

;El base case es que el numero sea 1, en ese caso devolvemos 1
;Si no, llamamos a la funcion con el numero - 1 y multiplicamos
; el resultado por el numero

factorial: daddi $t0, $a0, -1 ;Resto al argumento 1, si da 0 es caso base
beqz $t0, base ;Si es base case, retorno 1
sd $ra, 0($sp) ;Guardo $ra en la pila
sd $a0, 8($sp) ;Guardo $a0 en la pila
daddi $sp, $sp, -16 ;Reservo espacio en la pila
daddi $a0, $a0, -1 ;Resto 1 al argumento
jal factorial
j return
base: daddi $v0, $0, 1 ;Pongo $v0 = 1 (Retorno 1)
jr $ra ;Retorno a la funcion que me llamo
return: ld $a0, 16($sp) ;Recupero $a0 de la pila
dmul $v0, $a0, $v0
ld $ra, 24($sp)
daddi $sp, $sp, 16
jr $ra
