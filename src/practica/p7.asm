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

    ; salida del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ─────────────────────────────────────────
Capturar:
    push edx
    push cx

    mov cx, ax      ; límite máximo
    dec cx          ; dejar espacio para '\0'
    mov esi, edx    ; guardar inicio del buffer

.ciclo:
    call getche

    cmp al, 0x0A    ; ENTER
    je .fin

    cmp al, 8       ; Backspace (BS) — algunos terminales
    je .borrar

    cmp al, 127     ; Backspace (DEL) — Linux/terminales modernos
    je .borrar

    cmp cx, 0       ; ¿buffer lleno?
    je .ciclo

    mov [edx], al
    inc edx
    dec cx
    jmp .ciclo

.borrar:
    cmp edx, esi    ; ¿ya estamos al inicio del buffer?
    je .ciclo       ; no borrar si no hay nada

    dec edx         ; retroceder en el buffer
    inc cx          ; recuperar espacio

    ; borrar en pantalla: BS + espacio + BS
    mov al, 8
    call putchar
    mov al, ' '
    call putchar
    mov al, 8
    call putchar

    jmp .ciclo

.fin:
    mov byte [edx], 0   ; terminar cadena con '\0'
    pop cx
    pop edx
    ret

; ─────────────────────────────────────────
section .data
    msg1 db "Ingresa una cadena: ", 0
    nlin db 0x0A

section .bss
    cad resb 64

    