#include <stdio.h>

int main(int argc, char *argv[])
{
    int i, page;
    char s[1024];
    FILE *fp;

    page = 1;
    for (i = 1; i < argc; i++) {
        if ((fp = fopen(argv[i], "r")) == NULL) {
            continue;
        }
        printf("\t%s\n", argv[i]);
        while (fgets(s, 1024, fp) != NULL) {
            printf("%s", s);
        }
        printf("\t%d\n", page);
        page++;
    }

    return 0;
}
