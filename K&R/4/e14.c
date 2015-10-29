#include <stdio.h>

#define swap(t, x, y) {t tmp = x; x = y; y = tmp; }

int main()
{
    int ix = 10;
    int iy = 20;
    double dx = 1.5;
    double dy = 3.4;

    printf("%d %d\n", ix, iy);
    swap(int, ix, iy);
    printf("%d %d\n", ix, iy);

    printf("%f %f\n", dx, dy);
    swap(double, dx, dy);
    printf("%f %f\n", dx, dy);

    return 0;
}
