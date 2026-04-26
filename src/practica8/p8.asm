%include "../../lib/pc_io.inc"

section .data
    letra db 'A', 0      ; guardamos 'A' en memoria

section .text
    global _start

_start:
    ; Opción 1: pasar el código ASCII directamente
    mov edx, 65          ; 65 = código ASCII de 'A'
    call putchar

    ; Opción 2: pasar el carácter como constante
    mov edx, 'B'         ; NASM convierte 'B' a su valor ASCII (66)
    call putchar

    ; Opción 3: leer el valor desde memoria
    movzx edx, byte [letra]   ; lee 1 byte de 'letra' y lo pone en EDX
    call putchar

    mov eax, 1
    mov ebx, 0
    int 0x80