; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 14. Captura y almacenamiento de datos numéricos

; Descripción: Captura un número como texto, lo valida, lo convierte y lo guarda en un DWORD verificando que quepa en 32 bits.



; Leo un numero como TEXTO con ReadString, lo reviso y lo convierto a numero de verdad.

; Pasos:

;   1) que no este vacio

;   2) que todos los caracteres sean digitos ('0' a '9')

;   3) convertir: acumulado = acumulado * 10 + digito  (recorriendo de izquierda a derecha)

;   4) que quepa en 32 bits sin signo (maximo 4294967295)

; Para checar el limite uso la bandera CF: MUL y ADD la prenden si el resultado se pasa de 32 bits.

; El resultado final lo guardo en la variable "numero" (un DWORD).



INCLUDE Irvine32.inc



.data

pide     BYTE "Escribe un numero (solo digitos): ",0

msgVacio BYTE "No escribiste nada",0dh,0ah,0

msgMalo  BYTE "Solo se permiten digitos del 0 al 9",0dh,0ah,0

msgGrande BYTE "El numero es muy grande, el maximo es 4294967295",0dh,0ah,0

msgBien  BYTE "Numero guardado en la variable: ",0

entrada  BYTE 16 DUP(0)       ; buffer para el texto

numero   DWORD ?              ; aqui queda guardado el numero ya convertido

diez     DWORD 10             ; MUL necesita el 10 en un registro o variable



.code

main PROC

    mov edx, OFFSET pide

    call WriteString

    mov edx, OFFSET entrada

    mov ecx, 15

    call ReadString           ; EAX = cuantos caracteres escribio



    cmp eax, 0

    je  vacio                 ; no escribio nada



    mov ecx, eax              ; ECX = cuantos caracteres voy a revisar

    mov esi, 0                ; ESI = posicion actual

    mov edi, 0                ; EDI = acumulado (el numero que voy armando)

revisar:

    mov al, entrada[esi]      ; saco el caracter

    cmp al, '0'

    jb  no_digito             ; menor que '0' no es digito

    cmp al, '9'

    ja  no_digito             ; mayor que '9' tampoco

    sub al, '0'               ; lo vuelvo numero: '7' -> 7

    movzx ebx, al             ; EBX = el digito



    mov eax, edi              ; EAX = acumulado

    mul diez                  ; EDX:EAX = acumulado * 10

    jc  muy_grande            ; si se paso de 32 bits, CF=1

    add eax, ebx              ; le sumo el digito

    jc  muy_grande            ; otra vez reviso si se paso

    mov edi, eax              ; guardo el nuevo acumulado



    inc esi                   ; siguiente caracter

    loop revisar



    mov numero, edi           ; todo salio bien, lo guardo en la variable

    mov edx, OFFSET msgBien

    call WriteString

    mov eax, numero

    call WriteDec

    call Crlf

    jmp fin



vacio:

    mov edx, OFFSET msgVacio

    call WriteString

    jmp fin

no_digito:

    mov edx, OFFSET msgMalo

    call WriteString

    jmp fin

muy_grande:

    mov edx, OFFSET msgGrande

    call WriteString



fin:

    call WaitMsg

    exit

main ENDP

END main

