#include <stdio.h>
#include <stdarg.h>

void miniprintf(char *fmt, ...);
int miniscanf(char *fmt, ...);

int main()
{
    int i;
    double d;
    char s[128];
    char c;

    miniscanf("%d %f %s %c", &i, &d, s, &c);
    miniprintf("%d : %f : %s : %c : %x\n", i, d, s, c, c);

    return 0;
}

int miniscanf(char *fmt, ...)
{
    va_list ap;
    char *p, *sval;
    int *ival;
    double *dval;
    int i, j, c;
    char s[1024];

    i = 0;
    va_start(ap, fmt);
    for (p = fmt; *p; p++) {
        while (isspace(c = getchar()))
            ;
        ungetc(c, stdin);
        if (*p != '%') {
            continue;
        }
        switch (*++p) {
        case 'c':
            s[0] = getchar();
            s[1] = '\0';
            ival = va_arg(ap, int *);
            sscanf(s, "%c", ival);
            i++;
            break;
        case 'd':
            j = 0;
            while (isdigit(c = getchar()))
                s[j++] = c;
            s[j] = '\0';
            ival = va_arg(ap, int *);
            sscanf(s, "%d", ival);
            i++;
            break;
        case 'f':
            j = 0;
            while (isdigit(c = getchar()) || c == '.')
                s[j++] = c;
            s[j] = '\0';
            dval = va_arg(ap, double *);
            sscanf(s, "%lf", dval);
            i++;
            break;
        case 's':
            j = 0;
            while (!isspace(c = getchar()))
                s[j++] = c;
            s[j] = '\0';
            sval = va_arg(ap, char *);
            sscanf(s, "%s", sval);
            i++;
            break;
        default:
            break;
        }
    }
    va_end(ap);
    return i;
}
void miniprintf(char *fmt, ...)
{
    va_list ap;
    char *p, *sval;
    int ival;
    double dval;

    va_start(ap, fmt);
    for (p = fmt; *p; p++) {
        if (*p != '%') {
            putchar(*p);
            continue;
        }
        switch (*++p) {
        case 'c':
            ival = va_arg(ap, int);
            printf("%c", ival);
            break;
        case 'd':
            ival = va_arg(ap, int);
            printf("%d", ival);
            break;
        case 'f':
            dval = va_arg(ap, double);
            printf("%f", dval);
            break;
        case 's':
            for (sval = va_arg(ap, char *); *sval; sval++)
                putchar(*sval);
            break;
        case 'x':
            ival = va_arg(ap, int);
            printf("%x", ival);
            break;
        default:
            putchar(*p);
            break;
        }
    }
    va_end(ap);
}
