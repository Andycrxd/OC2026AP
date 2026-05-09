%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

section	.text
	global _start       ;referencia para inicio de programa
	
; Encontrar el mayor ==============================================================

_start:                   

    mov esi,1
    mov ebx,[arreglo]

    ciclo:

        cmp esi,5
        je salir

        cmp ebx,[arreglo+esi*4]
        jg siesMayor

        ; si no es mayor 
        mov ebx,[arreglo+esi*4]

        add esi,1

        jmp ciclo



        ;si es mayor
        siesMayor:
        add esi,1

        jmp ciclo

      

    salir:

    
	mov	eax, 1	    	; seleccionar llamada al sistema para fin de programa
	mov ebx, 0
    int	0x80        	; llamada al sistema - fin de programa

section	.data

    arreglo	dd  1,7,3,4,5
