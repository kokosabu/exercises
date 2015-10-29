#include <stdio.h>
#include <stdlib.h>

#define MAXLEN 256

FILE *myfopen(char *filename);

int main(int argc, char *argv[])
{
    FILE *fp1, *fp2;
    char s1[MAXLEN], s2[MAXLEN];
    char *p1, *p2;

    if (argc < 3) {
        fprintf(stderr, "Usage: %s filename1 filename2\n");
        exit(1);
    }

    fp1 = myfopen(argv[1]);
    fp2 = myfopen(argv[2]);

    while ((p1 = fgets(s1, MAXLEN, fp1)) != NULL &&
           (p2 = fgets(s2, MAXLEN, fp2)) != NULL) {
        if (strcmp(s1, s2) != 0) {
            printf("%s : %s", argv[1], s1);
            printf("%s : %s", argv[2], s2);
            exit(0);
        }
    }

    printf("Not Found\n");
    return 0;
}

FILE *myfopen(char *filename)
{
    FILE *fp;

    if ((fp = fopen(filename, "r")) == NULL) {
        fprintf(stderr, "Error\n");
        exit(2);
    }

    return fp;
}
