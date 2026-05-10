%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

section	.text
	global _start       ;referencia para inicio de programa
	
; Haz un ciclo del 5 al 0 ==============================================================

_start:                   


    mov esi,5


    ciclo:
        dec esi


        cmp esi,0
        jne ciclo


    
	mov	eax, 1	    	; seleccionar llamada al sistema para fin de programa
	mov ebx, 0
    int	0x80        	; llamada al sistema - fin de programa

section	.data


