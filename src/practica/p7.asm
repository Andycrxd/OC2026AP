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

; -------------------------
Capturar:
    push edx
    push cx
    push esi

    mov cx, ax
    dec cx
    mov esi, edx   ; inicio del buffer

.ciclo:
    call getche

    cmp al, 0xA        ; ENTER
    je .fin

    cmp al, 8          ; BACKSPACE
    je .borrar

    cmp al, 127        ; BACKSPACE (^?)
    je .borrar

    cmp cx, 0          ; sin espacio
    je .ciclo

    mov [edx], al
    inc edx
    dec cx

    jmp .ciclo

.borrar:
    cmp edx, esi
    je .ciclo

    dec edx

    ; borrar visualmente
    mov al, 8
    call putchar
    mov al, ' '
    call putchar
    mov al, 8
    call putchar

    jmp .ciclo

.fin:
    mov byte [edx], 0

    pop esi
    pop cx
    pop edx
    ret

section .data
msg1 db "Ingresa una cadena: ",0
cad times 64 db 0