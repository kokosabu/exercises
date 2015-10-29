#define NULL      0
#define EOF       (-1)
#define BUFSIZ    1024
#define OPEN_MAX  20

typedef struct _iobuf {
    int  cnt;
    char *ptr;
    char *base;
    int  flag;
    int  fd;
} FILE;
extern FILE _iob[OPEN_MAX];

#define stdin   (&_iob[0])
#define stdout  (&_iob[1])
#define stderr  (&_iob[2])

enum _flags {
    _READ   = 01,
    _WRITE  = 02,
    _UNBUF  = 04,
    _EOF    = 010,
    _ERR    = 020
};

int _fillbuf(FILE *);
int _flushbuf(int, FILE *);
int fflush(FILE *fp);
int fclose(FILE *fp);

#define feof(p)    (((p)->flag & _EOF) != 0)
#define ferror(p)  (((p)->flag & _ERR) != 0)
#define fileno(p)  ((p)->fd)

#define getc(p)    (--(p)->cnt >= 0 \
            ? (unsigned char) *(p)->ptr++ : _fillbuf(p))
#define putc(x, p) (--(p)->cnt >= 0 \
           ? *(p)->ptr++ = (x) : _flushbuf((x),p))

#define getchar()  getc(stdin)
#define putchar(x) putc((x), stdout)

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
        if ((fp->flag & (_READ | _WRITE)) == 0)
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
    fp->flag = (*mode == 'r') ? _READ : _WRITE;
    return fp;
}

/***************************************************************/

#include "unistd.h"

int _fillbuf(FILE *fp)
{
    int bufsize;

    if ((fp->flag&(_READ|_EOF|_ERR)) != _READ)
        return EOF;
    bufsize = (fp->flag & _UNBUF) ? 1 : BUFSIZ;
    if (fp->base == NULL)
        if ((fp->base = (char *) malloc(bufsize)) == NULL)
            return EOF;
    fp->ptr = fp->base;
    fp->cnt = read(fp->fd, fp->ptr, bufsize);
    if (--fp->cnt < 0) {
        if (fp->cnt == -1)
            fp->flag |= _EOF;
        else
            fp->flag |= _ERR;
        fp->cnt = 0;
        return EOF;
    }
    return (unsigned char) *fp->ptr++;
}

/*********************************************************/

FILE _iob[OPEN_MAX] = {
    { 0, (char *) 0, (char *) 0, _READ, 0 },
    { 0, (char *) 0, (char *) 0, _WRITE, 1 },
    { 0, (char *) 0, (char *) 0, _WRITE | _UNBUF, 2 }
};

int main(int argc, char *argv[])
{
    int c;
    FILE *fp;

    while (--argc > 0) {
        fp = fopen(*(++argv), "r");
        if (fp == NULL) continue;
        while ((c = getc(fp)) != EOF)
            putc(c, stdout);
        fclose(fp);
    }
    fflush(stdout);

    return 0;
}

/***********************************************************/

int _flushbuf(int x, FILE *fp)
{
    int bufsize;

    if ((fp->flag & (_WRITE)) != _WRITE)
        return EOF;
    bufsize = (fp->flag & _UNBUF) ? 1 : BUFSIZ;
    if (fp->base == NULL)
        if ((fp->base = (char *) malloc(bufsize)) == NULL)
            return EOF;
    fp->ptr = fp->base;
    bufsize = write(fp->fd, fp->ptr, bufsize);
    *(fp)->ptr++ = x;
    fp->cnt = bufsize-1;
    return bufsize;
}

int fflush(FILE *fp)
{
    int bufsize;

    if ((fp->flag & (_WRITE)) != _WRITE)
        return 0;
    bufsize = (fp->flag & _UNBUF) ? 1 : BUFSIZ;
    if (fp->base == NULL)
        return EOF;
    fp->ptr = fp->base;
    bufsize = write(fp->fd, fp->ptr, bufsize - fp->cnt);
    fp->cnt = bufsize;
    return bufsize;
}

int fclose(FILE *fp)
{
    if (fflush(fp) == EOF)
        return EOF;
    free((void *) fp->base);
    fp->base = NULL;
    fp->ptr = NULL;
    fp->flag = 0;
    return 0;
}
