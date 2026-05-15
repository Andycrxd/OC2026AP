%include "../../lib/pc_io.inc"

section .text

global _fun


_fun:
    push ebp
    mov ebp,esp
    push ebx

    mov ebx,[ebp+8]
    mov eax,[ebp+12]

    add eax,ebx

    pop ebx
    mov esp,ebp
    pop ebp
    ret




