#include <stdio.h>
#include <limits.h>

unsigned int rightrot(unsigned int x, int n);

int main()
{
    unsigned int x;

    x = rightrot(5, 1);
    printf("%u\n", x);

    return 0;
}

unsigned int rightrot(unsigned int x, int n)
{
    unsigned int mask;
    unsigned int result;

    mask = ~(~0 << n);
    result = x >> n;
    result = result | ((mask & x) << (sizeof(unsigned int) * CHAR_BIT -n));

    return result;
}
