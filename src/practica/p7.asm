%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

section	.text
	global _start       ;referencia para inicio de programa
	
_start:                   

    ;Mensaje inicial 
    mov edx,msg1
    call puts

    mov edx, cad     ; apuntar al buffer
    mov ax, 64       ; tamaño máximo

    call Capturar

    mov edx, cad
    call puts




    Capturar:
    push edx
    push cx

    mov cx, ax      ; límite
    dec cx          ; dejar espacio para '\0'

.ciclo:
    call getch

    cmp al, 0xA     ; ENTER
    je .fin

    mov [edx], al   ; guardar
    inc edx

    loop .ciclo

.fin:
    mov byte [edx], 0   ; fin de cadena

    pop cx
    pop edx
    ret
   
    
  

    

section	.data
    msg1 db "Ingresa una cadena: ",0
    nlin db 0xa
    len db 64
    cad	times 64 db 0
