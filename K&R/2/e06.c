#include <stdio.h>

unsigned int setbits(unsigned int x, int p, int n, unsigned int y);
unsigned int getbits(unsigned int x, int p, int n);

int main()
{
    int i;
    unsigned int x;

    x = 106;
    x = setbits(x, 5, 2, 5);
    printf("%u\n", x);

    return 0;
}

unsigned int setbits(unsigned int x, int p, int n, unsigned int y)
{
    unsigned int set;
    unsigned int mask;

    set = ~(~0 << n) & y;
    mask = ~(~0 << n) << (p-1);
    x = x & ~mask;
    x = x | (set << (p+1-n));
    return x;
}

unsigned int getbits(unsigned int x, int p, int n)
{
    return (x >> (p+1-n)) & ~(~0 << n);
}
