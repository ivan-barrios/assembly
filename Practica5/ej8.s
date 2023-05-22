;Escriba una subrutina que reciba como parámetros las direcciones
;del comienzo de dos cadenas terminadas en cero y retorne la posición
;en la que las dos cadenas difieren. En caso de que las dos cadenas
;sean idénticas, debe retornar -1.

.data
cadena1: .asciiz "quechusmeas"
cadena2: .asciiz "jajjaja"
resultado: .word 0
.code
daddi $a0, $0, cadena1 ;Guardo la direccion de la cadena1 en $a0
daddi $a1, $0, cadena2 ;Guardo la direccion de la cadena2 en $a1
jal donde_difieren ;Llamo a la subrutina
sd $v0, resultado($0) ;Guardo el resultado en la variable resultado
halt


donde_difieren: daddi $v0, $0, 0 ;Inicializo el resultado en 0

loop: lb $t1, 0($a0) ;Cargo el caracter de la cadena1 en $t1
lb $t2, 0($a1) ;Cargo el caracter de la cadena2 en $t2
beqz $t1, final ;Si es cero, salgo del loop
beqz $t2, final ;Si es cero, salgo del loop (Llego al final)

dsub $t3, $t1, $t2 ;Resto los caracteres
bnez $t3, fin ;Si son distintos, salgo del loop

daddi $v0, $v0, 1 ;Si son iguales, incremento posicion resultado
daddi $a0, $a0, 1 ;Voy al siguiente caracter
daddi $a1, $a1, 1 ;Voy al siguiente caracter
j loop ;Vuelvo al loop

final: bnez $t2, fin
bnez $t1, fin
daddi $v0, $0, -1 ;Si llego al final de las dos cadenas, retorno -1

fin: jr $ra ;En v0 esta el resultado