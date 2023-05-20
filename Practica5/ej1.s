.data
n1: .double 9.13
n2: .double 6.58
res1: .double 0.0
res2: .double 0.0
.code
l.d f1, n1(r0)
l.d f2, n2(r0)
NOP
add.d f3, f2, f1
mul.d f1, f2, f1 ;----> Linea agregada por enunciado
mul.d f4, f2, f1
s.d f3, res1(r0)
s.d f4, res2(r0)
halt

;a) Ciclos: 16, Instrucciones: 7, CPI: 2.286

;b) Se generan 4 Atascos RAW. -> Las instrucciones en conflicto son:
;- l.d f2, n2(r0)
;  add.d f3, f2, f1 (por la falta de f2 en A1)
;- s.d f3, res1(r0) (Por la falta del resultado de add (2 veces))
;- s.d f4, res2(r0) (Por la falta del resultado de mult)

;c) Los atascos estructurales se producen porque cuando termina
;     hacer la suma, quieren pasar a la etapa MEM, la que se estaba
;     ejecutando (guardar el resultado) y el resultado de la suma.
;     Lo mismo pasa con la multiplicacion.

;d) Se produce un atasco WAR porque la instruccion agregada,
;    quiere cambiar el valor de f1, pero la instruccion anterior
;    todavia no termino de usarlo (Lo tiene que leer).

;e) Se soluciona el RAW con el NOP porque le da tiempo a la
;   instruccion add para poder leer el valor de f2.