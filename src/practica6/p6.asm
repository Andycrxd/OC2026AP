%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    ; Mensaje inicial
    mov edx, msg1
    call puts              ;funcioon para imprimir edx

       

    ; Salto de línea
    mov al, [nlin]
    call putchar


    ; CAPTURAR CADENA
    mov edx, cad     ; buffer donde guardar
    mov bx, 64       ; tamaño máximo
    call capturar    ; capturar

    ; ORIGINAL
    mov edx, msg2     ; asigna la cadena
    call puts          ; la muestra 
    mov edx, cad        ;   edx apunta al inicio por que en capturar no lo moviste edx y cad solo es la direccion incial
    call puts     ; imprime edx

    ; MAYÚSCULAS
    mov edx, cad   ; mueve edx a la direccion iniciar
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



; ============================================================================
; MAYÚSCULAS

mayusculas:
    push edx  ; aguarda la captura

.recorrer:
    mov al, [edx]
    cmp al, 0         ; al == 0 entra  a fin
    je .fin

    cmp al, 'a'  ; al < a
    jl .sig      ; salta si es menor
    cmp al, 'z'   ;  al > z
    jg .sig        ; salta si es mayor

    sub al, 32  ; convertir a mayuscula 
    mov [edx], al

.sig:
    inc edx
    jmp .recorrer

.fin:
    pop edx
    ret



; MAYÚSCULAS FIN 
; ============================================================================


; ============================================================================
; MINÚSCULAS

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



; MINÚSCULAS FIN
; ============================================================================



section .data
    msg1 db "Ingresa una cadena: ",0
    msg2 db 0xA,"Cadena ingresada: ",0
    msg3 db 0xA,"Mayusculas: ",0
    msg4 db 0xA,"Minusculas: ",0

    nlin db 0xA
    len db 64

    cad times 64 db 0