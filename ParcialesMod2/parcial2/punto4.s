.data
msj: .asciiz "El Resultado es: "
CONTROL: .word32 0x10000
DATA: .word32 0x10008
Valor: .double 9.36
.code
lwu $s6, CONTROL($0)
lwu $s7, DATA($0)

daddi $t0, $0, 8
sd $t0, 0($s6)
l.d f1, 0($s7)

l.d f2, Valor($0) ;Guardo Valor en f2

c.lt.d f1, f2

bc1f esMayor

;Calcular cuando f1 es menor o igual
sub.d f3, f2, f1
div.d f3, f3, f1
j listo

;Calcular cuando f1 es mayor
esMayor: sub.d f3, f1, f2
mul.d f3, f1, f3

listo: daddi $t0, $0, msj
sd $t0, 0($s7)
daddi $t0, $0, 4
sd $t0, 0($s6)

s.d f3, 0($s7)
daddi $t0, $0, 3
sd $t0, 0($s6)

halt