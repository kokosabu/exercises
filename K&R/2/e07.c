#include <stdio.h>

unsigned int invert(unsigned int x, int p, int n);

int main()
{
    unsigned int x;

    x = invert(21, 3, 4);
    printf("%u\n", x);

    return 0;
}

unsigned int invert(unsigned int x, int p, int n)
{
    unsigned int mask;

    mask = ~(~0 << n) << (p-n+1);

    return x ^ mask;
}
