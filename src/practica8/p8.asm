%include "../../lib/pc_io.inc"

section .text
global _start

_start:
    call getch        ; AL = tecla

    mov bl, al        ;  guardamos la letra

    ; imprimir letra
    movzx edx, bl
    call putchar

    ; imprimir espacio
    mov edx, '-'
    call putchar

    ; imprimir letra otra vez
    movzx edx, bl
    call putchar

    mov eax, 1
	mov ebx,0
    int 0x80