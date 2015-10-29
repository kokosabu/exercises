#include <stdlib.h>

int dircmp(char *s1, char *s2)
{
    int v1, v2;

    v1 = 0;
    v2 = 0;

    while (s1 != NULL && s2 != NULL) {
        if (!isalnum(*s1) && *s1 != ' ')
            v1 = 1;
        if (!isalnum(*s2) && *s2 != ' ')
            v2 = 1;

        if (v1 == 1 && v2 == 1)
            return 0;
        if (v1 > v2)
            return 1;
        else if (v1 < v2)
            return -1;

        if (*s1 > *s2)
            return 1;
        else if (*s1 < *s2)
            return -1;
        else {
            s1++;
            s2++;
        }
    }

    if (*s1 > *s2)
        return 1;
    else if (*s1 < *s2)
        return -1;
    else
        return 0;
}
