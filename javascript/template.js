/*
var name = "Hudi";
var job = "developer";

console.log("제 이름은 " + name + " 이고, 직업은 " + job + " 입니다.");
*/

/// ES6 버전

/*
const name = "Hudi";
const job = "developer";

console.log(`제 이름은 ${name} 이고, ${job} 입니다.`);
*/

/*
var hudi = {
    name : "이승재",
    job : "developer",
    skills : ["Java", "Python", "ES6"]
}

var name = hudi.name;
var job = hudi.job;

console.log(name, job);
*/

const hudi = {
    name : "이승재",
    job : "developer",
    skills : ["ES6", "Java", "Python"]
}

let {name, job} = hudi; //비구조화 할당
// hudi의 name, job 필드를 같은 이름을 가진 변수에 바로 대입해줌

console.log(name, job);

function printSkills({skills}) {
    skills.map((skill) => {
        console.log(skill);
    })
}

printSkills(hudi);

// 배열에서의 비구조화
const languages = ["JavaScript", "Python", "Java", "C#"];
const [first, second, third] = languages;

console.log(first, second, third);
