/*


Registros Nombres     ¿Para que se los utiliza?
r0        $zero        Siempre tiene el valor 0 y no se puede cambiar.
r1        $at          Assembler Temporary – Reservado para ser usado por el ensamblador.
r2-r3     $v0-$v1      Valores de retorno de la subrutina llamada.
r4-r7     $a0-$a3      Argumentos pasados a la subrutina llamada.
r8-r15    $t0-$t7      Registros temporarios. No son conservados en el llamado a subrutinas.
r16-r23   $s0-$s7      Registros salvados durante el llamado a subrutinas. ES PRESERVADO
r24-r25   $t8-$t9      Registros temporarios. No son conservados en el llamado a subrutinas.
r26-r27   $k0-$k1      Para uso del kernel del sistema operativo.
R28       $gp          Global Pointer – Puntero a la zona de la memoria estática del programa. ES PRESERVADO.
R29       $sp          Stack Pointer – Puntero al tope de la pila. ES PRESERVADO.
R30       $fp          frame pointer – Puntero al marco actual de la pila. ES PRESERVADO.
R31       $ra          Return Address – Dirección de retorno en un llamado a una subrutina. ES PRESERVADO.

*/