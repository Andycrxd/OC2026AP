%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    ; Mostrar mensaje
    mov edx, msg1
    call puts

    ; Capturar cadena
    mov bl, [len]      ; tamaño máximo
    mov edx, cad       ; dirección de la cadena
    call capturar

    ; Salto de línea
    mov al, [nlin]
    call putchar

    ; Mostrar ORIGINAL
    mov edx, msg2
    call puts
    mov edx, cad
    call puts

    ; MAYÚSCULAS
    mov edx, cad
    call mayusculas

    mov edx, msg3
    call puts
    mov edx, cad
    call puts

    ; MINÚSCULAS
    mov edx, cad
    call minusculas

    mov edx, msg4
    call puts
    mov edx, cad
    call puts

    ; Salida del programa
    mov eax, 1
    int 0x80


; ================================
; PROCEDIMIENTO: CAPTURAR
; ================================
capturar:
    push edx
    push cx

    mov cx, bx
    dec cx

.ciclo:
    call getch
    cmp al, 127
    jne .guardar

    call borrar
    jmp .ciclo

.guardar:
    call putchar
    mov [edx], al

    cmp al, 0xA   ; Enter
    je .salir

    inc edx
    loop .ciclo

.salir:
    mov byte [edx], 0

    pop cx
    pop edx
    ret


; ================================
; BORRAR (backspace)
; ================================
borrar:
    push ax

    mov al, 0x8
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x8
    call putchar

    pop ax
    ret


; ================================
; MAYÚSCULAS
; ================================
mayusculas:
    push edx

.recorrer:
    mov al, [edx]
    cmp al, 0
    je .fin

    cmp al, 'a'
    jl .sig
    cmp al, 'z'
    jg .sig

    sub al, 32
    mov [edx], al

.sig:
    inc edx
    jmp .recorrer

.fin:
    pop edx
    ret


; ================================
; MINÚSCULAS
; ================================
minusculas:
    push edx

.recorrer:
    mov al, [edx]
    cmp al, 0
    je .fin

    cmp al, 'A'
    jl .sig
    cmp al, 'Z'
    jg .sig

    add al, 32
    mov [edx], al

.sig:
    inc edx
    jmp .recorrer

.fin:
    pop edx
    ret


section .data
    msg1 db "Ingresa una cadena: ",0
    msg2 db 0xA,"Original: ",0
    msg3 db 0xA,"Mayusculas: ",0
    msg4 db 0xA,"Minusculas: ",0

    nlin db 0xA
    len db 64

    cad times 64 db 0