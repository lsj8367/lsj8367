// 전개연산자는 ...으로 이루어져있으며 배열을 생성할수있음.
/*
var a = [1, 2, 3];
var b = [3, 4];
var c = "끝";

var d = a.concat(b, c);

console.log(d);
*/

//ES6
/*
const a = [1,2,3];
const b = [3,4];
const c = "끝";

const d = [...a, ...b, c];

console.log(d);*/

/*
function Person(name, job){
    this.name = name;
    this.job = job;
}*/

// Person.prototype.print = function(){
//     console.log(this.job + " 직업을 가지고 있는 " + this.name + "씨");
// }

// var lsj = new Person("lsj", "programmer");
// lsj.print();

class Person{
    constructor(name, job){
        this.name = name;
        this.job = job;
    }
    print() {
        console.log(this.job + "직업을 가지고 있는 " + this.name + "씨");
    }
}

var sj = new Person("js", "developer");
sj.print();