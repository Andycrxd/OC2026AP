%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    ; Mensaje inicial
    mov edx, msg1
    call puts

    ; Capturar cadena
    mov bl, [len]
    mov bh,0
    mov edx, cad
    call capturar

    ; Salto de línea
    mov al, [nlin]
    call putchar

    ; ORIGINAL
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

    ; Salto de líne pra que se vea mejor
    mov al, [nlin]
    call putchar
    
    ; Salida correcta
    mov eax, 1
    mov ebx, 0
    int 0x80


; ============================
; CAPTURAR
; ============================
capturar:
    push edx
    push cx
    push esi

    mov esi, 0
    mov cx, bx
    dec cx

.ciclo:
    call getch

    cmp al, 127
    jne .verificar

    cmp esi, 0          ; ¿ya estamos al inicio?
    je .ciclo           ; no borrar

    call borrar
    dec esi             ; retroceder en el buffer
    jmp .ciclo

.verificar:
    cmp al, 0xA         ; ENTER
    je .salir

    call putchar
    mov [edx+esi], al
    inc esi
    loop .ciclo

.salir:
    mov byte [edx+esi], 0   ; terminar cadena donde realmente acabó

    pop esi
    pop cx
    pop edx
    ret


; ============================
; BORRAR
; ============================
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


; ============================
; MAYÚSCULAS
; ============================
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


; ============================
; MINÚSCULAS
; ============================
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