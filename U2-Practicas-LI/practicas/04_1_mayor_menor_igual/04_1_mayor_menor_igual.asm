; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 4.1. Mayor, menor o igual con entrada del usuario

; Descripción: Pide dos números al usuario y muestra si el primero es mayor, menor o igual al segundo.



; Pido dos numeros (pueden ser negativos) y digo cual es mayor.

; ReadInt lee un entero con signo y lo deja en EAX.

; Si el usuario escribe algo que no es numero, ReadInt prende la bandera OF,

; asi que con JO vuelvo a pedir el dato.



INCLUDE Irvine32.inc



.data

pide1    BYTE "Dame el primer numero: ",0

pide2    BYTE "Dame el segundo numero: ",0

msgMala  BYTE "Eso no es un numero valido, intenta otra vez",0dh,0ah,0

msgMayor BYTE "El primer numero es MAYOR que el segundo",0dh,0ah,0

msgMenor BYTE "El primer numero es MENOR que el segundo",0dh,0ah,0

msgIgual BYTE "Los dos numeros son IGUALES",0dh,0ah,0

n1 SDWORD ?

n2 SDWORD ?



.code

main PROC

    ; ---------- pedir el primer numero ----------

pedir1:

    mov edx, OFFSET pide1

    call WriteString

    call ReadInt              ; el numero queda en EAX

    jo  mal1                  ; si OF=1 lo que escribio no es numero

    mov n1, eax

    jmp pedir2

mal1:

    mov edx, OFFSET msgMala

    call WriteString

    jmp pedir1                ; vuelvo a preguntar



    ; ---------- pedir el segundo numero ----------

pedir2:

    mov edx, OFFSET pide2

    call WriteString

    call ReadInt

    jo  mal2

    mov n2, eax

    jmp comparar

mal2:

    mov edx, OFFSET msgMala

    call WriteString

    jmp pedir2



    ; ---------- comparar ----------

comparar:

    mov eax, n1

    cmp eax, n2               ; comparo n1 con n2

    jg  mayor                 ; JG = mayor (con signo)

    jl  menor                 ; JL = menor (con signo)

    mov edx, OFFSET msgIgual  ; si no fue ni mayor ni menor, son iguales

    call WriteString

    jmp fin

mayor:

    mov edx, OFFSET msgMayor

    call WriteString

    jmp fin

menor:

    mov edx, OFFSET msgMenor

    call WriteString



fin:

    call WaitMsg

    exit

main ENDP

END main

