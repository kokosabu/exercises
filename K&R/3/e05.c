#include <stdio.h>
#include <string.h>
#include <limits.h>

void itob(int n, char s[], int b);
void reverse(char s[]);

int main()
{
    int n;
    char s[32];

    //n = INT_MIN;
    //n = INT_MAX;
    n = 255;
    printf("%d\n", n);
    itob(n, s, 16);
    printf("%s\n", s);

    return 0;
}

void itob(int n, char s[], int b)
{
    int i, c, sign;

    sign = (n < 0) ? 1 : 0;
    i = 0;
    do {
        c = n % b;
        if (c < 0)
            c = -c;

        if (c >= 0 && c <= 9)
            s[i++] = c + '0';
        else if (c >= 10)
            s[i++] = c + 'a' - 10;
    } while ((n /= b) != 0);
    if (sign)
        s[i++] = '-';
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
