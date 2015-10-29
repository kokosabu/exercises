#include <stdio.h>

#define N 10
#define LOOP 10000000L

int main()
{
    long i, x;
    int v[N] = {1, 2, 3, 5, 7, 9, 11, 16, 18, 22};

    for (i = 0; i < LOOP; ++i) {
        binsearch(3, v, N);
    }

    return 0;
}

int binsearch(int x, int v[], int n)
{
    int low, high, mid;

    low = 0;
    high = n -1;
    while (low <= high) {
        mid = (low+high) / 2;
        if (x < v[mid])
            high = mid - 1;
        else if (x > v[mid])
            low = mid + 1;
        else
            return mid;
    }
    return -1;
}
