#include <stdio.h>
#include <stdarg.h>

void miniprintf(char *fmt, ...);

int main()
{
    miniprintf("%d : %f : %s : %c : %x\n", 10, 10.5, "hoge", '+', 'A');
    return 0;
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
