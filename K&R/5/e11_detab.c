#include <stdio.h>
#include <stdlib.h>
#define MAXLINE 1000

int getline(char line[], int maxline);
void detab(char to[], char from[], int n);

int main(int argc, char *argv[])
{
    int len;
    char line[MAXLINE];
    char detabLine[MAXLINE];
    int i;
    int tabstop = 8;

    while (--argc > 0) {
        switch ((*++argv)[0]) {
        case '+':
            tabstop = atoi(*argv);
            break;
        }
    }

    while ((len = getline(line, MAXLINE)) > 0) {
        detab(detabLine, line, tabstop);
        printf("%s", detabLine);
    }

    return 0;
}

int getline(char s[], int lim)
{
    int c, i;

    for (i=0; i<lim-1 && (c=getchar())!=EOF && c!='\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}

void detab(char to[], char from[], int n)
{
    int i, j, count;

    for (i = 0, j = 0; from[i] != '\0'; ++i) {
        if (from[i] == '\t') {
            count = n - (i % n);
            while (count > 0) {
                to[j++] = ' ';
                count--;
            }
        } else {
            to[j++] = from[i];
        }
    }
    to[j] = from[i];
}
