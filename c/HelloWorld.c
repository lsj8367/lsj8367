#include <stdio.h>

int main()
{
    printf("5 * 4 - 10 = 10\n");
    int a = 5, b = 4, c = 10;
    printf("%d * %d - %d = %d\n", a, b, c, a * b - c);
    a = a * b - c;
    printf("a의 메모리[%d] = %d\n", &a, a);

    return 0;
}
