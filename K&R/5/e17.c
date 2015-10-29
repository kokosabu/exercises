#include <stdio.h>
#include <string.h>

#define MAXLINES 5000
#define MAXFILED 10
char *lineptr[MAXLINES];

int readlines(char *lineptr[], int nlines);
void writelines(char *lineptr[], int nlines);

void qsort(void *lineptr[], int left, int right, int flag[], int len[],
           int num, int (*comp[])(void *, void *));
int numcmp(char *, char *);
int dircmp(char *, char *);

int main(int argc, char *argv[])
{
    int i;
    int nlines;
    int (*cmp[MAXFILED])(void *, void *);
    int numeric[MAXFILED];
    int directory[MAXFILED];
    int flag[MAXFILED];
    int len[MAXFILED];
    int start;
    int fieldcnt = 0;

    for (i = 0; i < MAXFILED; i++) {
        numeric[i] = 0;
        directory[i] = 0;
        flag[i] = 0;
    }

    for (i = 1; i < argc; i++, fieldcnt++) {
        if(argv[i][0] == '-') {
            if(strchr(argv[i], 'n') != NULL) {
                numeric[fieldcnt] = 1;
            }
            if(strchr(argv[i], 'd') != NULL) {
                if (numeric[fieldcnt]) {
                    fprintf(stderr, "Error\n");
                    exit(-1);
                }
                directory[fieldcnt] = 1;
            }
            if(strchr(argv[i], 'r') != NULL) {
                flag[fieldcnt] += 1;
            }
            if(strchr(argv[i], 'f') != NULL) {
                flag[fieldcnt] += 2;
            }
            i++;
        }

        if (numeric[fieldcnt])
            cmp[fieldcnt] = (int (*)(void *, void *))numcmp;
        else if (directory[fieldcnt])
            cmp[fieldcnt] = (int (*)(void *, void *))dircmp;
        else
            cmp[fieldcnt] = (int (*)(void *, void *))strcmp;

        len[fieldcnt] = atoi(argv[i]);
    }

    if ((nlines = readlines(lineptr, MAXLINES)) >= 0) {
        qsort((void **)lineptr, 0, nlines-1, flag,
              len, fieldcnt, cmp);
        writelines(lineptr, nlines);
        return 0;
    } else {
        printf("input too big to sort\n");
        return 1;
    }
}

void qsort(void *v[], int left, int right, int flag[], int len[],
           int num, int (*comp[])(void *, void *))
{
    int i, j, k, last;
    int start;
    void *v1, *v2;
    void swap(void *v[], int, int);

    if (left >= right)
        return;
    swap(v, left, (left + right)/2);
    last = left;

    for (i = left+1; i <= right; i++) {
        start = 0;
        for (k = 0; k < num; k++) {
            v1 = malloc(sizeof(char) * (len[k]+1));
            strncpy(v1, v[i]+start, len[k]);
            v2 = malloc(sizeof(char) * (len[k]+1));
            strncpy(v2, v[left]+start, len[k]);

            if ((flag[k] >> 1)%2 == 1) {
                for (j = 0; j < strlen(v1); j++)
                    ((char *)v1)[j] = toupper(((char *)v1)[j]);
                for (j = 0; j < strlen(v2); j++)
                    ((char *)v2)[j] = toupper(((char *)v2)[j]);
            }

            if ( ((flag[k] % 2) ? -1 : 1) * (*comp[k])(v1, v2) < 0) {
                swap(v, ++last, i);
                free(v1);
                free(v2);
                break;
            }

            free(v1);
            free(v2);
            start += len[k];
        }
    }
    swap(v, left, last);
    qsort(v, left, last-1, flag, len, num, comp);
    qsort(v, last+1, right, flag, len, num, comp);
}
