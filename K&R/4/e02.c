#include <stdio.h>

#define MAXLEN 1024

double atof(char s[]);

int main()
{
    char s[MAXLEN];

    while (fgets(s, MAXLEN, stdin) > 0)
        printf("%f\n", atof(s));

    return 0;
}

/*****************************************/

#include <ctype.h>
#include <math.h>

double atof(char s[])
{
    double val, power, e;
    int i, sign, esign;

    for (i = 0; isspace(s[i]); i++)
        ;
    sign = (s[i] == '-') ? -1 : 1;
    if (s[i] == '+' || s[i] == '-')
        i++;
    for (val = 0.0; isdigit(s[i]); i++)
        val = 10.0 * val + (s[i] - '0');
    if (s[i] == '.')
        i++;
    for (power = 1.0; isdigit(s[i]); i++) {
        val = 10.0 * val + (s[i] - '0');
        power *= 10.0;
    }

    if (s[i] == 'e' || s[i] == 'E') {
        i++;
        esign = (s[i] == '-') ? -1 : 1;
        if (s[i] == '+' || s[i] == '-')
            i++;
        for (e = 0.0; isdigit(s[i]); i++)
            e = 10.0 * e + (s[i] - '0');
    }
    return sign * val / power * pow(10, e * esign);
}
