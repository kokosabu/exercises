#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAXTOKEN 100

enum { NAME, PARENS, BRACKETS };

int dcl(void);
int dirdcl(void);

int gettoken(void);
int tokentype;
char token[MAXTOKEN];
char name[MAXTOKEN];
char datatype[MAXTOKEN];
char out[1000];

char *pre[] = {
    "char", "int", "double", "const", NULL
};

main()
{
    int i;

    datatype[0] = '\0';

LOOP:
    while (gettoken() != EOF) {
        for (i = 0; pre[i] != NULL; i++) {
            if (strcmp(token, pre[i]) == 0) {
               sprintf(datatype, "%s%s ", datatype, token);
               token[0] = '\0';
               goto LOOP;
            }
        }

        out[0] = '\0';
        if (dcl() == -1 || tokentype != '\n') {
            printf("syntax error\n");
            while (gettoken() != '\n')
                ;
        }
        printf("%s: %s %s\n", name, out, datatype);
        datatype[0] = '\0';
    }
    return 0;
}

int dcl(void)
{
    int ns;

    ns = 0;
    while (1) {
        if (tokentype == '*')
            ns++;
        else
            break;

        gettoken();
    }

    if(dirdcl() == -1) return -1;
    while (ns-- > 0)
        strcat(out, " pointer to");

    return 0;
}

int dirdcl(void)
{
    int type;

    if (tokentype == '(') {
        if(dcl() == -1) return -1;
        
        if (tokentype != ')')  {
            printf("error: missing )\n");
            return -1;
        }
    } else if (tokentype == NAME)
        strcpy(name, token);
    else {
        printf("error: expected name or (dcl)\n");
        return -1;
    }
    while ((type=gettoken()) == PARENS || type == BRACKETS)
        if (type == PARENS)
            strcat(out, " function returning");
        else {
            strcat(out, " array");
            strcat(out, token);
            strcat(out, " of");
        }

    return 0;
}

int gettoken(void)
{
    int c, getch(void);
    void ungetch(int);
    char *p = token;

    while ((c = getch()) == ' ' || c == '\t')
        ;
    if (c == '(') {
        if ((c = getch()) == ')') {
            strcpy(token, "()");
            return tokentype = PARENS;
        } else {
            ungetch(c);
            return tokentype = '(';
        }
    } else if (c == '[') {
        for (*p++ = c; (*p++ = getch()) != ']'; )
            ;
        *p = '\0';
        return tokentype = BRACKETS;
    } else if (isalpha(c)) {
        for (*p++ = c; isalnum(c = getch()); )
            *p++ = c;
        *p = '\0';
        ungetch(c);
        return tokentype = NAME;
    } else
        return tokentype = c;
}


#define BUFSIZE 100

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
