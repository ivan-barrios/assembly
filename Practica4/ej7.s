;Escribir un programa que recorra una TABLA de diez números enteros
; y determine cuántos elementos son mayores que X. El
;resultado debe almacenarse en una dirección etiquetada CANT.
; El programa debe generar además otro arreglo llamado RES
;cuyos elementos sean ceros y unos. Un ‘1’ indicará que el
; entero correspondiente en el arreglo TABLA es mayor que X,
;mientras que un ‘0’ indicará que es menor o igual.


.data
TABLA: .word 11, 22, 3, 4, 55, 6, 7, 8, 9, 10
CANTELEM: .word 10
NUM: .word 5
CANT: .word 0
RES: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.code
ld r6, CANTELEM(r0) ;Cantidad de elementos en TABLA
dadd r5, r0, r0 ;r1 = contador de tabla (Arranca por el primero)
dadd r3, r0, r0 ;Cantidad de elementos mayores
ld r2, NUM(r0) ;r2 = numero de referencia

loop: ld r1, TABLA(r5)
slt r4, r2, r1
dadd r3, r3, r4 ;Sumo cant de Elementos mayores (r4 es 1 si es mayor y es 0 si es menor)
sd r4, RES(r5) ;Pongo en RES el elemento mayor en 1
daddi r6, r6, -1
daddi r5, r5, 8
bnez r6, loop

sd r3, CANT(r0)

halt