#include <stdio.h>
#define MAXLINE 1000

int getline(char line[], int maxline);
void copy(char to[], char from[]);
int delete(char line[]);

int main()
{
    int len;
    char line[MAXLINE];

    while ((len = getline(line, MAXLINE)) > 0) {
        if (delete(line) > -1)
            printf("%s", line);
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

void copy(char to[], char from[])
{
    int i;

    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}

int delete(char line[])
{
    int count;
    int i;

    count = -1;
    for (i = 0; line[i] != '\n'; ++i) {
        if (line[i] != ' ' && line[i] != '\t')
            count = i; 
    }
    if (count != i-1) {
        line[++count] = '\n';
        line[++count] = '\0';
    }

    return count;
}

