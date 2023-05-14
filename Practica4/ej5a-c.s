.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0

.code
dadd r1, r0, r0
ld r2, cant(r0)
loop: ld r3, datos(r1)
daddi r2, r2, -1
dsll r3, r3, 1
sd r3, res(r1)
bnez r2, loop
daddi r1, r1, 8 ; se reemplazo el nop por esta instruccion.
halt

;Lo que hace es ejecutar la siguiente instruccion despues
; del salto inmediatamente, se ejecute el salto o no.
;El propósito del delay slot es aprovechar al máximo el
; tiempo de ejecución y mantener la eficiencia del pipeline.

;La instruccion nop sive para que no se ejecute el halt 
; sin que haya terminado el loop.

;Son 63 ciclos, 59 instrucciones y 1.068 CPI


;Reemplazando el nop por una instruccion que sirve, la cantidad
; de ciclos es 55, la cantidad de instrucciones es 51 y tiene 
; 1.078 CPI