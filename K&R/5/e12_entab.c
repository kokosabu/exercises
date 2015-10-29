#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXLINE 1000

int getline(char line[], int maxline);
void entab(char to[], char from[], int n);

int main(int argc, char *argv[])
{
    int len;
    char line[MAXLINE];
    char entabLine[MAXLINE];
    int i;
    int tabstop = 8;
    int start = 0;

    while (--argc > 0) {
        switch ((*++argv)[0]) {
        case '+':
            tabstop = atoi((*argv)+1);
            break;
        case '-':
            start = atoi((*argv)+1);
            break;
        }
    }

    while ((len = getline(line, MAXLINE)) > 0) {
        strcpy(entabLine, line);
        if (len > start)
            entab(entabLine+len, line+len, tabstop);
        else
            entab(entabLine+start, line+start, tabstop);
        printf("%s", entabLine);
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

void entab(char to[], char from[], int n)
{
    int i, j, k, count;

    for (i = 0, j = 0; from[i] != '\0'; ++i) {
        if (from[i] == ' ') {
            for (count = 1; from[++i] == ' '; ++count)
                ;
            if (n - (j % n) < count) {
                count -= n - (j % n);
                to[j++] = '\t';
            }
            for (; count > n; count -= n) {
                to[j++] = '\t';
            }
            for (; count > 0; --count) {
                to[j++] = ' ';
            }
            --i;
        } else {
            to[j++] = from[i];
        }
    }
    to[j] = from[i];
}
