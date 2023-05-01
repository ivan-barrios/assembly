PIO EQU 30H
 ORG 1000H
MSJ DB "CONCEPTOS DE "
 DB "ARQUITECTURA DE "
 DB "COMPUTADORAS"
FIN DB ?
 ORG 2000H
 MOV AL, 0FDH ; INICIALIZACION PIO PARA IMPRESORA
 OUT PIO+2, AL ; Strobe de entrada y busy de salida (Estado)
 MOV AL, 0
 OUT PIO+3, AL ; PB todos de salida (Datos)
 IN AL, PIO ; Lo que esta en PA, en AL
 AND AL, 0FDH ; Fuerzo el bit de Strobe en 0 (Sin señal de que le mande datos a la impresora)
 OUT PIO, AL ; FIN INICIALIZACION
 MOV BX, OFFSET MSJ
 MOV CL, OFFSET FIN-OFFSET MSJ
POLL: IN AL, PIO
 AND AL, 1 ; AL es 1 si está busy, sino AL es 0
 JNZ POLL ; Hasta que este busy, sigo haciendo POLL
 MOV AL, [BX] ; Agarro caracter en AL
 OUT PIO+1, AL ; En PB (Datos) pongo el caracter
 IN AL, PIO ; PULSO 'STROBE'
 OR AL, 02H
 OUT PIO, AL ; Pongo STROBE en 1, para avisar que dejamos caracter
 IN AL, PIO
 AND AL, 0FDH
 OUT PIO, AL ; FIN PULSO (Pongo de nuevo STROBE en 0 para poder avisar con el proximo caracter)
 INC BX
 DEC CL
 JNZ POLL
 INT 0
 END