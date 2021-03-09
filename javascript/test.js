/*
function foo() {
    if(true){
        var a = 'bar';
    }
    console.log(a);
}

// var a는 foo함수에서 전역으로 영향있음.
// 그래서 변수 밖에서도 접근이 가능하다.

function foo() {
    if(true) {
        let a = 'bar';
        // scope 내에서만 유효하다.
    }
    //console.log(a); //오류발생
}

foo();
*/

/*
let foo = 1;
foo = 2;

console.log(foo);

const bar = 1;
*/

//bar = 2;
//const 상수는 자바의 final같은 변수로 값 변경 불가

//=========== 화살표 함수 ===========

// var a = function() {
//     console.log("function");
// }

// a();

// const b = () => {
//     console.log("arrow function");
// }
// b();

const print = text => {
    console.log(text);
}
//파라미터가 1개일땐 괄호 생략 가능
print('a');

const sum = (a, b) => (a + b)
//간단한 표현식만을 반환 할 때는 return 생략 가능

function Foo() {
    this.func1 = function() {
        console.log(this);
        // this === Foo
    }

    this.func2 = function() {
        var func3 = function() {
            console.log(this);
            //this === Window(global) 전역변수
        }
        func3();
    }
}

var foo = new Foo();
foo.func1();
foo.func2();
// this의 여러가지의미

this.func2 = function() {
    var that = this;

    var func3 = function() {
        console.log(that);
        //that = Foo
    }
    func3();
}