#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXBUF 256

int main(int argc, char *argv[])
{
    int i;
    int n;
    char **str;
    char buf[MAXBUF];

    n = 10;
    while (--argc > 0) {
        if ((*++argv)[0] == '-') {
            n = atoi((*argv)+1);
            n = (n < 0) ? 0 : n;
        }
    }

    str = (char **)malloc(sizeof(char *) * n);
    for (i = 0; i < n; i++)
        str[i] = NULL;

    while (fgets(buf, MAXBUF, stdin) != NULL) {
        if (str[0] != NULL)
            free(str[0]);
        for (i = 0; i < n-1; i++)
            str[i] = str[i+1];
        str[i] = (char *)malloc(sizeof(char) * (strlen(buf)+1));
        strcpy(str[i], buf);
    }

    for (i = 0; i < n; i++) {
        if (str[i] != NULL)
            printf("%s", str[i]);
    }

    for (i = 0; i < n; i++)
        free(str[i]);
    free(str);

    return 0;
}
