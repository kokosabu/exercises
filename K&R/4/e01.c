#include <stdio.h>
#define MAXLINE 1000

int getline(char line[], int max);
int strindex(char source[], char searchfor[]);
int strrindex(char source[], char searchfor[]);

char pattern[] = "ould";

main()
{
    char line[MAXLINE];
    int found = 0;
    int index;

    while (getline(line, MAXLINE) > 0)
        if ((index = strrindex(line, pattern)) >= 0) {
            printf("%d : %s", index, line);
            found++;
        }
    return found;
}

int strrindex(char s[], char t[])
{
    int i, j, k;
    int index;

    index = -1;
    for (i = 0; s[i] != '\0'; i++) {
        for (j=i, k=0; t[k]!='\0' && s[j]==t[k]; j++, k++)
            ;
        if (k > 0 && t[k] == '\0')
            index = i;
    }
    return index;
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

int strindex(char s[], char t[])
{
    int i, j, k;

    for (i = 0; s[i] != '\0'; i++) {
        for (j=i, k=0; t[k]!='\0' && s[j]==t[k]; j++, k++)
            ;
        if (k > 0 && t[k] == '\0')
            return i;
    }
    return -1;
}
