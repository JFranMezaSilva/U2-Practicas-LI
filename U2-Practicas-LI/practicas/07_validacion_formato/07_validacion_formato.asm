; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 7. Validación de formato

; Descripción: Valida que un código tenga el formato ABC-123 (longitud, tipo de carácter y posición).



; Valido un codigo con formato ABC-123:

;   - 7 caracteres en total

;   - posiciones 0,1,2 = letras mayusculas (de 'A' a 'Z')

;   - posicion 3 = el guion '-'

;   - posiciones 4,5,6 = digitos (de '0' a '9')

; Tengo que checar la longitud, el tipo de caracter y su posicion.



INCLUDE Irvine32.inc



.data

pide     BYTE "Escribe un codigo con formato ABC-123: ",0

msgBien  BYTE "Formato correcto!",0dh,0ah,0

msgMal   BYTE "Formato incorrecto, tiene que ser 3 letras mayusculas, un guion y 3 numeros",0dh,0ah,0

codigo   BYTE 20 DUP(0)       ; buffer grande por si escriben de mas



.code

main PROC

    mov edx, OFFSET pide

    call WriteString

    mov edx, OFFSET codigo

    mov ecx, 19               ; maximo 19 letras (el buffer tiene 20)

    call ReadString           ; en EAX queda cuantos caracteres escribio



    ; ---------- 1) la longitud tiene que ser 7 ----------

    cmp eax, 7

    jne formato_malo



    ; ---------- 2) las primeras 3 tienen que ser letras mayusculas ----------

    mov esi, 0                ; ESI = posicion que estoy revisando

revisa_letras:

    mov al, codigo[esi]       ; saco el caracter de esa posicion

    cmp al, 'A'

    jb  formato_malo          ; menor que 'A' no es letra mayuscula

    cmp al, 'Z'

    ja  formato_malo          ; mayor que 'Z' tampoco

    inc esi

    cmp esi, 3

    jb  revisa_letras         ; sigo mientras no llegue a la posicion 3



    ; ---------- 3) la posicion 3 tiene que ser el guion ----------

    cmp codigo[3], '-'

    jne formato_malo



    ; ---------- 4) las posiciones 4, 5 y 6 tienen que ser digitos ----------

    mov esi, 4

revisa_digitos:

    mov al, codigo[esi]

    cmp al, '0'

    jb  formato_malo

    cmp al, '9'

    ja  formato_malo

    inc esi

    cmp esi, 7

    jb  revisa_digitos



    ; si llego hasta aqui paso todas las pruebas

    mov edx, OFFSET msgBien

    call WriteString

    jmp fin



formato_malo:

    mov edx, OFFSET msgMal

    call WriteString



fin:

    call WaitMsg

    exit

main ENDP

END main

