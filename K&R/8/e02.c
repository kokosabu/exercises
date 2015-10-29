#define NULL      0
#define EOF       (-1)
#define BUFSIZ    1024
#define OPEN_MAX  20

typedef struct _iobuf {
    int  cnt;
    char *ptr;
    char *base;

    unsigned int is_read : 1;
    unsigned int is_write : 1;
    unsigned int is_unbuf : 1;
    unsigned int is_eof : 1;
    unsigned int is_err : 1;

    int  fd;
} FILE;
extern FILE _iob[OPEN_MAX];

#define stdin   (&_iob[0])
#define stdout  (&_iob[1])
#define stderr  (&_iob[2])

int _fillbuf(FILE *);
//int _flushbuf(int, FILE *);

#define feof(p)    ((p)->is_eof != 0)
#define ferror(p)  ((p)->is_err != 0)
#define fileno(p)  ((p)->fd)

#define getc(p)    (--(p)->cnt >= 0 \
            ? (unsigned char) *(p)->ptr++ : _fillbuf(p))
//#define putc(x, p) (--(p)->cnt >= 0 \
//           ? *(p)->ptr++ = (x) : _flushbuf((x),p))

#define getchar()  getc(stdin)
//#define putchar(x) putc((x), stdout)

/******************************************************************/

#include <fcntl.h>
#include "unistd.h"
#define PERMS 0666

FILE *fopen(char *name, char *mode)
{
    int fd;
    FILE *fp;

    if (*mode != 'r' && *mode != 'w' && *mode != 'a')
        return NULL;
    for (fp = _iob; fp < _iob + OPEN_MAX; fp++)
        if (fp->is_read == 0 || fp->is_write == 0)
            break;
    if (fp >= _iob + OPEN_MAX)
        return NULL;

    if (*mode == 'w')
        fd = creat(name, PERMS);
    else if (*mode == 'a') {
        if ((fd = open(name, O_WRONLY, 0)) == -1)
            fd = creat(name, PERMS);
        lseek(fd, 0L, 2);
    } else
        fd = open(name, O_RDONLY, 0);
    if (fd == -1)
        return NULL;
    fp->fd = fd;
    fp->cnt = 0;
    fp->base = NULL;
    if (*mode == 'r')
        fp->is_read = 1;
    else
        fp->is_write = 1;
    return fp;
}

/***************************************************************/

#include "unistd.h"

int _fillbuf(FILE *fp)
{
    int bufsize;

    if (fp->is_eof == 1 || fp->is_err)
        return EOF;
    bufsize = (fp->is_unbuf) ? 1 : BUFSIZ;
    if (fp->base == NULL)
        if ((fp->base = (char *) malloc(bufsize)) == NULL)
            return EOF;
    fp->ptr = fp->base;
    fp->cnt = read(fp->fd, fp->ptr, bufsize);
    if (--fp->cnt < 0) {
        if (fp->cnt == -1)
            fp->is_eof = 1;
        else
            fp->is_err = 1;
        fp->cnt = 0;
        return EOF;
    }
    return (unsigned char) *fp->ptr++;
}

FILE _iob[OPEN_MAX] = {
    { 0, (char *) 0, (char *) 0, 1, 0, 0, 0, 0, 0 },
    { 0, (char *) 0, (char *) 0, 0, 1, 0, 0, 0, 1 },
    { 0, (char *) 0, (char *) 0, 0, 1, 1, 0, 0, 2 }
};

int main(int argc, char *argv[])
{
    int c;
    FILE *fp;

    while (--argc > 0) {
        fp = fopen(*(++argv), "r");
        if (fp == NULL) continue;
        while ((c = getc(fp)) != EOF)
            ;
    }

    return 0;
}
