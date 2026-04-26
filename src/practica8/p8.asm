%include "../../lib/pc_io.inc"

section .data
    letra db 'A', 0

section .text
    global _start

_start:
    mov edx, 65
    call putchar

    mov edx, 'B'
    call putchar

    movzx edx, byte [letra]
    call putchar

    mov edx, 10         ; ← '\n' fuerza flush del buffer ⭐
    call putchar

    mov eax, 1
    mov ebx, 0
    int 0x80