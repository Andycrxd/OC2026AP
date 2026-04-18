%include "../../lib/pc_io.inc"

section .text
    global _start

_start:
    mov edx, msg1
    call puts

    mov edx, cad
    mov ax, 64
    call Capturar

    mov edx, cad
    call puts

    mov eax, 1
    xor ebx, ebx
    int 0x80

Capturar:
    push edx
    push cx

    mov cx, ax
    dec cx
    mov esi, edx

.ciclo:
    call getche

    cmp al, 0xA
    je .fin

    cmp al, 127
    je .borrar

    cmp cx, 0
    je .ciclo

    mov [edx], al
    inc edx
    dec cx
    jmp .ciclo

.borrar:
    cmp edx, esi
    je .ciclo

    dec edx
    inc cx

    mov al, 8
    call putchar
    mov al, ' '
    call putchar
    mov al, 8
    call putchar

    jmp .ciclo

.fin:
    mov byte [edx], 0
    pop cx
    pop edx
    ret

section .data
    msg1 db "Ingresa una cadena: ", 0
    nlin db 0x0A
    cad times 64 db 0