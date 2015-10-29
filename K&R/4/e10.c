#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

#define MAXOP  100
#define NUMBER '0'
#define MAXVAL 100
#define BUFSIZE 100

void push(double);
double pop(void);
int getop(char []);
int getch(void);
int getline(char s[], int lim);

double v = 0.0;

int main()
{
    int type;
    double op1, op2;
    char s[MAXOP];

    while ((type = getop(s)) != EOF) {
        switch (type) {
        case NUMBER:
            push(atof(s));
            break;
        case '+':
            push(pop() + pop());
            break;
        case '*':
            push(pop() * pop());
            break;
        case '-':
            op2 = pop();
            op1 = pop();
            if (op1 == 0.0)
                push(op2 * -1);
            else
                push(op1 - op2);
            break;
        case '/':
            op2 = pop();
            if (op2 != 0.0)
                push(pop() / op2);
            else
                printf("error: zero divisor\n");
            break;
        case '%':
            op2 = pop();
            push(fmod(pop(), op2));
            break;
        case 'c':
            op2 = pop();
            op1 = pop();
            v = op2;
            printf("%f\n", op2);
            push(op2);
            push(op1);
            break;
        case 's':
            push(sin(pop())); 
            break;
        case 'e':
            push(exp(pop()));
            break;
        case 'p':
            op2 = pop();
            push(pow(pop(), op2));
            break;
        case 'v':
            push(v);
            break;
        case '\n':
            v = pop();
            printf("\t%.8g\n", v);
            break;
        default:
            printf("error: unknown command %s\n", s);
            break;
        }
    }
    return 0;
}

int sp = 0;
double val[MAXVAL];

void push(double f)
{
    if (sp < MAXVAL)
        val[sp++] = f;
    else
        printf("error: stack full, can't push %g\n", f);
}

double pop(void)
{
    if (sp > 0)
        return val[--sp];
    else
        return 0.0;
}

int getop(char s[])
{
    int i, c;

    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;
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
    return NUMBER;
}

int getch(void)
{
    static char buf[BUFSIZE] = "";
    static int i = 0;

    if (buf[i] == '\0') {
        if (getline(buf, BUFSIZE) <= 0) return EOF;
        i = 0;
    }
    return buf[i++];
}

int getline(char s[], int lim)
{
    int c, i;

    i = 0;
    while (--lim > 0 && (c=getchar()) != EOF && c != '\n')
        s[i++] = c;
    if (c == '\n')
        s[i++] = c;
    s[i] = '\0';
    return i;
}
