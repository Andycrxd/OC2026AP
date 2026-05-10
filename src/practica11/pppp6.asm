%include "../../lib/pc_io.inc"  	; incluir declaraciones de procedimiento externos
								; que se encuentran en la biblioteca libpc_io.a

section	.text
	global _start       ;referencia para inicio de programa
	
; Haz un programa que:

;cargue un número en EAX
;lo divida entre 2
;revise EDX
;si EDX=0 → es par
;si no → impar==============================================================

_start:             

	mov eax,10   ; valor divido
	mov ebx,2
	mov edx,0   ; residuo

	div ebx


	cmp edx, 0
	je par
	jmp impar



	par:
	mov edx,msg
	call puts



	impar:






    
	mov	eax, 1	    	; seleccionar llamada al sistema para fin de programa
	mov ebx, 0
    int	0x80        	; llamada al sistema - fin de programa

section	.data
	msg db "Par",10,0