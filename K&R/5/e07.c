#include <stdio.h>
#include <string.h>

#define MAXLINES 5000
#define MAXLEN    256 

char lineptr[MAXLINES][MAXLEN];

int readlines(char lineptr[][MAXLEN], int nlines);
void writelines(char lineptr[][MAXLEN], int nlines);

void qsort(char lineptr[][MAXLEN], int left, int right);

//int readlines(char *lineptr[], int nlines);
//void writelines(char *lineptr[], int nlines);
//void qsort(char *lineptr[], int left, int right);

main()
{
    int nlines;

    if ((nlines = readlines(lineptr, MAXLINES)) >= 0) {
        qsort(lineptr, 0, nlines-1);
        writelines(lineptr, nlines);
        return 0;
    } else {
        printf("error: input too big to sort\n");
        return 1;
    }
}

int getline(char *, int);

//int readlines(char *lineptr[], int maxlines)
int readlines(char lineptr[][MAXLEN], int maxlines)
{
    int len, nlines;
    char *p, line[MAXLEN];

    nlines = 0;
    while ((len = getline(line, MAXLEN)) > 0)
        if (nlines >= maxlines)
            return -1;
        else {
            line[len-1] = '\0';
            strcpy(lineptr[nlines++], line);
        }
    return nlines;
}

//void writelines(char *lineptr[], int nlines)
void writelines(char lineptr[][MAXLEN], int nlines)
{
    int i;

    for (i = 0; i < nlines; i++)
        printf("%s\n", lineptr[i]);
}

//void qsort(char *v[], int left, int right)
void qsort(char v[][MAXLEN], int left, int right)
{
    int i, last;
    //void swap(char *v[], int i, int j);
    void swap(char v[][MAXLEN], int i, int j);

    if (left >= right)
        return;
    swap(v, left, (left + right)/2);
    last = left;
    for (i = left+1; i <= right; i++)
        if (strcmp(v[i], v[left]) < 0)
            swap(v, ++last, i);
    swap(v, left, last);
    qsort(v, left, last-1);
    qsort(v, last+1, right);
}

//void swap(char *v[], int i, int j)
void swap(char v[][MAXLEN], int i, int j)
{
    //char *temp;
    char temp[MAXLEN];

    strcpy(temp, v[i]);
    strcpy(v[i], v[j]);
    strcpy(v[j], temp);
    //temp = v[i];
    //v[i] = v[j];
    //v[j] = temp;
}

int getline(char s[], int lim)
{
    int c, i;

    for (i=0; i<lim-1 && (c=getchar())!=EOF && c!='\n'; ++i)
        s[i] = c;
    if (c == '\n') {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}
