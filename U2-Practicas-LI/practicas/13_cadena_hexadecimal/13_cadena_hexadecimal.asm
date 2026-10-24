; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 13. Obtención de una cadena hexadecimal

; Descripción: Convierte un número de 32 bits a cadena hexadecimal con AND 0Fh y SHR 4.



; Convierto un numero de 32 bits a texto en hexadecimal.

; Un digito hexadecimal = 4 bits (un nibble), asi que un numero de 32 bits tiene 8 digitos.

; Cada vuelta:

;   1) AND con 0Fh me quedo con los 4 bits de abajo (el digito)

;   2) lo vuelvo caracter: 0-9 -> '0'-'9' , 10-15 -> 'A'-'F'

;   3) SHR 4 para que el siguiente digito quede abajo

; Como el primero que saco es el ULTIMO digito, escribo la cadena de atras para adelante.



INCLUDE Irvine32.inc



.data

pide    BYTE "Dame un numero (decimal): ",0

msgMio  BYTE "Mi cadena hexadecimal:   ",0

msgIrv  BYTE "Con WriteHex de Irvine:  ",0

hexa    BYTE 8 DUP('0'),0     ; 8 digitos + el 0 del final

numero  DWORD ?



.code

main PROC

    mov edx, OFFSET pide

    call WriteString

    call ReadDec              ; numero en EAX

    mov numero, eax           ; lo guardo para comparar al final



    mov ecx, 8                ; 8 digitos = 8 vueltas

    mov esi, 7                ; empiezo a escribir en la ultima posicion (la 7)

convierte:

    mov ebx, eax

    and ebx, 0Fh              ; me quedo solo con los 4 bits de abajo

    cmp ebx, 9

    jbe es_numero             ; si es 9 o menos es un digito normal

    add bl, 37h               ; 10-15 -> 'A'-'F' (37h = 'A' - 10)

    jmp guardar

es_numero:

    add bl, '0'               ; 0-9 -> '0'-'9'

guardar:

    mov hexa[esi], bl         ; lo pongo en su lugar de la cadena

    dec esi                   ; me muevo una posicion hacia atras

    shr eax, 4                ; corro 4 bits para el siguiente digito

    loop convierte



    mov edx, OFFSET msgMio

    call WriteString

    mov edx, OFFSET hexa

    call WriteString

    call Crlf



    mov edx, OFFSET msgIrv    ; lo comparo con la funcion que ya trae Irvine32

    call WriteString

    mov eax, numero

    call WriteHex

    call Crlf



    call WaitMsg

    exit

main ENDP

END main

