#include <stdio.h>

#define IN   1
#define OUT -1

int main()
{
    int c;
    int Status;
    int coment;

    twoStatus = OUT;

    while ((c = getchar()) != EOF) {
        if (c == '"') {
            putchar(c);
            twoStatus -= -1;
        } else if (c == '/' && Status == OUT) {
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
