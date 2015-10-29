#include <stdio.h>

int main()
{
    int c, i, count;
    int printData[12];
    for (i = 0; i < 12; ++i)
        printData[i] = 0;

    while ((c = getchar()) != EOF) {
        if (c >= '0' && c <= '9')
            ++printData[c-'0'];
        else if (c == ' ' || c == '\n' || c == '\t')
            ++printData[10];
        else
            ++printData[11];
    }

    for (i = 0; i < 12; ++i) {
        printf("%2d : ", i);
        for (count = 0; count < printData[i]; ++count) {
            putchar('*');
        }
        puts("");
    }

/*
    count = 0;
    for (i = 0; i < 12; ++i) {
        if (printData[i] > count)
            count = printData[i];
    }

    for (;count >= 0; --count) {
        for (i = 0; i < 12; ++i) {
            if (printData[i] >= count) {
                printf("%3c", '*');
            } else {
                printf("   ");
            }
        }
        printf("\n");
    }

    for (i = 0; i < 12; ++i) {
        printf("%3d", i);
    }
    printf("\n");
*/
    return 0;
}
