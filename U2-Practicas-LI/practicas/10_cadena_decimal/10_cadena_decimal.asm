; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 10. Obtención de una cadena decimal

; Descripción: Convierte un número a su cadena decimal dividiendo entre 10 y usando la pila.



; Convierto un numero a texto (cadena) sin usar WriteDec.

; Idea: divido entre 10 una y otra vez. El residuo de cada division es un digito,

; pero salen al reves (primero las unidades). Por eso los guardo en la pila

; y al sacarlos quedan en el orden correcto.

; Para volver un digito (0 a 9) en caracter le sumo el codigo de '0'.



INCLUDE Irvine32.inc



.data

pide    BYTE "Dame un numero: ",0

msgRes  BYTE "Tu numero convertido a cadena es: ",0

cadena  BYTE 11 DUP(0)        ; 10 digitos como maximo (4294967295) + el 0 del final



.code

main PROC

    mov edx, OFFSET pide

    call WriteString

    call ReadDec              ; el numero queda en EAX



    mov ebx, 10               ; EBX = divisor (voy a dividir entre 10)

    mov ecx, 0                ; ECX = cuantos digitos llevo

convertir:

    mov edx, 0                ; limpio EDX antes de cada DIV

    div ebx                   ; EAX = numero / 10 , EDX = residuo (el digito)

    push edx                  ; guardo el digito en la pila

    inc ecx                   ; un digito mas

    cmp eax, 0

    jne convertir             ; sigo dividiendo mientras el cociente no sea 0



    mov esi, 0                ; ESI = posicion en la cadena

sacar:

    pop eax                   ; saco un digito (salen en el orden correcto)

    add al, '0'               ; lo vuelvo caracter: 5 -> '5'

    mov cadena[esi], al

    inc esi

    loop sacar                ; ECX tiene cuantos digitos eran

    mov cadena[esi], 0        ; marco el final de la cadena



    mov edx, OFFSET msgRes

    call WriteString

    mov edx, OFFSET cadena    ; ahora imprimo la cadena que arme yo

    call WriteString

    call Crlf



    call WaitMsg

    exit

main ENDP

END main

