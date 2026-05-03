%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    ; ── Capturar cadena numérica ──────────────────────────────────────
   
    mov edx, msg1   ; copia la  1era direccion 
    call puts       ; inprime el primara direccion de edx asta el caracter nulo

    //tamano max de la cadena

    movzx ebx, byte [len]   ; Copia el valor a un registro más grande y lo rellena con ceros y despue slo agurda en ebx
    mov edx, cad    ; donde  se va afuardar el valor de l arreglo
    call capturar

    ;salto de linea
    mov al, [nlin]
    call putchar



    ; ── ATOI: cadena a entero ─────────────────────────────────────────
    mov edx, cad             ; direccion de la cadena 1
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

    ; salida 
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

    xor eax, eax   ; se hace asea si mismo en 0 para contrruir el numeorr
    xor esi, esi   ; indice emnpieza en 0 del strring
    mov ebx, 1      ; empieza en 1 es para saber el signo 

.skip_spaces:
    movzx ecx, byte [edx+esi]   ; toma el caracter y lo aguarda ecx
    cmp ecx, ' '                ; compara si teiene espacio
    je .next_space              ; salta en dado caso si es espacio
    cmp ecx, 0x09               ; compara si es un TAB
    je .next_space              ; Salta si es un tab
    jmp .check_sign            ; revisa si es positico o negativo

.next_space:
    inc esi                 ; incrementa el indice
    jmp .skip_spaces        ;salta al inicio y sigue avanzando

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

    movzx ecx, bx    ; copia el tamano que esta en bx osea ebx que es 64 y lo aguarda en  ecx
    dec ecx          ; reduce 1 para el caracter \0
    xor esi, esi     ; indice

.ciclo:
    call getch           ; lee el carcater y lo aguarda en al
    cmp al, 127          ; si le das en la tecla borrar
    jne .verificar       ;salta si no es igual al 
    cmp esi, 0           ; si no ahi nada escrito no borra
    je .ciclo            ;  regresa a ciclo si es igual 0 
    call borrar          ; llama a  la funcion borrar
    dec esi              ; retrocede indice
    jmp .ciclo           ; entra al ciclo devuelta 

.verificar:
    cmp al, 0xA   ; si le das ala tecla enter 
    je .salir     ; termina captura
    call putchar  ; muestra lo que en al
    mov [edx+esi], al    ; guarda el carcater en memoria
    inc esi               ; incrementa esi
    loop .ciclo           ; salta al ciclo 

.salir:
    mov byte [edx+esi], 0  ; caracter final de salida 
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
    len  db 64                                              ;  agarra 64 bytes en memoria
    cad  times 64 db 0                          ; arreglo de 64 bytes

section .bss
    buffer resb 64
    tmpbuf resb 32
    numero resd 1           ; guarda el entero resultado de ATOI