%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a


section	.text
    global _imprimir     
    global _primo    

_imprimir:
    push ebp
    mov ebp , esp

    mov edx,[ebp+8]    ;PRIMER PARAMETRO
    call puts
    mov edx,[ebp+12]   ;SEGUNDO PARAMETRO
    call puts     

    mov esp, ebp       ;Restaurar el puntero de la pila (libera el espacio reservado para las variables locales)
    pop ebp
    ret  

_primo:
    push ebp
    mov ebp , esp

    push edx
    push ebx

    mov ebx,2
    mov edx,0
    mov eax,dword[ebp+8] 
    div ebx   ; 0:eax / 2
    cmp edx,0
    je .noprimo

    mov ebx,eax   

    .ciclo:
    cmp ebx,2
    jle .siprimo

    mov edx,0
    mov eax,dword[ebp+8]
    div ebx    
    cmp edx,0
    je .noprimo
    dec ebx
    jmp .ciclo

    .noprimo:
    mov eax,0
    jmp .salir
    
    .siprimo:
    mov eax,1

    .salir:  
    pop ebx
    pop edx
    mov esp, ebp       ;Restaurar el puntero de la pila (libera el espacio reservado para las variables locales)
    pop ebp
    ret  

