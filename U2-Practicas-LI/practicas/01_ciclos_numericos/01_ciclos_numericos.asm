; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 1. Ciclos numéricos

; Descripción: Usa LOOP para contar de 1 a 10, hacer una cuenta regresiva y sumar del 1 al 10.



; Uso LOOP tres veces: contar hacia arriba, hacia abajo y sumar.

; LOOP siempre usa ECX como contador: le resta 1 y, si no llego a 0, regresa a la etiqueta.



INCLUDE Irvine32.inc



.data

msg1 BYTE "Contando del 1 al 10: ",0

msg2 BYTE "Cuenta regresiva del 10 al 1: ",0

msg3 BYTE "La suma de 1 al 10 es: ",0



.code

main PROC

    ; ---------- Ciclo 1: contar de 1 a 10 ----------

    mov edx, OFFSET msg1

    call WriteString

    mov ecx, 10               ; ECX = cuantas vueltas va a dar el ciclo

    mov ebx, 1                ; EBX = el numero que voy a imprimir, empieza en 1

subir:

    mov eax, ebx              ; WriteDec imprime lo que haya en EAX

    call WriteDec

    mov al, ' '               ; un espacio para que no salgan pegados

    call WriteChar

    inc ebx                   ; paso al siguiente numero

    loop subir                ; resta 1 a ECX y si no es 0 regresa a "subir"

    call Crlf



    ; ---------- Ciclo 2: cuenta regresiva de 10 a 1 ----------

    mov edx, OFFSET msg2

    call WriteString

    mov ecx, 10               ; otra vez 10 vueltas

    mov ebx, 10               ; ahora empiezo en 10

bajar:

    mov eax, ebx

    call WriteDec

    mov al, ' '

    call WriteChar

    dec ebx                   ; ahora le resto 1 en vez de sumar

    loop bajar

    call Crlf



    ; ---------- Ciclo 3: sumar del 1 al 10 ----------

    mov edx, OFFSET msg3

    call WriteString

    mov ebx, 0                ; EBX = acumulador de la suma, empieza en 0

    mov ecx, 10               ; ECX vale 10, 9, 8 ... 1 en cada vuelta, asi que lo sumo directo

sumar:

    add ebx, ecx              ; suma el valor actual de ECX

    loop sumar

    mov eax, ebx              ; paso el resultado a EAX para imprimirlo (da 55)

    call WriteDec

    call Crlf



    call WaitMsg

    exit

main ENDP

END main

