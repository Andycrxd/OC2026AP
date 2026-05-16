%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a


global set_bit
global get_bit

section .text

; void set_bit(unsigned char *value, unsigned char bit)

set_bit:

    push ebp
    mov ebp, esp

    mov eax, [ebp+8]      ; puntero value
    mov cl, [ebp+12]      ; bit

    mov bl, 1
    shl bl, cl            ; 1 << bit

    or byte [eax], bl     ; activar bit

    pop ebp
    ret



; unsigned char get_bit(unsigned char value, unsigned char bit)

get_bit:

    push ebp
    mov ebp, esp

    mov al, [ebp+8]       ; value
    mov cl, [ebp+12]      ; bit

    shr al, cl            ; mover el bit a la derecha

    and al, 1             ; obtener solo 0 o 1

    movzx eax, al         ; retorno limpio

    pop ebp
    ret