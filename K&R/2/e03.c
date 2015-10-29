#include <stdio.h>
#define MAXLINE 1000

int htoi(char s[]);
int getline(char line[], int maxline);

main()
{
    int len;
    char line[MAXLINE];

    while ((len = getline(line, MAXLINE)) > 0)
        printf("%d\n", htoi(line));
    return 0;
}

int htoi(char s[])
{
    int i, n;

    if (s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
        i = 2;
    else
        i = 0;

    n = 0;
    for (; s[i] != '\0'; ++i) {
        if (s[i] >= '0' && s[i] <= '9')
            n = (n * 16) + (s[i] - '0');
        if (s[i] >= 'a' && s[i] <= 'f')
            n = (n * 16) + (s[i] - 'a' + 10);
        if (s[i] >= 'A' && s[i] <= 'F')
            n = (n * 16) + (s[i] - 'A' + 10);
    }

    return n;
}

int getline(char s[], int lim)
{
    int c, i;

    for (i = 0; i < lim-1; ++i) {
        if ((c = getchar()) == EOF) break;
        if (c == '\n')              break;
        s[i] = c;
    }

    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}

