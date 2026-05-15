#include <stdio.h>

extern int _fun(int, int);


int main (void) 
{
  
    printf("\n\rSuma de dos numeros %d\n ", _fun(8,2));
    return 0;
}

