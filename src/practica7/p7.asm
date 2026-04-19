%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    ; ── Capturar cadena numérica ──────────────────────────────────────
    mov edx, msg1
    call puts

    movzx ebx, byte [len]
    mov edx, cad
    call capturar

    mov al, [nlin]
    call putchar

    ; ── ATOI: cadena → entero ─────────────────────────────────────────
    mov edx, cad
    call ATOI               ; resultado en EAX
    mov [numero], eax       ; guardar el entero para usarlo después

    ; ── Mostrar resultado ATOI ────────────────────────────────────────
    mov edx, msg2           ; "ATOI resultado (entero): "
    call puts

    mov eax, [numero]
    call print_int          ; imprimir el entero directamente

    mov al, [nlin]
    call putchar

    ; ── ITOA: entero → cadena ─────────────────────────────────────────
    mov eax, [numero]
    mov ebx, eax
    mov edx, buffer
    mov ecx, 64
    call ITOA

    ; ── Mostrar resultado ITOA ────────────────────────────────────────
    mov edx, msg3           ; "ITOA resultado (cadena): "
    call puts

    mov edx, buffer
    call puts

    mov al, [nlin]
    call putchar

    ; ── Salida ────────────────────────────────────────────────────────
    mov eax, 1
    mov ebx, 0
    int 0x80


; ============================================================================
; PRINT_INT
; Descripción : Imprime el entero en EAX usando ITOA internamente
; Entrada     : EAX = entero a imprimir
; ============================================================================
print_int:
    push eax
    push ebx
    push ecx
    push edx

    mov ebx, eax
    mov edx, tmpbuf
    mov ecx, 32
    call ITOA

    mov edx, tmpbuf
    call puts

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret


; ============================================================================
; ATOI
; Entrada : EDX = dirección de la cadena
; Salida  : EAX = entero con signo
; ============================================================================
ATOI:
    push edx
    push ebx
    push esi

    xor eax, eax
    xor esi, esi
    mov ebx, 1

.skip_spaces:
    movzx ecx, byte [edx+esi]
    cmp ecx, ' '
    je .next_space
    cmp ecx, 0x09
    je .next_space
    jmp .check_sign

.next_space:
    inc esi
    jmp .skip_spaces

.check_sign:
    movzx ecx, byte [edx+esi]
    cmp ecx, '-'
    jne .check_plus
    mov ebx, -1
    inc esi
    jmp .load_digit

.check_plus:
    cmp ecx, '+'
    jne .load_digit
    inc esi

.load_digit:
    movzx ecx, byte [edx+esi]

.convert:
    cmp ecx, '0'
    jl .fin
    cmp ecx, '9'
    jg .fin

    sub ecx, '0'
    imul eax, eax, 10
    add eax, ecx

    inc esi
    movzx ecx, byte [edx+esi]
    jmp .convert

.fin:
    cmp ebx, 1
    je .salir
    neg eax

.salir:
    pop esi
    pop ebx
    pop edx
    ret


; ============================================================================
; ITOA
; Entrada : EBX = entero, EDX = buffer destino, ECX = longitud
; Salida  : EDX = dirección inicio de cadena
; ============================================================================
ITOA:
    push eax
    push ebx
    push ecx
    push esi
    push edi

    mov edi, edx
    xor esi, esi
    mov eax, ebx

    cmp eax, 0
    jge .es_positivo
    neg eax
    mov byte [edi], '-'
    inc edi

.es_positivo:
    cmp eax, 0
    jne .dividir
    mov byte [edi], '0'
    inc edi
    jmp .terminar

.dividir:
    cmp eax, 0
    je .reversa

    xor edx, edx
    mov ecx, 10
    div ecx
    add dl, '0'
    push edx
    inc esi
    jmp .dividir

.reversa:
    cmp esi, 0
    je .terminar
    pop edx
    mov [edi], dl
    inc edi
    dec esi
    jmp .reversa

.terminar:
    mov byte [edi], 0

    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret


; ============================================================================
; CAPTURAR
; ============================================================================
capturar:
    push edx
    push ecx
    push esi

    movzx ecx, bx
    dec ecx
    xor esi, esi

.ciclo:
    call getch
    cmp al, 127
    jne .verificar
    cmp esi, 0
    je .ciclo
    call borrar
    dec esi
    jmp .ciclo

.verificar:
    cmp al, 0xA
    je .salir
    call putchar
    mov [edx+esi], al
    inc esi
    loop .ciclo

.salir:
    mov byte [edx+esi], 0
    pop esi
    pop ecx
    pop edx
    ret


; ============================================================================
; BORRAR
; ============================================================================
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


; ============================================================================
section .data
    msg1 db "Ingresa una cadena numerica: ", 0
    msg2 db "ATOI resultado (entero)  : ", 0
    msg3 db "ITOA resultado (cadena)  : ", 0
    nlin db 0xA
    len  db 64
    cad  times 64 db 0

section .bss
    buffer resb 64
    tmpbuf resb 32
    numero resd 1           ; guarda el entero resultado de ATOI