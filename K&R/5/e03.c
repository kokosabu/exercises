#include <stdio.h>

void strcat(char *s, char *t);

int main()
{
    char s[1024] = "hoge";
    char t[1024] = "piyo";

    printf("%s%s\n", s, t);
    strcat(s, t);
    printf("%s\n", s);

    return 0;
}

void strcat(char *s, char *t)
{
    while (*s++)
        ;
    s--;
    while (*s++ = *t++)
        ;
}
