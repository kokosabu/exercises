#include <stdio.h>

#define LEN 256

int main()
{
    int c;
    int i;
    int count;
    int printData[LEN];

    for (i = 0; i < LEN; ++i) {
       printData[i] = 0;
    }

    while ((c = getchar()) != EOF) {
        if (c >= 0 && c <= 255) {
            printData[c]++;
        }
    }

    count = 0;
    for (i = 0; i < LEN; ++i) {
        if (printData[i] > count)
            count = printData[i];
    }

    for (;count > 0; --count) {
        for (i = 0; i < LEN; ++i) {
            if (printData[i] >= count) {
                printf("%3c", '*');
            } else if (printData[i] == 0) {
                ;
            } else {
                printf("   ");
            }
        }
        puts("");
    }

    for (i = 0; i < LEN; ++i) {
        if (printData[i] != 0) {
            printf("%3c", i);
        }
    }
    puts(""); 

    return 0;
}
