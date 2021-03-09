var name = "이승재";
var job = "developer";

var hudi = {
    name : name,
    job : job
}

console.log(hudi);


// ES6
const irum = "이승재";
const jikup = "developer";

const aaa = {
    name,
    job
}

console.log(aaa);

var person = {
    name : "이승재",
    getName : function(){
        return this.name;
    }
}

console.log(person.getName());

var person = {
    name : "이승재",
    getName() {
        return this.name;
    }
}
console.log(person.getName());