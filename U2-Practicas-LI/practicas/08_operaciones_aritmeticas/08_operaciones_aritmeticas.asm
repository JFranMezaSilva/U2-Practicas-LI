; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 8. Operaciones aritméticas

; Descripción: Suma, resta, multiplica y divide dos números (cociente y residuo) evitando la división entre cero.



; Pido dos numeros y hago suma, resta, multiplicacion y division.

; MUL: multiplica EAX por el operando, el resultado queda en EDX:EAX.

; DIV: divide EDX:EAX entre el operando, el cociente queda en EAX y el residuo en EDX.

; Antes de dividir pongo EDX en 0 (porque EDX forma parte del dividendo)

; y reviso que el divisor no sea 0 (dividir entre 0 truena el programa).

; Los numeros son sin signo (ReadDec). Uso numeros chicos para que quepan bien.



INCLUDE Irvine32.inc



.data

pide1    BYTE "Dame el primer numero: ",0

pide2    BYTE "Dame el segundo numero: ",0

txtSuma  BYTE "Suma:           ",0

txtResta BYTE "Resta:          ",0

txtMult  BYTE "Multiplicacion: ",0

txtCoc   BYTE "Division, cociente: ",0

txtRes   BYTE "Division, residuo:  ",0

msgCero  BYTE "No se puede dividir entre 0",0dh,0ah,0

num1     DWORD ?

num2     DWORD ?

cociente DWORD ?

residuo  DWORD ?



.code

main PROC

    ; ---------- pedir los numeros ----------

    mov edx, OFFSET pide1

    call WriteString

    call ReadDec              ; numero sin signo en EAX

    mov num1, eax



    mov edx, OFFSET pide2

    call WriteString

    call ReadDec

    mov num2, eax



    ; ---------- suma ----------

    mov edx, OFFSET txtSuma

    call WriteString

    mov eax, num1

    add eax, num2             ; eax = num1 + num2

    call WriteDec

    call Crlf



    ; ---------- resta ----------

    mov edx, OFFSET txtResta

    call WriteString

    mov eax, num1

    sub eax, num2             ; eax = num1 - num2 (puede salir negativo)

    call WriteInt             ; WriteInt muestra el signo

    call Crlf



    ; ---------- multiplicacion ----------

    mov edx, OFFSET txtMult

    call WriteString

    mov eax, num1

    mov ebx, num2

    mul ebx                   ; EDX:EAX = EAX * EBX

    call WriteDec             ; solo muestro EAX, sirve mientras el resultado no sea gigante

    call Crlf



    ; ---------- division ----------

    cmp num2, 0

    je  dividir_cero          ; si el divisor es 0 no divido

    mov eax, num1             ; dividendo en EAX

    mov edx, 0                ; limpio EDX (parte alta del dividendo)

    mov ebx, num2             ; divisor en EBX

    div ebx                   ; EAX = cociente, EDX = residuo

    mov cociente, eax         ; los guardo antes de que EDX se pierda al imprimir texto

    mov residuo, edx



    mov edx, OFFSET txtCoc

    call WriteString

    mov eax, cociente

    call WriteDec

    call Crlf



    mov edx, OFFSET txtRes

    call WriteString

    mov eax, residuo

    call WriteDec

    call Crlf

    jmp fin



dividir_cero:

    mov edx, OFFSET msgCero

    call WriteString



fin:

    call WaitMsg

    exit

main ENDP

END main

