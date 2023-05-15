.data
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car: .asciiz "d" ; caracter buscado
cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.

;.asciiz <s> - almacena una cadena ASCII terminada en 0.

.code
lbu r2, car(r0) ;Letra a buscar
dadd r3, r0, r0 ;Cantidad de repetidos
dadd r4, r0, r0 ;Index de letra

loop: lbu r1, cadena(r4) ;Busco Letra en cadena
beqz r1, fin
bne r1, r2, noEs
daddi r3, r3, 1
noEs: daddi r4, r4, 1 ;avanzo al siguiente caracter. Tengo q sumar 8?
j loop

fin: sd r3, cant(r0)

halt