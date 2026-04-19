%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    mov edx, msg1
    call puts
    
    ; Capturar cadena
    mov bl, [len]         ; asignamos bytes a bl
    mov bh,0               ; asignamos cero para que no alla problemas despues
    mov edx, cad            ;le asignamos 64 espacios vacios
    call capturar 


    ; ORIGINAL
    mov edx, msg2     ; asigna la cadena
    call puts          ; la muestra 
    mov edx, cad        ;   edx apunta al inicio por que en capturar no lo moviste edx y cad solo es la direccion incial
    call puts     ; imprime edx

    ; Salto de líne pra que se vea mejor
    mov al, [nlin]
    call putchar

    mov edx, cad 
    call ATOI

    ; Salida correcta
    mov eax, 1
    mov ebx, 0
    int 0x80

;=============================================================================
;ATOI

AATOI:
    push edx
    push esi
    push ebx

    xor eax, eax        ; eax = resultado = 0
    xor esi, esi        ; índice = 0
    mov ebx, 1          ; signo = +1

; =========================
; Ignorar espacios iniciales
.skip_spaces:
    mov al, [edx+esi]
    cmp al, ' '
    jne .check_sign
    inc esi
    jmp .skip_spaces

; =========================
; Revisar signo
.check_sign:
    cmp al, '-'
    jne .check_plus
    mov ebx, -1         ; signo negativo
    inc esi
    jmp .convert

.check_plus:
    cmp al, '+'
    jne .convert
    inc esi

; =========================
; Convertir dígitos
.convert:
    mov al, [edx+esi]

    cmp al, '0'
    jl .fin             ; si < '0' → salir
    cmp al, '9'
    jg .fin             ; si > '9' → salir

    sub al, '0'         ; convertir ASCII → número

    movzx ecx, al       ; ecx = digito

    imul eax, eax, 10   ; resultado *= 10
    add eax, ecx        ; resultado += digito

    inc esi
    jmp .convert

; =========================
.fin:
    cmp ebx, 1
    je .salir

    neg eax             ; aplicar signo negativo

.salir:
    pop ebx
    pop esi
    pop edx
    ret


; ============================================================================
; CAPTURAR

capturar:
    push edx
    push cx
    push esi

    mov esi, 0
    mov cx, bx   ; en bx esta dentro   esta bh y bl osea 64 bytes de bl
    dec cx      ; decrementamos para el espacio de 0

.ciclo:
    call getch

    cmp al, 127  ; pregunta si son iguales 
    jne .verificar  ;si son iguaes no entra a verificar

    cmp esi, 0          ; ¿ya estamos al inicio?
    je .ciclo           ; no borrar

    call borrar
    dec esi             ; retroceder en el buffer
    jmp .ciclo

.verificar:
    cmp al, 0xA         ; si es un ENTER entra en salir
    je .salir

    call putchar    ; muestra  la letrra 
    mov [edx+esi], al
    inc esi
    loop .ciclo

.salir:
    mov byte [edx+esi], 0   ; terminar cadena donde realmente acabó

    pop esi
    pop cx
    pop edx
    ret


; CAPTURAR fin
; ============================================================================


; ============================================================================
; BORRAR

borrar:
    push ax

    mov al, 0x8   ; backspace
    call putchar   ; ahora esta el cursor posicion ala izq
    mov al, ' '    ;  cambia donde  esta el cursor a vacio
    call putchar   ; imprime y desaparece el valor 
    mov al, 0x8    ; otro bakspace 
    call putchar   ; ahora el cursor esta a la izq

    pop ax
    ret

; BORRAR FIN
; ============================================================================



section .data
    msg1 db "Ingresa una cadena: ",0
    msg2 db 0xA,"Cadena ingresada: ",0
    msg3 db 0xA,"Mayusculas: ",0
    msg4 db 0xA,"Minusculas: ",0

    nlin db 0xA
    len db 64

    cad times 64 db 0