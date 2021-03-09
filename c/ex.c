#include <stdio.h>

void swap(int *a, int *b){
    int temp = *a;
    *a = *b;
    *b = temp;
}

int main()
{
    int a = 3;
    int b = 2;
    printf("%d %d\n", a, b);
    swap(&a, &b);
    printf("%d %d", a, b);
    return 0;
}