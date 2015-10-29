#include <stdio.h>
#include <string.h>
#include <limits.h>

void itoa(int n, char s[]);
int itoar(int n, char s[], int i);
void reverse(char s[]);

int main()
{
    int n;
    char s[32];

    //n = INT_MIN;
    //n = INT_MAX;
    n = -32;
    printf("%d\n", n);
    itoa(n, s);
    printf("%s\n", s);

    return 0;
}

void itoa(int n, char s[])
{
    int i;

    i = itoar(n, s, 0);
    s[i] = '\0';
}

int itoar(int n, char s[], int i)
{
    if (n < 0) {
        s[i++] = '-';
        n = -n;
    }
    if (n / 10) {
        i = itoar(n/10, s, i);
        s[i] = n % 10 + '0';
        return i + 1;
    } else {
        s[i] = n + '0';
        return i + 1;
    }
}

void reverse(char s[])
{
    int c, i, j;

    for (i = 0, j = strlen(s)-1; i < j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}
