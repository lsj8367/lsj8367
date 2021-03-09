#include <stdio.h>
int main()
{
    int a = 30;
    float b = 3.14;
    char c = 'A';
    char d[6] = {'K','O','R','E','A', '\0'};
    printf("%d %f %c %s \n", a, b, c, d);

    //서식 지정자
    /*
    %d - char,short,int - 부호있는 10진 정수
    %ld - long - 부호 있는 10진 정수
    %lld - long long - 부호있는 10진 정수
    %u - unsigned int - 부호없는 10진정수
    %o - unsigned int - 부호없는 8진 정수
    %x, %X - float, double - 부호없는 16진 정수
    %f - float - 10진수 방식의 부동소수점 실수
    %lf - long double, double - 10진수 방식의 부동소수점 실수
    %c - char, short, int - 값에 대응하는 문자
    %s - char*(문자열) - 문자열
    %p - void(주소값) - 포인터 주소 값
    */

    return 0;
}
