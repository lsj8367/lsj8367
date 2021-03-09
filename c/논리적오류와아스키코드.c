#include <stdio.h>

int main()
{
    int max = 2147483647; //int형 변수 최대값
    printf("%d\n", max);
    max = max + 1; //이미 최대인 값에 1을 더했더니 오버플로우 발생
    printf("%d\n", max);
//============================================================
    char a = 'A';
    char b = a + 1;
    printf("ASCII [%d] = %c\n", a, a);
    printf("ASCII [%d] = %c", b, b);
    
    return 0;
}
