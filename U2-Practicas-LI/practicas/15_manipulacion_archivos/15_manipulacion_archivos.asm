; Materia: Lenguajes de Interfaz

; Alumno: Jose Francisco Meza Silva

; Horario: 10:00 a 11:00 AM

; Docente: Dr. José Luis Medina Jiménez

; Práctica: 15. Manipulación de archivos

; Descripción: Crea, escribe, cierra, abre y lee un archivo de texto con las funciones de Irvine32.



; Hago todo el recorrido con un archivo de texto:

;   1) CreateOutputFile: crea el archivo (EDX = nombre) y regresa el "handle" en EAX

;      (el handle es como un numero de identificacion del archivo abierto)

;   2) WriteToFile: escribe (EAX = handle, EDX = buffer, ECX = cuantos bytes)

;   3) CloseFile: lo cierra (EAX = handle)

;   4) OpenInputFile: lo abre para leer y regresa otro handle en EAX

;   5) ReadFromFile: lee (EAX = handle, EDX = buffer, ECX = maximo), en EAX queda cuantos bytes leyo

;   6) Le pongo el 0 al final de lo leido (ReadFromFile NO lo pone) y lo muestro

; Si algo sale mal, el handle regresa como INVALID_HANDLE_VALUE.

; El archivo salida.txt se crea en la carpeta del proyecto.



INCLUDE Irvine32.inc



MAXLEER = 100                 ; maximo de bytes que voy a leer



.data

nombreArchivo BYTE "salida.txt",0

texto         BYTE "Hola, este texto lo escribi desde ensamblador.",0dh,0ah

              BYTE "Esta es la segunda linea del archivo.",0dh,0ah

TAMTEXTO = ($ - texto)        ; cuantos bytes mide el texto (el $ es la posicion actual)

buffer        BYTE MAXLEER+1 DUP(0)   ; donde voy a guardar lo que lea (+1 para el 0)

manejador     DWORD ?         ; aqui guardo el handle

msgEscrito    BYTE "Archivo creado y escrito. Bytes escritos: ",0

msgLeido      BYTE "Bytes leidos: ",0

msgContenido  BYTE "Contenido del archivo:",0dh,0ah,0

msgError      BYTE "Hubo un error con el archivo",0dh,0ah,0



.code

main PROC

    ; ---------- 1) crear el archivo ----------

    mov edx, OFFSET nombreArchivo

    call CreateOutputFile     ; handle en EAX

    cmp eax, INVALID_HANDLE_VALUE

    je  hubo_error            ; si no se pudo crear, me voy a error

    mov manejador, eax



    ; ---------- 2) escribir ----------

    mov eax, manejador        ; EAX = handle

    mov edx, OFFSET texto     ; EDX = lo que voy a escribir

    mov ecx, TAMTEXTO         ; ECX = cuantos bytes

    call WriteToFile          ; en EAX quedan los bytes escritos



    mov edx, OFFSET msgEscrito

    call WriteString

    call WriteDec             ; EAX todavia trae los bytes escritos

    call Crlf



    ; ---------- 3) cerrar ----------

    mov eax, manejador

    call CloseFile



    ; ---------- 4) abrir para leer ----------

    mov edx, OFFSET nombreArchivo

    call OpenInputFile        ; nuevo handle en EAX

    cmp eax, INVALID_HANDLE_VALUE

    je  hubo_error

    mov manejador, eax



    ; ---------- 5) leer ----------

    mov edx, OFFSET buffer

    mov ecx, MAXLEER

    call ReadFromFile         ; EAX = bytes leidos

    jc  hubo_error            ; si CF=1 hubo error al leer

    mov buffer[eax], 0        ; pongo el 0 justo despues del ultimo byte leido



    mov edx, OFFSET msgLeido

    call WriteString

    call WriteDec             ; EAX trae cuantos bytes leyo

    call Crlf



    ; ---------- 6) cerrar y mostrar ----------

    mov eax, manejador

    call CloseFile



    mov edx, OFFSET msgContenido

    call WriteString

    mov edx, OFFSET buffer

    call WriteString          ; ya tiene el 0 al final, asi que funciona

    jmp fin



hubo_error:

    mov edx, OFFSET msgError

    call WriteString



fin:

    call WaitMsg

    exit

main ENDP

END main

