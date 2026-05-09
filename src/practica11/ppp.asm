%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

section	.text
	global _start       ;referencia para inicio de programa
	
_start:                   

    mov esi,0
    mov ebx,0

    ciclo:



        cmp esi,5
        je salir



        mov eax,[arreglo+esi*4]
        add ebx,eax
        

        add esi,1
        jmp ciclo

    salir:

	mov	eax, 1	    	; seleccionar llamada al sistema para fin de programa
	int	0x80        	; llamada al sistema - fin de programa

section	.data

    arreglo	dd  1,2,3,4,5
