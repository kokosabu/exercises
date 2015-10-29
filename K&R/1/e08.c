#include <stdio.h>

int main()
{
    int c;
    int ns, nt, nl;

    ns = 0;
    nt = 0;
    nl = 0;
    while ((c = getchar()) != EOF) {
        if (c == ' ')
            ++ns;
        if (c == '\t')
            ++nt;
        if (c == '\n')
            ++nl;
    }

    printf("%d : %d : %d\n", ns, nt, nl);
    return 0;
}
