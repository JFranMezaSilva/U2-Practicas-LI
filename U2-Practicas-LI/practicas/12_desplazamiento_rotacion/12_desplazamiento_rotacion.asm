; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 12. Desplazamiento y rotación

; Descripción: Muestra SHL, SHR, SAR, ROL, ROR y RCL sobre valores de 8 bits.



; Desplazar = mover los bits a un lado (los que salen se pierden, o van a CF).

;   SHL = a la izquierda, mete ceros. Equivale a multiplicar por 2.

;   SHR = a la derecha, mete ceros. Equivale a dividir entre 2 (sin signo).

;   SAR = a la derecha pero copia el bit de signo (sirve con negativos).

; Rotar = los bits que salen por un lado vuelven a entrar por el otro.

;   ROL / ROR = rotan solo los bits del registro.

;   RCL / RCR = rotan pasando por la bandera CF (CF es como un bit extra).

; Los numeros se ven como binario y decimal SIN signo con MuestraBin.



INCLUDE Irvine32.inc



.data

temp     BYTE ?

r1       BYTE ?               ; aqui guardo el resultado del primer RCL

r2       BYTE ?               ; y aqui el del segundo

txtIgual BYTE "   = ",0

tOrig    BYTE "Original 22:                  ",0

tShl     BYTE "SHL 1 (x2):                   ",0

tShr     BYTE "SHR 1 (/2):                   ",0

tShl3    BYTE "5 con SHL 3 (x8):             ",0

tSarA    BYTE "Negativo -16 (11110000b):     ",0

tSarB    BYTE "SAR 2 (queda -4 = 11111100b): ",0

tRolA    BYTE "Otro numero:                  ",0

tRol     BYTE "ROL 1 (el bit de arriba pasa abajo): ",0

tRor     BYTE "ROR 1 (el bit de abajo pasa arriba): ",0

tRcl1    BYTE "RCL 1, primera vez (CF entra con 0):  ",0

tRcl2    BYTE "RCL 1, segunda vez (CF entra con 1):  ",0



.code

main PROC

    ; ---------- SHL y SHR ----------

    mov edx, OFFSET tOrig

    call WriteString

    mov al, 22                ; 00010110b

    call MuestraBin



    mov edx, OFFSET tShl

    call WriteString

    mov al, 22

    shl al, 1                 ; 00101100b = 44

    call MuestraBin



    mov edx, OFFSET tShr

    call WriteString

    mov al, 22

    shr al, 1                 ; 00001011b = 11

    call MuestraBin



    mov edx, OFFSET tShl3

    call WriteString

    mov al, 5

    shl al, 3                 ; correr 3 lugares = multiplicar por 2*2*2 = 8, da 40

    call MuestraBin



    ; ---------- SAR con un negativo ----------

    mov edx, OFFSET tSarA

    call WriteString

    mov al, 11110000b         ; en complemento a dos es -16

    call MuestraBin

    mov edx, OFFSET tSarB

    call WriteString

    mov al, 11110000b

    sar al, 2                 ; copia el bit de signo, el numero sigue siendo negativo

    call MuestraBin



    ; ---------- ROL y ROR ----------

    mov edx, OFFSET tRolA

    call WriteString

    mov al, 10010011b

    call MuestraBin



    mov edx, OFFSET tRol

    call WriteString

    mov al, 10010011b

    rol al, 1                 ; queda 00100111b (el 1 de arriba se fue abajo)

    call MuestraBin



    mov edx, OFFSET tRor

    call WriteString

    mov al, 10010011b

    ror al, 1                 ; queda 11001001b (el 1 de abajo se fue arriba)

    call MuestraBin



    ; ---------- RCL (rota usando CF) ----------

    clc                       ; CF = 0 para empezar

    mov al, 10000001b

    rcl al, 1                 ; el 1 de arriba se va a CF, y el CF (0) entra por abajo

    mov r1, al                ; MOV no cambia banderas, asi que CF no se pierde

    rcl al, 1                 ; ahora CF vale 1 y ese 1 entra por abajo

    mov r2, al



    mov edx, OFFSET tRcl1

    call WriteString

    mov al, r1                ; 00000010b

    call MuestraBin

    mov edx, OFFSET tRcl2

    call WriteString

    mov al, r2                ; 00000101b

    call MuestraBin



    call WaitMsg

    exit

main ENDP



; ------------------------------------------------------------

; MuestraBin: recibe un byte en AL y lo imprime en binario y en decimal.

; ------------------------------------------------------------

MuestraBin PROC

    mov temp, al

    movzx eax, al

    mov ebx, 1

    call WriteBinB

    mov edx, OFFSET txtIgual

    call WriteString

    movzx eax, temp

    call WriteDec

    call Crlf

    ret

MuestraBin ENDP



END main

