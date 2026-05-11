%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
	
    	
        						; que se encuentran en la biblioteca libpc_io.a
%macro FOR 3
    push ecx
    push ebx
    mov ecx,-1
    mov ebx,%1
    .%3:
        inc ecx
        cmp ebx,ecx
        je %%salir
        jmp %2
    %%salir:
    pop ebx
    pop ecx
%endmacro


%macro PROTO_ENTRADA 0
    push ebp
    mov ebp,esp
%endmacro

%macro PROTO_SALIDA 0
    mov esp,ebp
    pop ebp
%endmacro


section	.text
    global _imprimir     
    global _primo   
    global _minimo

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
    push ebp                       ; ebp se mete en la pila dond eya estaba el parametro y el retorno
    mov ebp , esp                  ; ebp apunta al mismo lugar que esp 

    push edx
    push ebx

    cmp dword[ebp+8],2
    je .siprimo

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

_minimo:
    PROTO_ENTRADA

    mov edx,[ebp+8] ;dir inicio arreglo
    mov eax,[edx]   ;arr[0]

    FOR dword[ebp+12],.cuerpo,calcularMinimo
    
    jmp .finminimo

    .cuerpo:
    cmp dword[edx+ecx*4],eax
    jl .intercambiar
    jmp .calcularMinimo

    .intercambiar:
        mov eax,dword[edx+ecx*4]
    jmp .calcularMinimo

    .finminimo:
    PROTO_SALIDA
    ret