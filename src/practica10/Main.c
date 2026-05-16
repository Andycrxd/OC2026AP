#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern void set_bit(unsigned char *value, unsigned char bit);
extern unsigned char get_bit(unsigned char value, unsigned char bit);

void update_temp(int *temps);
void update_flags(int *temps, int *last_temps, unsigned char *flags);
void mostrar_estado(unsigned char flag);

int main()
{
    unsigned char banderas[2] = {0,0};

    int ultima_lectura[2] = {25,25};
    int tem_sensores[2] = {25,25};

    int opcion;

    srand(time(NULL));

    do
    {
        printf("\nSENSOR 1: ~ %d °C ", tem_sensores[0]);
        mostrar_estado(banderas[0]);

        printf("\nSENSOR 2: ~ %d °C ", tem_sensores[1]);
        mostrar_estado(banderas[1]);

        printf("\n\n[1] Actualizar");
        printf("\n[2] Salir");
        printf("\nSeleccionar opcion: ");
        scanf("%d",&opcion);

        if(opcion == 1)
        {
            update_temp(tem_sensores);

            update_flags(
                tem_sensores,
                ultima_lectura,
                banderas
            );
        }

    }while(opcion != 2);

    return 0;
}
void update_temp(int *temps)
{
    temps[0] += (rand() % 11) - 5;
    temps[1] += (rand() % 11) - 5;
}

void update_flags(int *temps, int *last_temps, unsigned char *flags)
{
    int i;
    int dif;

    for(i=0; i<2; i++)
    {
        flags[i] = 0;

        dif = temps[i] - last_temps[i];

        if(dif > 0)
        {
            set_bit(&flags[i],5);

            if(dif == 1)
                set_bit(&flags[i],1);

            else if(dif == 2)
                set_bit(&flags[i],2);

            else
                set_bit(&flags[i],3);
        }
        else if(dif < 0)
        {
            set_bit(&flags[i],4);

            if(dif == -1)
                set_bit(&flags[i],1);

            else if(dif == -2)
                set_bit(&flags[i],2);

            else
                set_bit(&flags[i],3);
        }
        else
        {
            set_bit(&flags[i],0);
        }

        last_temps[i] = temps[i];
    }
}