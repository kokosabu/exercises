#include <stdio.h>
#include <math.h>
#include <limits.h>
#include <float.h>

int main()
{
    int i;
    unsigned char uc;
    unsigned short us;
    unsigned int ui;
    unsigned long ul;
    union {
        char s[4];
        float f;
    } u;

    printf("-- 01 --\n");
    printf("signed char    : %11ld - %11ld\n", SCHAR_MIN, SCHAR_MAX);
    printf("unsigned char  : %11lu - %11lu\n", 0, UCHAR_MAX);
    printf("signed short   : %11ld - %11ld\n", SHRT_MIN, SHRT_MAX);
    printf("unsigned short : %11lu - %11lu\n", 0, USHRT_MAX);
    printf("signed int     : %11ld - %11ld\n", INT_MIN, INT_MAX);
    printf("unsigned int   : %11lu - %11lu\n", 0, UINT_MAX);
    printf("signed long    : %11ld - %11ld\n", LONG_MIN, LONG_MAX);
    printf("unsigned long  : %11lu - %11lu\n", 0, ULONG_MAX);
    printf("float          : %11e - %11e\n", FLT_MIN, FLT_MAX);
    printf("double         : %11e - %11e\n", DBL_MIN, DBL_MAX);

    printf("\n\n-- 02 --\n");
    uc = 1;
    for (i = 1; (unsigned char)(uc << i) != 0; i++)
        ;
    printf("signed char    : %11ld - %11ld\n", (long)(pow(2, i-1) * -1), (long)(pow(2, i-1) - 1));
    printf("unsigned char  : %11ld - %11ld\n", (long)(0), (long)(pow(2, i) - 1));

    u.f = FLT_MAX;
    printf("FLT_MAX = %x:%x:%x:%x\n", u.s[0], u.s[1], u.s[2], u.s[3]);
    u.f = FLT_MIN;
    printf("FLT_MIN = %x:%x:%x:%x\n", u.s[0], u.s[1], u.s[2], u.s[3]);

    return 0;
}
