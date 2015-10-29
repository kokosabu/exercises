#include <stdio.h>

int bitcount(unsigned x);

int main()
{
    printf("30 : %2d\n", bitcount(30));
    printf("-1 : %2d\n", bitcount(-1));
    printf(" 5 : %2d\n", bitcount(5));
    return 0;
}

int bitcount(unsigned x)
{
    int b;

    for (b = 0; x != 0; x &= x - 1)
        b++;
    return b;
}
