%include "../../lib/pc_io.inc"

section .text
global _start

_start:


    call CapturarArreglo


    call MostrarArreglo

    call OrdenarArreglo

    mov edx,msgorden
    call puts
    
    call MostrarArreglo


    ; salida 
    mov eax, 1
    mov ebx, 0
    int 0x80




;CapturarArreglo=========================================================================================

CapturarArreglo:
    push esi
    push edx
    push ebx


    mov esi, 0  ; inicio del ciclo i=0

    ciclo:
    cmp esi, 5   ;compara si es igual a 5 para salirse
    je terminar

    ; ── Capturar cadena numérica ─────────
    mov edx, msg1   ; copia la  1era direccion 
    call puts       ; inprime el primara direccion de edx asta el caracter nulo

    ; capturar cadena
    movzx ebx, byte [len]
    mov edx, cad
    call capturar

    ;salto de linea------------------
    mov al, [nlin]
    call putchar


    ; convertir a entero---------------
    mov edx, cad
    call ATOI

    ; guardar entero en arreglo
    mov [arreglo + esi*4], eax

    inc esi
    jmp ciclo


    terminar:


    pop ebx
    pop edx
    pop esi

    ret



;===================================================================================================

;MostrarArreglo=========================================================================================

MostrarArreglo:
    push esi
    push eax
    push ebx
    push edx

mov esi, 0

ciclo2:
    cmp esi, 5
    je salir2

    ; salto linea
    mov al, [nlin]
    call putchar

    ; cargar entero
    mov eax, [arreglo + esi*4]

    ; convertir entero a cadena
    mov ebx, eax
    mov edx, buffer
    mov ecx, 64
    call ITOA

    ; imprimir cadena
    mov edx, buffer
    call puts
  

    inc esi
    jmp ciclo2

salir2:



    ; salto linea
    mov al, [nlin]
    call putchar


    pop edx
    pop ebx
    pop eax
    pop esi

    ret


;=======================================================================================================

;OrdenarArreglo=========================================================================================

OrdenarArreglo:

    push eax
    push ebx
    push edx
    push esi
    push edi

    mov esi, 0              ; i = 0

ciclo_externo:

    cmp esi, 4              ; hasta n-2
    jge fin_ordenar

    mov ebx, esi            ; minimo = i

    mov edi, esi
    inc edi                 ; j = i + 1

ciclo_interno:

    cmp edi, 5
    jge intercambio

    ; eax = arreglo[j]
    mov eax, [arreglo + edi*4]

    ; comparar arreglo[j] con arreglo[minimo]
    cmp eax, [arreglo + ebx*4]

    jl nuevo_minimo

continuar:

    inc edi
    jmp ciclo_interno


nuevo_minimo:

    mov ebx, edi
    jmp continuar


intercambio:

    ; si minimo == i no hacer nada
    cmp ebx, esi
    je siguiente_i

    ; temp = arreglo[i]
    mov eax, [arreglo + esi*4]

    ; edx = arreglo[minimo]
    mov edx, [arreglo + ebx*4]

    ; arreglo[i] = arreglo[minimo]
    mov [arreglo + esi*4], edx

    ; arreglo[minimo] = temp
    mov [arreglo + ebx*4], eax


siguiente_i:

    inc esi
    jmp ciclo_externo


fin_ordenar:

    pop edi
    pop esi
    pop edx
    pop ebx
    pop eax

    ret

;=========================================================================================================


; ============================================================================
; Descripción : Imprime el entero en EAX usando ITOA internamente
; Entrada     : EAX = entero a imprimir
; ============================================================================
print_int:
    push eax
    push ebx
    push ecx
    push edx

    mov ebx, eax
    mov edx, tmpbuf
    mov ecx, 32
    call ITOA

    mov edx, tmpbuf
    call puts

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret


; ============================================================================
; Entrada : EDX = dirección de la cadena
; Salida  : EAX = entero con signo
; ============================================================================
ATOI:
    push edx
    push ebx
    push esi

    xor eax, eax   ; se hace asea si mismo en 0 para contrruir el numeorr
    xor esi, esi   ; indice emnpieza en 0 del strring
    mov ebx, 1      ; empieza en 1 es para saber el signo 

.skip_spaces:
    movzx ecx, byte [edx+esi]   ; toma el caracter y lo aguarda ecx
    cmp ecx, ' '                ; compara si teiene espacio
    je .next_space              ; salta en dado caso si es espacio
    cmp ecx, 0x09               ; compara si es un TAB
    je .next_space              ; Salta si es un tab
    jmp .check_sign            ; revisa si es positico o negativo

