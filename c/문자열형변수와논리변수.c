#include <stdio.h>
#include <stdbool.h>

int main()
{
    
    char a[5] = {'K', 'O', 'R', 'E', 'A',};
    printf("%c\n", a[1]);
    printf("%s\n", a);
    char b[6] = {'K', 'O', 'R', 'E', 'A', '\0'}; // "\0"은 배열 종료문자
    printf("%s\n", b);
    char c[6] = "KOREA";
    printf("%s\n", c);

//==========================================
    // bool a = false;
    // bool b = 25;
    // printf("%d %d \n", a, 0);
    // printf("%d %d \n", b, true);
    return 0;
}