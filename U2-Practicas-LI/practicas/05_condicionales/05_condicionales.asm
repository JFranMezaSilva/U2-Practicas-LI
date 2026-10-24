; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 5. Condicionales

; Descripción: Evalúa una calificación de 0 a 100 con if/else (excelente, aprobado, reprobado) y valida el rango.



; Esto es como un if / else if / else, pero hecho con CMP y saltos.

; Pido una calificacion de 0 a 100 y digo si es excelente, aprobado o reprobado.

; Primero checo que este dentro del rango (como: if (cal < 0 || cal > 100)).



INCLUDE Irvine32.inc



.data

pide        BYTE "Dame tu calificacion (0 a 100): ",0

msgInvalida BYTE "Calificacion invalida, tiene que estar entre 0 y 100",0dh,0ah,0

msgExcel    BYTE "Excelente!",0dh,0ah,0

msgAprob    BYTE "Aprobado",0dh,0ah,0

msgReprob   BYTE "Reprobado",0dh,0ah,0



.code

main PROC

pedir:

    mov edx, OFFSET pide

    call WriteString

    call ReadInt              ; la calificacion queda en EAX

    jo  invalida              ; no escribio un numero



    cmp eax, 0

    jl  invalida              ; menor que 0, no vale

    cmp eax, 100

    jg  invalida              ; mayor que 100, tampoco



    cmp eax, 90

    jge excelente             ; if (cal >= 90)

    cmp eax, 70

    jge aprobado              ; else if (cal >= 70)



    mov edx, OFFSET msgReprob ; else

    call WriteString

    jmp fin



excelente:

    mov edx, OFFSET msgExcel

    call WriteString

    jmp fin



aprobado:

    mov edx, OFFSET msgAprob

    call WriteString

    jmp fin



invalida:

    mov edx, OFFSET msgInvalida

    call WriteString

    jmp pedir                 ; vuelvo a preguntar hasta que ponga algo valido



fin:

    call WaitMsg

    exit

main ENDP

END main

