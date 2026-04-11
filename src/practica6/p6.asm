%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    mov edx, cad

ciclo:
    mov al, [edx]   ; leer letra
    cmp al, 0       ; ¿terminó?
    je fin

    call putchar    ; imprimir letra

    inc edx         ; siguiente letra
    jmp ciclo

fin:
    mov edx,msg
    call puts 
    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
    cad db "hola",0
    msg db "",0xA,0