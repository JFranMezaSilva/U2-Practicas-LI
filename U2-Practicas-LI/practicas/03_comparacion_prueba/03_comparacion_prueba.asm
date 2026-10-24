; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 3. Comparación y prueba

; Descripción: Compara valores con CMP y revisa bits con TEST (par o impar), mostrando el efecto en las banderas.



; CMP resta los dos valores pero NO guarda el resultado, solo cambia las banderas.

; TEST hace un AND pero tampoco guarda nada, solo cambia las banderas.

; Despues de cualquiera de los dos uso un salto condicional para decidir algo.



INCLUDE Irvine32.inc



.data

msgIguales  BYTE "CMP 10 con 10: son iguales (ZF=1)",0dh,0ah,0

msgDistintos BYTE "CMP 10 con 7: son diferentes (ZF=0)",0dh,0ah,0

msgPar      BYTE "TEST: el 14 es PAR (su bit 0 vale 0)",0dh,0ah,0

msgImpar    BYTE "TEST: el 14 es IMPAR (su bit 0 vale 1)",0dh,0ah,0

msgSigue    BYTE "Despues del TEST el numero sigue valiendo: ",0

msgFlags    BYTE "Ahora mira las banderas (ZF debe ser 1 porque 5 = 5):",0dh,0ah,0

numero      BYTE 14



.code

main PROC

    ; ---------- CMP con valores iguales ----------

    mov eax, 10

    mov ebx, 10

    cmp eax, ebx              ; 10 - 10 = 0, entonces ZF se pone en 1

    je iguales1               ; JE salta si ZF=1 (son iguales)

    mov edx, OFFSET msgDistintos

    call WriteString

    jmp parte2

iguales1:

    mov edx, OFFSET msgIguales

    call WriteString



    ; ---------- CMP con valores distintos ----------

parte2:

    mov eax, 10

    cmp eax, 7                ; 10 - 7 = 3, no es 0 asi que ZF=0

    je iguales2

    mov edx, OFFSET msgDistintos

    call WriteString

    jmp parte3

iguales2:

    mov edx, OFFSET msgIguales

    call WriteString



    ; ---------- TEST para saber si un numero es par ----------

parte3:

    mov al, numero            ; AL = 14

    test al, 1                ; AND con 00000001, solo me fijo en el bit 0

    jz es_par                 ; si el resultado fue 0, el bit 0 es 0 y el numero es par

    mov edx, OFFSET msgImpar

    call WriteString

    jmp mostrar

es_par:

    mov edx, OFFSET msgPar

    call WriteString



mostrar:

    mov edx, OFFSET msgSigue

    call WriteString

    movzx eax, al             ; AL sigue siendo 14, TEST no lo modifico

    call WriteDec

    call Crlf



    ; ---------- Ver las banderas con DumpRegs ----------

    mov edx, OFFSET msgFlags

    call WriteString

    mov eax, 5

    cmp eax, 5                ; esto deja ZF=1

    call DumpRegs             ; muestra los registros y las banderas



    call WaitMsg

    exit

main ENDP

END main

