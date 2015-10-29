#include <stdio.h>
#include <string.h>

int getline(char *s, int lim);
void reverse(char *s);

int main()
{
    int i;
    char s[256];

    while ((i = getline(s, 256)) > 0) {
        printf("%d %s", i, s);
        reverse(s);
        printf("%s", s);
    }

    return 0;
}

void reverse(char s[])
{
    int c, i, j;

    for (i = 0, j = strlen(s)-1; i < j; i++, j--) {
        c = *(s+i);
        *(s+i) = *(s+j);
        *(s+j) = c;
    }
}

int getline(char *s, int lim)
{
    int c;
    char *p;

    p = s;

    while (--lim > 0 && (c=getchar()) != EOF && c != '\n')
        *s++ = c;
    if (c == '\n')
        *s++ = c;
    *s = '\0';
    return s - p;
}
