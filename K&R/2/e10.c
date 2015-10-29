#include <stdio.h>

int lower(int c);

int main()
{
    printf("%c -> %c\n", 'A', lower('A'));
    printf("%c -> %c\n", 'z', lower('z'));
    return 0;
}

int lower(int c)
{
    return (c >= 'A' && c <= 'Z') ? c + 'a' - 'A' : c;
}
