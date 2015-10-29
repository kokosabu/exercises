#include <stdio.h>

int day_of_year(int year, int month, int day);
void month_day(int year, int yearday, int *pmonth, int *pday);

static char daytab[2][13] = {
    {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
};

int main()
{
    int m, d;

    month_day(1988, 60, &m, &d);
    printf("%d : %d\n", m, d);
    printf("%d\n", day_of_year(1988, m, d));

    month_day(1900, 60, &m, &d);
    printf("%d : %d\n", m, d);
    printf("%d\n", day_of_year(1900, m, d));

    return 0;
}

int day_of_year(int year, int month, int day)
{
    int i, leap;
    char *p;

    if (year < 0)
        return -1;
    leap = year%4 == 0 && year%100 != 0 || year%400 == 0;
    p = daytab[leap];

    if (month < 0 || month > 12)
        return -1;
    for (i = 1; i < month; i++)
        day += *++p;

    return day;
}

void month_day(int year, int yearday, int *pmonth, int *pday)
{
    int i, leap;
    char *p;

    if (year < 0) {
        printf("error\n");
        *pmonth = 1;
        *pday = 1;
        return;
    }
    leap = year%4 == 0 && year%100 != 0 || year%400 == 0;
    p = daytab[leap];

    if (yearday < 1 || yearday > 366) {
        printf("error\n");
        *pmonth = 1;
        *pday = 1;
        return;
    }
    for (i = 1; yearday > *++p; i++)
        yearday -= *p;

    *pmonth = i;
    *pday = yearday;
}
