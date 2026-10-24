; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 11. Operaciones lógicas

; Descripción: Aplica AND, OR, XOR y NOT con máscaras y muestra los bits resultantes.



; AND, OR, XOR y NOT trabajan bit por bit usando una "mascara":

;   AND con 1 -> deja el bit igual,  AND con 0 -> lo borra

;   OR  con 1 -> lo prende,          OR  con 0 -> lo deja igual

;   XOR con 1 -> lo voltea,          XOR con 0 -> lo deja igual

;   NOT       -> voltea todos los bits

; Para ver los bits uso el procedimiento MuestraBin (lo hice abajo).



INCLUDE Irvine32.inc



.data

valor    BYTE 10101100b       ; el numero con el que voy a jugar (172)

temp     BYTE ?               ; variable de apoyo para MuestraBin

txtOrig  BYTE "Original:                              ",0

txtAnd   BYTE "AND con 00001111b (borra los 4 de arriba):",0

txtOr    BYTE "OR  con 00000011b (prende los 2 de abajo):",0

txtXor   BYTE "XOR con 00001111b (voltea los 4 de abajo):",0

txtNot   BYTE "NOT (voltea todos los bits):             ",0

txtSep   BYTE " ",0

txtIgual BYTE "   = ",0



.code

main PROC

    mov edx, OFFSET txtOrig

    call WriteString

    mov al, valor

    call MuestraBin



    mov edx, OFFSET txtAnd

    call WriteString

    mov al, valor

    and al, 00001111b         ; los 0 de la mascara borran, los 1 conservan

    call MuestraBin



    mov edx, OFFSET txtOr

    call WriteString

    mov al, valor

    or  al, 00000011b         ; los 1 de la mascara prenden esos bits

    call MuestraBin



    mov edx, OFFSET txtXor

    call WriteString

    mov al, valor

    xor al, 00001111b         ; los 1 de la mascara voltean esos bits

    call MuestraBin



    mov edx, OFFSET txtNot

    call WriteString

    mov al, valor

    not al                    ; voltea los 8 bits

    call MuestraBin



    call WaitMsg

    exit

main ENDP



; ------------------------------------------------------------

; MuestraBin: recibe un byte en AL y lo imprime en binario y en decimal.

; Me sirve para no repetir el mismo codigo muchas veces.

; ------------------------------------------------------------

MuestraBin PROC

    mov temp, al              ; guardo el byte porque EAX se va a usar

    movzx eax, al             ; lo paso a 32 bits para WriteBinB

    mov ebx, 1                ; EBX = 1 byte (que muestre 8 bits)

    call WriteBinB            ; imprime en binario

    mov edx, OFFSET txtIgual

    call WriteString

    movzx eax, temp           ; recupero el byte

    call WriteDec             ; imprime el decimal

    call Crlf

    ret

MuestraBin ENDP



END main

