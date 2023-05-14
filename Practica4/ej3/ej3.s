.data
A: .word 1
B: .word 6
.code
ld r1, A(r0)
ld r2, B(r0)
loop: dsll r1, r1, 1
daddi r2, r2, -1
bnez r2, loop
halt

;este programa desplaza a la izquierda el contenido de r1 tantas veces como indique el contenido de r2
;Los atascos RAW en este programa se producen por la dependencia de datos entre 
; la instruccion daddi y la instruccion bnez, ya que la instruccion bnez necesita el resultado de la
; instruccion daddi.

;El branch taken se produce por el salto condicional de la instruccion bnez. Todas las veces quiere predecir
; que no se va a saltar, pero se salta. (Se poducen 5 branch taken: Uno por cada vez que se vuelve a loopear).

;Como son 36 ciclos y son 21 instrucciones, entonces el CPI es 36/21 = 1.714.

;CON FORWARDING DESHABILITADO, se genera primero el atasco RAW por dependencia entre la carga de r1 y la entrada al loop, luego
; se generan dos atascos RAW entre la instruccion daddi y la instruccion bnez, ya que 
; la instruccion bnez necesita el resultado de la instruccion daddi, por lo que daddi se ejecuta, pasa a la parte verde,
; despues a la parte violeta (WB) y recien ahi bnez tiene r2 habilitado para leerlo. (En total 13 atascos RAW)

;b) ii) ????