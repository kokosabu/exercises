#include <stdio.h>
#define MAXLINE 1000

void squeeze(char s1[], char s2[]);
int getline(char line[], int maxline);

main()
{
    int len;
    char s1[MAXLINE];
    char s2[MAXLINE];

    while ((len = getline(s1, MAXLINE)) > 0) {
        if ((len = getline(s2, MAXLINE)) <= 0) break;
        squeeze(s1, s2);
        printf("%s\n", s1);
    }
    return 0;
}

void squeeze(char s1[], char s2[])
{
    int i, j, k;

    for (i = j = 0; s1[i] != '\0'; i++) {
        for (k = 0; s2[k] != '\0'; k++) {
            if (s1[i] == s2[k])
                break;
        }
        if (s2[k] == '\0')
            s1[j++] = s1[i];
    }
    s1[j] = '\0';
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

