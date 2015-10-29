#include <stdio.h>

void strncpy(char *s, char *t, int n);
void strncat(char *s, char *t, int n);
int strncmp(char *s, char *t, int n);

int main()
{
    int i;
    char s[16] = "123456789";
    char t[16] = "1234707";

    if (strncmp(s, t, 5) == 0) {
        printf("match\n");
    } else if (strncmp(s, t, 5) > 0) {
        printf("s is large\n");
    } else {
        printf("t is large\n");
   }

/*
    strncat(s, t, 2);
    printf("%s\n", s);
*/

/*
    strncpy(s, t, 2);
    for (i = 0; i < 16; i++)
        printf("'%d' : '%c'\n", s[i], s[i]);
    printf("%s\n", s);
*/

    return 0;
}

void strncpy(char *s, char *t, int n)
{
    int i;

    for (i = 0; (*s++ = *t++) && i < n-1; i++)
        ;

    while (i < n-1) {
        *s++ = '\0';
        i++;
    }
}

void strncat(char *s, char *t, int n)
{
    int i;

    while (*s++)
        ;
    s--;

    for (i = 0; (*s++ = *t++) && i < n-1; i++)
        ;
}

int strncmp(char *s, char *t, int n)
{
    int i;

    for (i = 0; (*s == *t) && i < n-1; s++, t++, i++)
        if (*s == '\0')
            return 0;
    return *s - *t;
}
