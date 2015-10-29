#include <stdio.h>
#include <string.h>
#define MAXLINE 1000
#define MAX      100

int main(int argc, char *argv[])
{
    FILE *fps[MAX];
    char line[MAXLINE];
    long lineno = 0;
    int c, except = 0, number = 0, found = 0, i = 0;
    char *pattern;

    while (--argc > 0) {
        if ((*++argv)[0] == '-') {
            while (c = *++argv[0])
                switch (c) {
                case 'x':
                    except = 1;
                    break;
                case 'n':
                    number = 1;
                    break;
                default:
                    printf("find: illegal option %c\n", c);
                    argc = 0;
                    found = -1;
                    break;
                }
        } else {
            if ((fps[i] = fopen(*argv, "r")) == NULL) {
                pattern = *argv;
                i--;
            }
            i++;
        }
    }

    if (i == 0) {
        fps[0] = stdin;
        i++;
    }


    if (argc != 0)
        printf("Usage: find -x -n pattern\n");
    else {
        while (--i >= 0) {
            while (fgets(line, MAXLINE, fps[i]) > 0) {
                lineno++;
                if ((strstr(line, pattern) != NULL) != except) {
                    if (number)
                        printf("%ld:", lineno);
                    printf("%s", line);
                    found++;
                }
            }
        }
    }
    return found;
}
