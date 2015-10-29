#include <stdio.h>
#define MAXLINE 1000

int getline(char line[], int maxline);
void newline(char to[], char from[], int n);

int main()
{
    int len;
    char line[MAXLINE];
    char new[MAXLINE];

    while ((len = getline(line, MAXLINE)) > 0) {
        newline(new, line, 10);
        printf("%s", new);
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

void newline(char to[], char from[], int n)
{
    int i, j, k;
    int count;

    i = 0;
    j = 0;
    k = 0;
    count = 0;

    while (1) {
        if (from[i] != ' ' && from[i] != '\t') {
            ++count;
        }
        ++k;
        to[j++] = from[i++];
        if (from[i] == '\0') {
            break;
        }

        if (k == n) {
            if (k == count - 1) {
                to[j++] = '\n';
            } else {
                i -= n - count;
                j -= n - count;
                to[j++] = '\n'; 
            }
            count = 0;
            k = 0;
        }
    }

    to[j] = from[i];
}
