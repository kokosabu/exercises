#include <stdio.h>

#define IN  0
#define OUT 1

int main()
{
    int c;
    int l, r;
    int lMiddle, rMiddle;
    int lLarge, rLarge;

    l = 0;
    r = 0;
    lMiddle = 0;
    rMiddle = 0;
    lLarge = 0;
    rLarge = 0;

    while ((c = getchar()) != EOF) {
        if (c == '\'') {
            while (1) {
                c = getchar();
                if (c == '\'') break;
                if (c == EOF) { printf("' ERROR\n"); return; }
            }
        } else if (c == '"') {
            while (1) {
                c = getchar();
                if (c == '"') break;
                if (c == EOF) { printf("\" ERROR\n"); return; }
            }
        } else if (c == '/') {
            c = getchar();
            if (c == '*') {
                while (1) {
                    c = getchar();
                    if (c != '*') continue;
                    c = getchar();
                    if (c == '/') break;
                }
            }
        }
        if (c == '(') ++l;
        if (c == ')') ++r;
        if (c == '{') ++lMiddle;
        if (c == '}') ++rMiddle;
        if (c == '[') ++lLarge;
        if (c == ']') ++rLarge;
    }
printf("%d : %d\n", lLarge, rLarge);
    if (l != r)             printf("( = %d : ) = %d\n", l, r);
    if (lMiddle != rMiddle) printf("{ = %d : } = %d\n", lMiddle, rMiddle);
    if (lLarge != rLarge)   printf("[ = %d : ] = %d\n", lLarge, rLarge);

    return 0;
}
