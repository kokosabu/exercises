#include <stdio.h>
#include <string.h>
#include <limits.h>

void itoa(int n, char s[], int len);
void reverse(char s[]);

int main()
{
    int n;
    char s[32];

    //n = INT_MIN;
    //n = INT_MAX;
    n = 255;
    printf("%d\n", n);
    itoa(n, s, 5);
    printf("'%s'\n", s);
    itoa(n, s, 2);
    printf("'%s'\n", s);

    return 0;
}

void itoa(int n, char s[], int len)
{
    int i, j;
    int c, sign;

    sign = (n < 0) ? 1 : 0;
    i = 0;
    j = 0;
    do {
        c = n % 10;
        if (c < 0)
            c = -c;
        s[i++] = c + '0';
        j++;
    } while ((n /= 10) != 0);
    if (sign) {
        s[i++] = '-';
        j++;
    }
    for(; j < len; j++)
        s[i++] = ' ';
    s[i] = '\0';
    reverse(s);
}

void reverse(char s[])
{
    int c, i, j;

    for (i = 0, j = strlen(s)-1; i< j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}
