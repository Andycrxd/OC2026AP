%include "../../lib/pc_io.inc"

section .text
global _start

_start:

    mov esi,2

ciclo:

    cmp esi,7
    je esPrimo

    mov eax,7
    mov edx,0

    div esi

    cmp edx,0
    je noPrimo

    inc esi
    jmp ciclo

esPrimo:

    mov edx,msgPrimo
    call puts
    jmp salir

noPrimo:

    mov edx,msgNoPrimo
    call puts

salir:

    mov eax,1
    mov ebx,0
    int 80h

section .data

    msgPrimo db "Es primo",10,0
    msgNoPrimo db "No es primo",10,0