#include <stdio.h>
#include <ctype.h>

#define MAXLEN 1024

void expand(char s1[], char s2[]);

int main()
{
    char s[MAXLEN] = "-a-z\na-b-c\na-z0-9\na-z-";
    char t[MAXLEN];

    printf("%s\n", s);
    expand(s, t);
    printf("---------------------------------------\n");
    printf("%s\n", t);

    return 0;
}

void expand(char s1[], char s2[])
{
    int c, i, j;

    i = 0;
    j = 0;

    if (s1[i] == '-') {
        s2[j++] = s1[i];
        i++;
    }

    for (; s1[i] != '\0'; i++) {
        if (s1[i] == '-') {
            if (s1[i+1] == '\n' || s1[i+1] == '\0') {
                s2[j++] = s1[i];
            } else if (isalnum(s1[i+1])) {
                for (c = s1[i-1] + 1; c != s1[i+1]; c++) {
                    s2[j++] = c;
                }
                s2[j++] = c;
                i++;
            } else {
                s2[j++] = s1[i];
            }
        } else {
            s2[j++] = s1[i];
        }
    }
    s2[j] = '\0';
}
