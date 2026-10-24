; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: Hola mundo con Irvine32

; Descripción: Imprime un mensaje en pantalla con la biblioteca Irvine32.



; Es el programa mas basico: nomas imprime un mensaje en pantalla.



INCLUDE Irvine32.inc          ; aqui vienen WriteString, Crlf, etc.



.data

mensaje BYTE "Hola mundo desde ensamblador!",0   ; el 0 del final marca donde acaba el texto



.code

main PROC

    mov edx, OFFSET mensaje   ; WriteString quiere la direccion del texto en EDX

    call WriteString          ; imprime el texto

    call Crlf                 ; salto de linea

    call WaitMsg              ; espera una tecla para que no se cierre la ventana

    exit                      ; termina el programa

main ENDP

END main

