#include <stdio.h>
#include <ctype.h>
#include "calc.h"

int getch(void);
void ungetch(int);

int getop(char s[])
{
    int i, c;
    int si = EOF;

    if (si != EOF)
        s[0] = c = si;
    else
        s[0] = c = getch();
    while (c == ' ' || c == '\t')
        s[0] = c = getch();

    s[1] = '\0';
    if (!isdigit(c) && c != '.')
        return c;
    i = 0;
    if (isdigit(c))
        while (isdigit(s[++i] = c = getch()))
            ;
    if (c == '.')
        while (isdigit(s[++i] = c = getch()))
            ;
    s[i] = '\0';
    si = c;
    return NUMBER;
}
