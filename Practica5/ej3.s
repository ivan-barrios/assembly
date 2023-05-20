;Escribir un programa que calcule la superficie de un triángulo
; rectángulo de base 5,85 cm y altura 13,47 cm.
.data
base: .double 5.85
altura: .double 13.47
res: .double 0.0
.code
;Guardo valores necesarios (Base, altura y 2)
l.d F1, base(r0)
l.d F2, altura(r0)
daddi r1, r0, 2
;convierto el 2 a flotante para poder hacer la division?
mtc1 r1, F3
cvt.d.l F3, F3
;Calculo la superficie
mul.d F4, F1, F2
div.d F5, F4, F3
;Guardo resultado en memoria
s.d F5, res(r0)
halt

;39.39975 es el resultado
;Genera 34 atascos jajajaj