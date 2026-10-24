; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 6.1. Control de ocupación de un estacionamiento

; Descripción: Controla la ocupación de un estacionamiento de 10 lugares con un menú de entradas y salidas.



; Un estacionamiento con 10 lugares. Un menu deja registrar entradas y salidas.

; Entra un carro -> INC, sale un carro -> DEC.

; Antes de cambiar el numero checo que no se pase de 10 ni baje de 0.



INCLUDE Irvine32.inc



CAPACIDAD = 10                ; total de lugares, si quiero otro tamano nomas cambio esto



.data

ocupados DWORD 0              ; cuantos carros hay adentro



menu BYTE 0dh,0ah,"--- ESTACIONAMIENTO ---",0dh,0ah,

          "1. Entra un carro",0dh,0ah,

          "2. Sale un carro",0dh,0ah,

          "3. Ver estado",0dh,0ah,

          "0. Salir",0dh,0ah,

          "Opcion: ",0

msgMala  BYTE "Opcion no valida",0dh,0ah,0

msgLleno BYTE "Esta lleno, no cabe otro carro",0dh,0ah,0

msgVacio BYTE "Esta vacio, no puede salir nadie",0dh,0ah,0

msgOcup  BYTE "Carros adentro: ",0

msgLibre BYTE "Lugares libres: ",0



.code

main PROC

inicio:

    mov edx, OFFSET menu

    call WriteString

    call ReadInt              ; la opcion queda en EAX

    jo  opcion_mala           ; escribio algo que no es numero

    cmp eax, 1

    je  entra

    cmp eax, 2

    je  sale

    cmp eax, 3

    je  ver

    cmp eax, 0

    je  fin



opcion_mala:

    mov edx, OFFSET msgMala

    call WriteString

    jmp inicio



entra:

    cmp ocupados, CAPACIDAD

    jae lleno                 ; si ya hay 10 (o mas), no entra

    inc ocupados              ; entro un carro

    jmp ver



lleno:

    mov edx, OFFSET msgLleno

    call WriteString

    jmp inicio



sale:

    cmp ocupados, 0

    je  vacio                 ; si no hay carros, no puede salir ninguno

    dec ocupados              ; salio un carro

    jmp ver



vacio:

    mov edx, OFFSET msgVacio

    call WriteString

    jmp inicio



ver:

    mov edx, OFFSET msgOcup

    call WriteString

    mov eax, ocupados

    call WriteDec

    call Crlf



    mov edx, OFFSET msgLibre

    call WriteString

    mov eax, CAPACIDAD

    sub eax, ocupados         ; libres = capacidad - ocupados

    call WriteDec

    call Crlf

    jmp inicio



fin:

    exit

main ENDP

END main

