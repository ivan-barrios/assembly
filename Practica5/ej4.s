;IMC: (Peso / altura^2)

.data
peso: .double 80.2
altura: .double 1.77
valor1: .double 18.5
valor2: .double 25.0
valor3: .double 30.0
IMC: .word 0
estado: .word 0
.code
l.d F1, peso(r0) ;f1 = peso
l.d F2, altura(r0) ;f2 = altura
mul.d F3, F2, F2 ;en f3 tengo estatura^2
div.d F4, F1, F3 ;en f4 tengo peso / estatura^2
s.d F4, IMC(r0) ;Guardo resultado en IMC
l.d F5, valor1(r0) ;f5 = 18.5
c.lt.d F4, F5 ;IMC < 18.5?
bc1t infrapeso
l.d F5, valor2(r0) ;f5 = 25
c.lt.d F4, F5 ;IMC < 25?
bc1t normal
l.d F5, valor3(r0) ;f5 = 30
c.lt.d F4, F5 ;IMC < 30?
bc1t sobrepeso
daddi r2, r0, 4 ;Es obeso
j fin
infrapeso: daddi r2, r0, 1 ;Es infrapeso
j fin
normal: daddi r2, r0, 2 ;Es normal
j fin
sobrepeso: daddi r2, r0, 3 ;Es sobrepeso
j fin
fin: sd r2, estado(r0) ;Guardo estado en estado

halt