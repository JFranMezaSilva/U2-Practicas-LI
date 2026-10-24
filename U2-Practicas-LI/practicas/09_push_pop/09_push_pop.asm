; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 9. PUSH y POP

; Descripción: Demuestra PUSH y POP y los usa para invertir una cadena.



; La pila funciona como una pila de platos: el ultimo que pones es el primero que sacas (LIFO).

; PUSH mete un valor y POP saca el de hasta arriba.

; Parte 1: meto 10, 20 y 30 y los saco, salen al reves.

; Parte 2: uso la pila para voltear una palabra (meto cada letra y las saco al reves).



INCLUDE Irvine32.inc



.data

msgParte1 BYTE "Saque de la pila (salen al reves): ",0

pide      BYTE "Escribe una palabra o frase: ",0

msgInv    BYTE "Al reves queda: ",0

cadena    BYTE 31 DUP(0)      ; aqui guardo lo que escriba (30 letras maximo)

inversa   BYTE 31 DUP(0)      ; aqui voy a armar la version al reves

longitud  DWORD ?



.code

main PROC

    ; ---------- Parte 1: PUSH y POP con numeros ----------

    push 10                   ; la pila queda: 10

    push 20                   ; la pila queda: 10, 20

    push 30                   ; la pila queda: 10, 20, 30 (el 30 esta hasta arriba)



    mov edx, OFFSET msgParte1

    call WriteString

    pop eax                   ; saca el 30

    call WriteDec

    mov al, ' '

    call WriteChar

    pop eax                   ; saca el 20

    call WriteDec

    mov al, ' '

    call WriteChar

    pop eax                   ; saca el 10

    call WriteDec

    call Crlf



    ; ---------- Parte 2: voltear una cadena ----------

    mov edx, OFFSET pide

    call WriteString

    mov edx, OFFSET cadena

    mov ecx, 30

    call ReadString           ; EAX = cuantas letras escribio

    mov longitud, eax

    cmp eax, 0

    je  terminar              ; si no escribio nada no hay nada que voltear



    ; meter cada letra a la pila

    mov ecx, longitud         ; LOOP va a dar una vuelta por letra

    mov esi, 0                ; ESI = posicion de la letra

meter:

    movzx eax, cadena[esi]    ; saco la letra y la convierto a 32 bits (PUSH quiere 32 bits)

    push eax

    inc esi

    loop meter



    ; sacar las letras de la pila, salen al reves

    mov ecx, longitud

    mov esi, 0

sacar:

    pop eax                   ; la ultima letra que entro es la primera que sale

    mov inversa[esi], al      ; solo me quedo con la parte baja (la letra)

    inc esi

    loop sacar

    mov inversa[esi], 0       ; el 0 del final para que WriteString sepa donde acaba



    mov edx, OFFSET msgInv

    call WriteString

    mov edx, OFFSET inversa

    call WriteString

    call Crlf



terminar:

    call WaitMsg

    exit

main ENDP

END main

