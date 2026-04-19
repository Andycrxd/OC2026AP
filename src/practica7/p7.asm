%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    mov edx, msg1
    call puts
    






    ; Salida correcta
    mov eax, 1
    mov ebx, 0
    int 0x80


section .data
    msg1 db "Ingresa una cadena: ",0
    msg2 db 0xA,"Cadena ingresada: ",0
    msg3 db 0xA,"Mayusculas: ",0
    msg4 db 0xA,"Minusculas: ",0

    nlin db 0xA
    len db 64

    cad times 64 db 0