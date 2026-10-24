; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 5.1. Repetir hasta que el usuario ingrese cero

; Descripción: Pide números y los suma hasta que el usuario escribe 0; muestra la cantidad y la suma.



; No sabemos cuantas veces se va a repetir, asi que no uso LOOP.

; Uso un ciclo condicional: pido un numero, si es 0 me salgo,

; si no lo sumo y vuelvo a pedir.

; La suma y el contador los guardo en variables porque es mas facil

; que no se me pierdan entre las llamadas.



INCLUDE Irvine32.inc



.data

pide     BYTE "Dame un numero (0 para terminar): ",0

msgMala  BYTE "Eso no es un numero, intenta otra vez",0dh,0ah,0

msgCant  BYTE "Cantidad de numeros capturados: ",0

msgSuma  BYTE "La suma de todos es: ",0

suma     SDWORD 0             ; empieza en 0

cantidad DWORD 0              ; tambien empieza en 0



.code

main PROC

repetir:

    mov edx, OFFSET pide

    call WriteString

    call ReadInt              ; numero en EAX

    jo  mala                  ; si no fue numero, aviso

    cmp eax, 0

    je  terminar              ; si es 0, se acabo el ciclo

    add suma, eax             ; suma = suma + numero

    inc cantidad              ; un numero mas capturado

    jmp repetir               ; regreso a pedir otro



mala:

    mov edx, OFFSET msgMala

    call WriteString

    jmp repetir



terminar:

    mov edx, OFFSET msgCant

    call WriteString

    mov eax, cantidad

    call WriteDec

    call Crlf



    mov edx, OFFSET msgSuma

    call WriteString

    mov eax, suma

    call WriteInt             ; WriteInt si muestra el signo si es negativo

    call Crlf



    call WaitMsg

    exit

main ENDP

END main

