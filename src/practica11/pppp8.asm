%include "../../lib/pc_io.inc"

section .text

global _fun
global mul
global sumamacro
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


mul:
    push ebp
    mov ebp,esp

    mov eax, [ebp+8]
    mov edx, [ebp+12]

    imul eax,edx



    mov esp,ebp
    pop ebp
    ret


%macro suM 2

    push edx
    push esi
    push ecx
    push ebx

    mov eax,0
    mov esi,0
    mov ecx,0

    mov ebx,%1
    mov edx,%2


    ciclo:
        cmp edx,esi
        je salir

        movzx ecx,byte[ebx+esi*4]

        add eax,ecx
        inc esi

        jmp ciclo


    salir:

    pop ebx
    pop ecx
    pop esi
    pop edx

%endmacro

sumamacro:

    push ebp
    mov ebp,esp

    
    suM [ebp+8],[ebp+12]


    
    mov esp,ebp
    pop ebp
    ret














