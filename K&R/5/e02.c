#include <stdio.h>
#include <ctype.h>

#define BUFSIZE 100

int getch(void);
void ungetch(int);
int getfloat(double *pn);

int main()
{
    double d;

    while (getfloat(&d) != EOF)
        printf("%f\n", d);

    return 0;
}

int getfloat(double *pn)
{
    double power;
    int c, sign;

    while (isspace(c = getch()))
        ;
    if (!isdigit(c) && c != EOF && c != '+' && c != '-' && c != '.') {
        ungetch(c);
        return 0;
    }
    sign = (c == '-') ? -1 : 1;
    if (c == '+' || c == '-')
        c = getch();
    if (!isdigit(c) && c != '.' && c != EOF) {
        ungetch(c);
        return getfloat(pn);
    }
    for (*pn = 0.0; isdigit(c); c = getch())
        *pn = 10.0 * *pn + (c - '0');

    if (c == '.') {
        c = getch();
        if (!isdigit(c) && c != EOF) {
            ungetch(c);
            return getfloat(pn);
        }
    }

    for (power = 1.0; isdigit(c); c = getch()) {
        *pn = 10.0 * *pn + (c - '0');
        power *= 10.0;
    }
    *pn *= sign / power;

    if (c != EOF)
        ungetch(c);
    return c;
}

char buf[BUFSIZE];
int bufp = 0;

int getch(void)
{
    return (bufp > 0) ? buf[--bufp] : getchar();
}

void ungetch(int c)
{
    if (bufp >= BUFSIZE)
        printf("ungetch: too many charcters\n");
    else
        buf[bufp++] = c;
}
