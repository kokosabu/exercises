#include <stdio.h>

#define TRUE  1
#define FALSE 0

int strend(char *s, char *t);

int main()
{
    char s[64] = "hogepiyo";
    char t[64] = "piyo";

    if (strend(s, t))
        printf("match\n");

    return 0;
}

int strend(char *s, char *t)
{
    int n;

    while (*s++)
        ;
    n = 0;
    while (*t++)
        n++;
    n++;

    while (*--s == *--t && n != 0)
        n--;

    if (n == 0)
        return TRUE;
    else
        return FALSE;
}
