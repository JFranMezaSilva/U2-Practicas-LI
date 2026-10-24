; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 4. Saltos

; Descripción: Prueba JMP, JE y la diferencia entre saltos con signo (JL) y sin signo (JA).



; Aqui pruebo JMP (siempre salta), JE (igual) y la diferencia entre

; saltos CON signo (JL, JG) y SIN signo (JA, JB).

; Comparo -5 con 3: con signo -5 es menor, pero sin signo -5 se ve como

; un numero gigante (FFFFFFFBh), asi que ahi si es mayor.



INCLUDE Irvine32.inc



.data

numA SDWORD -5

numB SDWORD 3



msgInicio BYTE "Comparando A = -5 con B = 3",0dh,0ah,0

msgJmp    BYTE "Esta linea se la salta el JMP (no deberias verla)",0dh,0ah,0

msgEsIgual BYTE "JE: A es igual a -5",0dh,0ah,0

msgNoIgual BYTE "JE: A NO es igual a -5",0dh,0ah,0

msgSig1   BYTE "Con signo: A es MENOR que B (salto JL)",0dh,0ah,0

msgSig2   BYTE "Con signo: A NO es menor que B",0dh,0ah,0

msgUns1   BYTE "Sin signo: A es MAYOR que B (salto JA)",0dh,0ah,0

msgUns2   BYTE "Sin signo: A NO es mayor que B",0dh,0ah,0



.code

main PROC

    mov edx, OFFSET msgInicio

    call WriteString



    ; ---------- JMP: salto incondicional ----------

    jmp saltado               ; brinca directo a "saltado" sin preguntar nada

    mov edx, OFFSET msgJmp    ; esto nunca se ejecuta

    call WriteString

saltado:



    ; ---------- JE: salta si son iguales ----------

    cmp numA, -5

    je  es_igual

    mov edx, OFFSET msgNoIgual

    call WriteString

    jmp con_signo

es_igual:

    mov edx, OFFSET msgEsIgual

    call WriteString



    ; ---------- Comparacion CON signo ----------

con_signo:

    mov eax, numA

    cmp eax, numB

    jl  es_menor              ; JL = jump if less (con signo)

    mov edx, OFFSET msgSig2

    call WriteString

    jmp sin_signo

es_menor:

    mov edx, OFFSET msgSig1

    call WriteString



    ; ---------- Comparacion SIN signo ----------

sin_signo:

    mov eax, numA

    cmp eax, numB

    ja  es_mayor              ; JA = jump if above (sin signo)

    mov edx, OFFSET msgUns2

    call WriteString

    jmp terminar

es_mayor:

    mov edx, OFFSET msgUns1

    call WriteString



terminar:

    call WaitMsg

    exit

main ENDP

END main

