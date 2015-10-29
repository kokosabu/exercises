#include <stdio.h>
#include <string.h>

#define MAXLEN 1024

void reverse(char s[]);
void reverser(char s[], int i, int j);

int main()
{
    char s[MAXLEN];

    while (fgets(s, MAXLEN, stdin) > 0) {
        reverse(s);
        printf("%s\n",s);
    }

    return 0;
}

void reverse(char s[])
{
    reverser(s, 0, strlen(s)-1);
}

void reverser(char s[], int i, int j)
{
    int c;

    if (i < j) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
        reverser(s, i+1, j-1);
    }
}
