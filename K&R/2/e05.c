#include <stdio.h>
#define MAXLINE 1000

int any(char s1[], char s2[]);
int getline(char line[], int maxline);

main()
{
    int i;
    int len;
    char s1[MAXLINE];
    char s2[MAXLINE];

    while ((len = getline(s1, MAXLINE)) > 0) {
        if ((len = getline(s2, MAXLINE)) <= 0) break;
        if ((i = any(s1, s2)) != -1)
            printf("%d : %c\n", i, s1[i]);
        else
            printf("ERROR\n");
    }

    return 0;
}

int any(char s1[], char s2[])
{
    int i, j;
    int n;

    n = -1;
    for (i = 0; s1[i] != '\0'; i++) {
        for (j = 0; s2[j] != '\0'; ++j) {
            if (s1[i] == s2[j]) {
                n = i;
                break;
            }
        }
        if (s2[j] != '\0') break;
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
