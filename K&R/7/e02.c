#include <stdio.h>

int main()
{
    int i;
    int c;

    i = 0;
    while ((c = getchar()) != EOF) {
        i++;
        if (!isprint(c) && c != '\n') {
            printf("0x%x", c);
        } else {
            putchar(c);
        }

        if (c == '\n') {
            i = 0;
        }
        if (i > 40) {
            printf("\n");
            i = 0;
        }
    }

    return 0;
}
