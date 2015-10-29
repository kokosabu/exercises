#include <stdio.h>

int main()
{
    int c;

    c = getchar();
    while (c != EOF) {
        putchar(c);
        if (c == ' ') {
            while ((c = getchar()) == ' ')
                ;
        } else {
            c = getchar();
        }
    }

    return 0;
}
