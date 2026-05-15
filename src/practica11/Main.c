#include <stdio.h>

extern int _fun(int, int);
extern int mul(int,int);
extern int sumamacro(int*,int);
extern int cambio(int,int,int);

int main (void) 
{
    int a=5;
    int b=3;
    int d=38275;

    int arreglo[5] ={1,1,2,3,5};

    printf("\n\rSuma de dos numeros %d\n ", _fun(8,2));
    printf("\n\rLa multiplicaciopn de %d x %d = %d \n",a,b,mul(a,b));

    printf("\n\rLa sumatoria del arreglo es %d\n",sumamacro(arreglo,5)); 

    printf("\n\rCambio de numero %d\n", cambio(d,1,2));



    printf("convertir un numero a binario");
    
    return 0;
}

