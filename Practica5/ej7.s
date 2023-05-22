.data
M: .word 5
tabla: .word 1,2,3,4,5,6,7,8,9,10
cantElem: .word 10
result: .word 0
.code
ld $a0, M(r0) ;Valor M
daddi $a1, r0, 8 ;Direccion de tabla
ld $a2, cantElem(r0) ;Cantidad de elementos
jal mayores_que_M ;Llamada a la subrutina
sd $v0, result(r0) ;Almacenar resultado
halt

mayores_que_M: daddi $v0, r0, 0 ;Inicializar contador
daddi $a0, $a0, 1 ;Sumo 1 a M
loop: beqz $a2, fin ;Si no quedan elementos, terminar
ld $t0, tabla($a1) ;Cargar primer elemento de la tabla
slt $t1, $a0, $t0 ;Comparar M con el elemento actual
beqz $t1, no_es_mayor ;Si no es mayor, saltar
daddi $v0, $v0, 1 ;Incrementar contador
no_es_mayor: daddi $a2, $a2, -1 ;Decrementar cantidad de elementos
daddi $a1, $a1, 8 ;Incrementar direccion de tabla
j loop ;Volver a iterar
fin: jr $ra

;Calcula la cantidad de numeros mayor o igual a M -> le sumo uno a M
;Ahora si