#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include "unistd.h"

int main(int argc, char *argv[])
{
    int fd;
    void filecopy(int ifd, int ofd);

    if (argc == 1)
        filecopy(0, 1);
    else
        while (--argc > 0) {
            if ((fd = open(*++argv, O_RDONLY, 0)) == -1) {
                printf("cat: can't open %s\n", *argv);
                return 1;
            } else {
                filecopy(fd, 1);
                close(fd);
            }
        }

    return 0;
}

void filecopy(int ifd, int ofd)
{
    int n;
    char buf[BUFSIZ];

    while ((n = read(ifd, buf, BUFSIZ)) > 0)
        if (write(ofd, buf, n) != n) {
            write(2, "error", 5);
            exit(1);
        }
}
