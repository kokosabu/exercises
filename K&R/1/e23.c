#include <stdio.h>

#define IN  0
#define OUT 1

int main()
{
    int c;
    int oneStatus;
    int twoStatus;
    int coment;

    oneStatus = OUT;
    twoStatus = OUT;

    while ((c = getchar()) != EOF) {
        if (c == '\'') {
            putchar(c);
            if (oneStatus == OUT) {
                oneStatus = IN;
            } else {
                oneStatus = OUT;
            }
        } else if (c == '"') {
            putchar(c);
            if (twoStatus == OUT) {
                twoStatus = IN;
            } else  {
                twoStatus = OUT;
            }
        } else if (c == '/' && oneStatus == OUT && twoStatus == OUT) {
            c = getchar();
            if (c == EOF) break;
            if (c == '*') {
                while (1) {
                    c = getchar();
                    if (c != '*') continue;
                    c = getchar();
                    if (c == '/') break;
                }
            } else {
                putchar('*');
                putchar(c);
            }
        } else {
            putchar(c);
        }
    }

    return 0;
}
