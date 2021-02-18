# Call By Value(값에 의한 호출)
call by value 는 가장 일반적인 함수 호출형태로 값을 복사하는 것이다.

예시
```java
public class CallByValue{
    public static void swap(int x, int y){
        int temp = x;
        x = y;
        y = temp;
    }

    public static void main(String[] args){
        int a = 10;
        int b = 20;

        System.out.println("swap() 호출 전 : a = " + a + ", b = " + b);

        swap(a, b);
        System.out.println("swap() 호출 후 : a = " + a + ", b = " + b);
    }
}
```
결과는 아래와 같다
```java
swap() 호출 전 : a = 10, b = 20
swap() 호출 후 : a = 10, b = 20
```
이유는 swap() 메서드 호출 시 사용한 인자 a, b와 swap() 메서드내의 매개변수 x, y는 서로 다르다.
![memory](https://user-images.githubusercontent.com/74235102/108332691-70f54780-7213-11eb-9011-0a1b766a1e63.png)

main()에서 선언 된 변수 a와 b가 각각 메모리의 0x0001번지와 0x0005번지에 할당 되었다고 가정 할당 된 메모리 변수에는 각각 10과 20의 값이 저장된다. 이후, swap() 메서드 호출 시에 사용한 인자 a와 b는 할당 된 메모리 주소가 아닌 메모리에 담겨져 있던 값만이 복사되어 swap() 메서드 내부의 매개변수 x와 y의 메모리 주소에 담겨지게 된다. 당연하게도 swap() 메서드가 수행하는 동안 사용되는 변수들은 main()에 존재하는 a와 b가 아닌 swap() 내부에 새로 생성 된 x와 y이기 때문에 메서드 수행 후에도 결과 값에 변화가 없다.

```
Call By Value는 메서드 호출 시에 사용되는 인자의 메모리에 저장되어 있는 값(value)을
복사하여 보낸다.
```

# Call By Reference
Call by reference는 메서드 호출 시에 사용되는 인자가, 값이 아닌 주소(Address)를 넘겨줌으로써, 주소를 참조(Reference)하여 데이터를 변경할 수 있다.
```java
public class CallByReference{
    int value;

    CallByReference(int value){
        this.value = value;
    }

    public static void swap(CallByReference x, CallByReference y){
        int temp = x.value;
        x.value = y.value;
        y.value = temp;
    }

    public static void main(String[] args){
        CallByReference a = new CallByReference(10);
        CallByReference b = new CallByReference(20);

        System.out.println("swap() 호출 전 : a = " + a.value + ", b = " + b.value);
        
        swap(a, b);

        System.out.println("swap() 호출 후 : a = " + a.value + ", b = " + b.value);
    }
}
```
결과
```
swap() 호출 전 : a = 10, b = 20
swap() 호출 후 : a = 20, b = 10
```
![memory2](https://user-images.githubusercontent.com/74235102/108332747-7f436380-7213-11eb-88be-79fc360ed655.png)

main()에서 선언 된 CallByReference 타입의 변수 a와 b는 각각 객체를 생성하여 0x0001번지와 0x0005번지에 저장된 10과 20의 주소 값을 저장하게 된다. 이후, swap() 메서드 호출 시에 인자 a와 b는 메모리에 저장 된 주소 값을 복사하여 매개변수 x와 y의 메모리에 저장한다. 결국 swap() 메서드는 10과 20이 저장 된 0x0001번지와 0x0005번지의 주소를 참조하여 연산하기 때문에, 연산 결과에 따라 원본 데이터가 변하게 된다. main()에서 선언 된 변수 a와 b는 각각 0x0001번지와 0x0005번지를 가리키고 있기 때문에 변한 데이터를 불러들여 결과 값이 변하게 된다.

```
Call By Reference는 메서드 호출 시 사용되는 인자 값의 메모리에 저장되어 있는 주소(Address)를 복사하여 보낸다.
```