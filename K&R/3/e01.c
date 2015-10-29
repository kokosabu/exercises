#include <stdio.h>

#define N 10
#define LOOP 10000000L

int main()
{
    long i, x;
    int v[N] = {1, 2, 3, 5, 7, 9, 11, 16, 18, 22};

/*
    x = binsearch(3, v, N);
    printf("%d\n", x);
    if (x != -1)
        printf("%d\n", v[x]);
*/
    for (i = 0; i < LOOP; ++i) {
        binsearch(3, v, N);
    }

    return 0;
}

int binsearch(int x, int v[], int n)
{
    int low, high, mid;

    low = 0;
    high = n - 1;
    mid = n - 1;
    while (low <= high && v[mid] != x) {
        mid = (low+high) / 2;
        if (x < v[mid])
            high = mid - 1;
        else
            low = mid + 1;
    }

    if (v[mid] == x)
        return mid;
    else 
        return -1;
}
