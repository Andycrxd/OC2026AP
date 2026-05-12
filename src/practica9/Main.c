#include <stdio.h>

extern void _imprimir(char*,char*);
extern int _primo(int);
extern int _minimo(int*,int);
extern int _maximo(int*,int);
extern int _sumatoria(int*,int);

int primoC(int numero);

int main ( void ) 
{
    char* str = "Hola mundo. \n";
    printf("%s", str);
    
    asm (
    ".intel_syntax noprefix;"
    "mov ax, '*';"
    "push edx;"
    "push ecx;"
    "push ebx;"
    "push eax;"

    "mov eax, 4;"
    "mov ebx, 1;"
    "mov ecx, esp;"
    "mov edx, 1;"
    "int 0x80;"

    "pop eax;"
    "pop ebx;"
    "pop ecx;"
    "pop edx;"
    ".att_syntax prefix;"     
    );
    
    
    _imprimir("\nABC","\nDEF");
    _imprimir("\nDEF","\nABC");
    _imprimir("\nDEF","\nABC");
    
    printf("ES PRIMO: %d\n", _primo(3));
    printf("ES PRIMO: %d\n", _primo(2));
    printf("ES PRIMO: %d\n", _primo(1));


    int arr[5] = {0,6,1,-2,3};
    printf("\n\rEl numero menor del arreglo es: %d",_minimo(arr,5));
    printf("\n\rEl numero mayor del arreglo es: %d",_maximo(arr,5));

    printf("\n\rLa sumatoria de todos los elementos del arreglo: %d",_sumatoria(arr,5));


    
    
    printf("\n\n\r");
    return 0;
}


int primoC(int numero)
{
    int div;
    if(numero % 2 == 0)
        return 0;
    div = numero / 2 ;
    while(div>2)
    {
        if(numero % div == 0)
            return 0;
        div--;
    }
    return 1;
}