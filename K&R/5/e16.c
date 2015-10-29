#include <stdio.h>
#include <string.h>

#define MAXLINES 5000
char *lineptr[MAXLINES];

int readlines(char *lineptr[], int nlines);
void writelines(char *lineptr[], int nlines);

void qsort(void *lineptr[], int left, int right, int flag,
           int (*comp)(void *, void *));
int numcmp(char *, char *);
int dircmp(char *, char *);

int main(int argc, char *argv[])
{
    int i;
    int nlines;
    int (*cmp)(void *, void *);
    int numeric = 0;
    int directory = 0;
    int flag = 0;

    for (i = 1; i < argc; i++) {
        if(strcmp(argv[i], "-n") == 0) {
            if (directory) {
                fprintf(stderr, "Error\n");
                exit(-1);
            }
            numeric = 1;
        }
        if(strcmp(argv[i], "-d") == 0) {
            if (numeric) {
                fprintf(stderr, "Error\n");
                exit(-1);
            }
            directory = 1;
        }
        if(strcmp(argv[i], "-r") == 0) {
            if (flag%2 == 0)
                flag += 1;
        }
        if(strcmp(argv[i], "-f") == 0) {
            if ((flag >> 1)%2 == 0)
                flag += 2;
        }
    }

    if (numeric)
        cmp = (int (*)(void *, void *))numcmp;
    else if (directory)
        cmp = (int (*)(void *, void *))dircmp;
    else
        cmp = (int (*)(void *, void *))strcmp;

    if ((nlines = readlines(lineptr, MAXLINES)) >= 0) {
        qsort((void **)lineptr, 0, nlines-1, flag, cmp);
        writelines(lineptr, nlines);
        return 0;
    } else {
        printf("input too big to sort\n");
        return 1;
    }
}

void qsort(void *v[], int left, int right, int flag,
           int (*comp)(void *, void *))
{
    int i, j, last;
    void *v1, *v2;
    void swap(void *v[], int, int);

    if (left >= right)
        return;
    swap(v, left, (left + right)/2);
    last = left;

    for (i = left+1; i <= right; i++) {
        v1 = malloc(sizeof(char) * (strlen(v[i])+1));
        strcpy(v1, v[i]);
        v2 = malloc(sizeof(char) * (strlen(v[left])+1));
        strcpy(v2, v[left]);

        if ((flag >> 1)%2 == 1) {
            for (j = 0; j < strlen(v1); j++)
                ((char *)v1)[j] = toupper(((char *)v1)[j]);
            for (j = 0; j < strlen(v2); j++)
                ((char *)v2)[j] = toupper(((char *)v2)[j]);
        }

        if ( ((flag % 2) ? -1 : 1) * (*comp)(v1, v2) < 0)
            swap(v, ++last, i);

        free(v1);
        free(v2);
    }
    swap(v, left, last);
    qsort(v, left, last-1, flag, comp);
    qsort(v, last+1, right, flag, comp);
}
