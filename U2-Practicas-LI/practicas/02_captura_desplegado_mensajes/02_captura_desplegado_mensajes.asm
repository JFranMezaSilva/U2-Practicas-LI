; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 2. Captura y desplegado de mensajes

; Descripción: Pide el nombre con ReadString, lo guarda en un buffer y muestra un saludo con la cantidad de letras.



; Le pido el nombre al usuario, lo guardo en un buffer y lo saludo.

; ReadString: EDX = donde guardar el texto, ECX = maximo de letras.

; Cuando termina, EAX trae cuantos caracteres se escribieron.



INCLUDE Irvine32.inc



.data

pregunta BYTE "Como te llamas? ",0

saludo   BYTE "Hola, ",0

letras   BYTE "Tu nombre tiene esta cantidad de letras: ",0

nombre   BYTE 31 DUP(0)       ; buffer: 30 letras + 1 byte para el 0 del final

cantidad DWORD ?              ; aqui guardo cuantas letras escribio



.code

main PROC

    mov edx, OFFSET pregunta

    call WriteString          ; muestro la pregunta



    mov edx, OFFSET nombre    ; EDX = direccion del buffer

    mov ecx, 30               ; ECX = maximo de letras (uno menos que el buffer, por el 0)

    call ReadString           ; el usuario escribe y ReadString lo guarda

    mov cantidad, eax         ; guardo cuantos caracteres fueron



    mov edx, OFFSET saludo

    call WriteString

    mov edx, OFFSET nombre    ; ahora imprimo lo que escribio

    call WriteString

    call Crlf



    mov edx, OFFSET letras

    call WriteString

    mov eax, cantidad

    call WriteDec

    call Crlf



    call WaitMsg

    exit

main ENDP

END main