.next_space:
    inc esi                 ; incrementa el indice
    jmp .skip_spaces        ;salta al inicio y sigue avanzando

.check_sign:
    movzx ecx, byte [edx+esi]   ;  leer carácter actual
    cmp ecx, '-'                ; comparar con '-'
    jne .check_plus             ; si NO es '-', salta
    mov ebx, -1                 ;  SI es '-'  lo aguarda en  EBX = -1
    inc esi                     ; Avanza al siguiente carácter
    jmp .load_digit             ; Se va directo a convertir numeros


; NO es '-' va aqui 
.check_plus:
    cmp ecx, '+'                ; ¿Es '+'?
    jne .load_digit             ; Si NO es '+', salta 
    inc esi                      ;Avanza al siguiente caracter

.load_digit:
    movzx ecx, byte [edx+esi]    ;carácter actual siendo ya el numero
;

;Aquí empieza el ciclo principal
.convert:
    cmp ecx, '0'  ;Si es menor que '0'
    jl .fin        ;   salta si ecx < 0
    cmp ecx, '9'    ; Si es mayor que '9'
    jg .fin

    sub ecx, '0'  ; se le resta -48
    imul eax, eax, 10  ;Multiplica lo que llevas por 10
    add eax, ecx        ;Suma el nuevo dígito

    inc esi                       ;pasa al siguiente caracter
    movzx ecx, byte [edx+esi]     ; carga el siguiente carácter
    jmp .convert                  ;vuelve al inicio del ciclo

.fin:
    cmp ebx, 1   ; SIE SPOSITIVO
    je .salir    ; No  cambia nada 
    neg eax   ; canvia el EAX a EAX = -EAX

.salir:
    pop esi
    pop ebx
    pop edx
    ret


; ============================================================================
; ITOA
; Entrada : EBX = entero, EDX = buffer destino, ECX = longitud
; Salida  : EDX = dirección inicio de cadena
; ============================================================================
ITOA:
    push eax
    push ebx
    push ecx
    push esi
    push edi

    mov edi, edx
    xor esi, esi
    mov eax, ebx

    cmp eax, 0
    jge .es_positivo
    neg eax
    mov byte [edi], '-'
    inc edi

.es_positivo:
    cmp eax, 0
    jne .dividir
    mov byte [edi], '0'
    inc edi
    jmp .terminar

.dividir:
    cmp eax, 0
    je .reversa

    xor edx, edx
    mov ecx, 10
    div ecx
    add dl, '0'
    push edx
    inc esi
    jmp .dividir

.reversa:
    cmp esi, 0
    je .terminar
    pop edx
    mov [edi], dl
    inc edi
    dec esi
    jmp .reversa

.terminar:
    mov byte [edi], 0

    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret


; ============================================================================
; CAPTURAR
; ============================================================================
capturar:
    push edx
    push ecx
    push esi

    movzx ecx, bx    ; copia el tamano que esta en bx osea ebx que es 64 y lo aguarda en  ecx
    dec ecx          ; reduce 1 para el caracter \0
    xor esi, esi     ; indice

.ciclo:
    call getch           ; lee el carcater y lo aguarda en al
    cmp al, 127          ; si le das en la tecla borrar
    jne .verificar       ;salta si no es igual al 
    cmp esi, 0           ; si no ahi nada escrito no borra
    je .ciclo            ;  regresa a ciclo si es igual 0 
    call borrar          ; llama a  la funcion borrar
    dec esi              ; retrocede indice
    jmp .ciclo           ; entra al ciclo devuelta 

.verificar:
    cmp al, 0xA   ; si le das ala tecla enter 
    je .salir     ; termina captura
    call putchar  ; muestra lo que en al
    mov [edx+esi], al    ; guarda el carcater en memoria
    inc esi               ; incrementa esi
    loop .ciclo           ; salta al ciclo 

.salir:
    mov byte [edx+esi], 0  ; caracter final de salida 
    pop esi
    pop ecx
    pop edx
    ret


; ============================================================================
; BORRAR
; ============================================================================
borrar:
    push ax
    mov al, 0x8
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x8
    call putchar
    pop ax
    ret


; ============================================================================
section .data
    msg1 db "Ingresa un numero: ", 0
    msg2 db "ATOI (entero) : ", 0
    msg3 db "ITOA (cadena) : ", 0
    nlin db 0xA
    len  db 64                                              ;  agarra 64 bytes en memoria
    cad  times 64 db 0                          ; arreglo de 64 bytes
    arreglo times 5 dd 0
    msgorden db "Mostrar arreglo ordenado: ", 0

section .bss
    buffer resb 64
    tmpbuf resb 32
    numero resd 1           ; guarda el entero resultado de ATOI