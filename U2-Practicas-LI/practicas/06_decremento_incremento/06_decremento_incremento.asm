; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 6. Decremento e incremento

; Descripción: Usa INC y DEC para contar y demuestra que INC no modifica CF mientras que ADD sí.



; INC le suma 1 a un valor y DEC le resta 1.

; Truco: DEC deja ZF=1 cuando llega a 0, asi que con JNZ puedo hacer un ciclo

; sin usar LOOP (JNZ salta mientras NO sea cero).

; Tambien pruebo que INC no toca la bandera CF, pero ADD si.



INCLUDE Irvine32.inc



.data

msgInc   BYTE "Subiendo con INC (1 a 5): ",0

msgDec   BYTE "Bajando con DEC (5 a 1): ",0

msgIncOk BYTE "INC no toco CF (CF sigue en 0)",0dh,0ah,0

msgIncMal BYTE "Algo raro, INC si cambio CF",0dh,0ah,0

msgAddOk BYTE "ADD si prendio CF (CF=1)",0dh,0ah,0

msgAddMal BYTE "Algo raro, ADD no prendio CF",0dh,0ah,0



.code

main PROC

    ; ---------- subir con INC ----------

    mov edx, OFFSET msgInc

    call WriteString

    mov ebx, 1

subir:

    mov eax, ebx

    call WriteDec

    mov al, ' '

    call WriteChar

    inc ebx                   ; ebx = ebx + 1

    cmp ebx, 5

    jbe subir                 ; mientras ebx sea menor o igual a 5, sigo

    call Crlf



    ; ---------- bajar con DEC ----------

    mov edx, OFFSET msgDec

    call WriteString

    mov ebx, 5

bajar:

    mov eax, ebx

    call WriteDec

    mov al, ' '

    call WriteChar

    dec ebx                   ; ebx = ebx - 1, si llega a 0 prende ZF

    jnz bajar                 ; mientras no sea 0, sigo

    call Crlf



    ; ---------- INC no cambia CF ----------

    clc                       ; apago CF para empezar limpio

    mov al, 0FFh              ; 255, el maximo en 8 bits

    inc al                    ; da 0 pero INC no toca CF

    jc  inc_mal               ; si CF se prendio, algo raro paso

    mov edx, OFFSET msgIncOk

    call WriteString

    jmp parte_add

inc_mal:

    mov edx, OFFSET msgIncMal

    call WriteString



    ; ---------- ADD si cambia CF ----------

parte_add:

    clc

    mov al, 0FFh

    add al, 1                 ; 255 + 1 se pasa de 8 bits, entonces CF=1

    jc  add_ok

    mov edx, OFFSET msgAddMal

    call WriteString

    jmp fin

add_ok:

    mov edx, OFFSET msgAddOk

    call WriteString



fin:

    call WaitMsg

    exit

main ENDP

END main

