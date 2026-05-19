%include "../../lib/pc_io.inc"

section .text


global imprimirBinario

imprimirBinario:
	push ebp
	mov ebp,esp
	push ebx
	push ecx
	push edx
	


	mov ebx,[ebp+8]
	mov ecx,[ebp+12]

	dec ecx
	
	ciclo:
		mov edx,ebx
		shr edx,cl
		and edx,1

		add dl,'0'
		
		mov al,dl
		call putchar 

		dec ecx
		cmp ecx,-1
		jne ciclo

		
		pop edx
		pop ecx
		pop ebx
		mov esp,ebp
		pop ebp
		ret