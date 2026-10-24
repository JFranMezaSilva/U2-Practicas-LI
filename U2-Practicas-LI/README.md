# Lenguajes de Interfaz: Prácticas de la Unidad 2

## Datos generales

| | |
|---|---|
| **Materia** | Lenguajes de Interfaz |
| **Unidad** | Unidad 2 |
| **Alumno** | Jose Francisco Meza Silva |
| **Horario** | 10:00 a 11:00 AM |
| **Docente** | Dr. José Luis Medina Jiménez |

## Herramientas

Programas en ensamblador MASM de 32 bits con la biblioteca Irvine32, hechos en Visual Studio 2022. Cada práctica está en su propio archivo `.asm` dentro de la carpeta `practicas/` y tiene su encabezado y comentarios que explican las partes principales.

## Índice de prácticas

| # | Práctica | Descripción |
|---|---|---|
| Extra | [Hola mundo con Irvine32 (extra)](practicas/00_hola_mundo.asm) | Imprime un mensaje en pantalla con la biblioteca Irvine32. |
| 1 | [Ciclos numéricos](practicas/01_ciclos_numericos.asm) | Usa LOOP para contar de 1 a 10, hacer una cuenta regresiva y sumar del 1 al 10. |
| 2 | [Captura y desplegado de mensajes](practicas/02_captura_desplegado_mensajes.asm) | Pide el nombre con ReadString, lo guarda en un buffer y muestra un saludo con la cantidad de letras. |
| 3 | [Comparación y prueba](practicas/03_comparacion_prueba.asm) | Compara valores con CMP y revisa bits con TEST (par o impar), mostrando el efecto en las banderas. |
| 4 | [Saltos](practicas/04_saltos.asm) | Prueba JMP, JE y la diferencia entre saltos con signo (JL) y sin signo (JA). |
| 4.1 | [Mayor, menor o igual con entrada del usuario](practicas/04_1_mayor_menor_igual.asm) | Pide dos números al usuario y muestra si el primero es mayor, menor o igual al segundo. |
| 5 | [Condicionales](practicas/05_condicionales.asm) | Evalúa una calificación de 0 a 100 con if/else (excelente, aprobado, reprobado) y valida el rango. |
| 5.1 | [Repetir hasta que el usuario ingrese cero](practicas/05_1_repetir_hasta_cero.asm) | Pide números y los suma hasta que el usuario escribe 0; muestra la cantidad y la suma. |
| 6 | [Decremento e incremento](practicas/06_decremento_incremento.asm) | Usa INC y DEC para contar y demuestra que INC no modifica CF mientras que ADD sí. |
| 6.1 | [Control de ocupación de un estacionamiento](practicas/06_1_estacionamiento.asm) | Controla la ocupación de un estacionamiento de 10 lugares con un menú de entradas y salidas. |
| 7 | [Validación de formato](practicas/07_validacion_formato.asm) | Valida que un código tenga el formato ABC-123 (longitud, tipo de carácter y posición). |
| 8 | [Operaciones aritméticas](practicas/08_operaciones_aritmeticas.asm) | Suma, resta, multiplica y divide dos números (cociente y residuo) evitando la división entre cero. |
| 9 | [PUSH y POP](practicas/09_push_pop.asm) | Demuestra PUSH y POP y los usa para invertir una cadena. |
| 10 | [Obtención de una cadena decimal](practicas/10_cadena_decimal.asm) | Convierte un número a su cadena decimal dividiendo entre 10 y usando la pila. |
| 11 | [Operaciones lógicas](practicas/11_operaciones_logicas.asm) | Aplica AND, OR, XOR y NOT con máscaras y muestra los bits resultantes. |
| 12 | [Desplazamiento y rotación](practicas/12_desplazamiento_rotacion.asm) | Muestra SHL, SHR, SAR, ROL, ROR y RCL sobre valores de 8 bits. |
| 13 | [Obtención de una cadena hexadecimal](practicas/13_cadena_hexadecimal.asm) | Convierte un número de 32 bits a cadena hexadecimal con AND 0Fh y SHR 4. |
| 14 | [Captura y almacenamiento de datos numéricos](practicas/14_captura_datos_numericos.asm) | Captura un número como texto, lo valida, lo convierte y lo guarda en un DWORD verificando que quepa en 32 bits. |
| 15 | [Manipulación de archivos](practicas/15_manipulacion_archivos.asm) | Crea, escribe, cierra, abre y lee un archivo de texto con las funciones de Irvine32. |

## Cómo ejecutar una práctica

1. Crear un proyecto de ensamblador (MASM) con Irvine32 en Visual Studio 2022.
2. Agregar al proyecto el archivo `.asm` de la práctica que se quiere probar (un solo `.asm` con `main` a la vez).
3. Compilar y ejecutar.
