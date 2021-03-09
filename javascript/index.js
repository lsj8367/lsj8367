// var arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
// arr.pop; 배열 뒷부분 값 삭제
// arr.push(5); 배열 뒷부분 값 추가

// arr.unshift(0); 배열 앞부분 값 추가

// arr.shift(); 배열 앞부분 삭제

// arr.splice(3, 2);
// splice(index, 제거할 요소 개수, 배열에 추가될 요소)
// arr.splice(2, 1, "a", "b"); // 2번째 인덱스에서 1개를 제거 후 a,b추가

// var newArr = arr.slice(3, 6); // 3에서 6번째까지 인덱스를 새로운 객체로 만들어줌
// console.log('slice', newArr);

// var arr1 = [1, 2, 3];
// var arr2 = [4, 5, 6];
// var arr3 = arr1.concat(arr2); // 배열 2개 합치기

/*
var isEven = function(value){
    // value가 2의 배수이면 true반환
    return value % 2 === 0;
};
*/

// console.log(arr.every(isEven)); 모든요소가 true 이면 true, 하나라도 false이면 false 반환


/*
var isEven = function(value) {
    //value가 2의 배수이면 true를 반환한다.
    return value % 2 === 0;
}

console.log(arr.some(isEven)); //하나라도 true이면 true 반환
*/

/*
arr.forEach(function(value){ // 배열의 마지막 인덱스까지 반복
    console.log(value);
})
*/

// map 배열의 각 지정된 함수를 실행한 결과로 구성된 새로운 배열을 반환
/*
var isEven = function(value) {
    return value % 2 === 0;
};

var newArr = arr.map(isEven);
console.log(newArr);
*/

//filter 지정된 함수의 결과 값을 true로 만드는 원소들로만 구성된 별도의 배열을 반환
/*
var isEven = function(value) {
    return value % 2 === 0;
};

var newArr = arr.filter(isEven);
console.log(newArr);
*/

//reduce 누산기 및 배열의 각 값에 대해 한값으로 줄도록 적용(전체 합)
/*
var value = arr.reduce(function(previousValue, currentValue, index){
    return previousValue + currentValue;
})
console.log(value);
*/

// reverse 배열의 순서를 뒤바꿈
/*
var arr = [1, 2, 3, 4];
arr.reverse();
console.log(arr);
*/

// ----------------------------------------
//배열의 원소를 알파벳순으로, 또는 지정된 함수에 따른 순서로 정렬한다
//모든 원소를 문자열로 취급해 사전적으로 정렬

/*
var arr = [13, 12, 11, 10, 5, 3, 2, 1];
arr.sort();
console.log(arr);

//sort에 함수로 정렬
arr.sort(function(a, b){
    return a - b;
})
console.log(arr);
*/

// toString  배열을 문자열으로 반환
// valueOf toString과 비슷하지만 배열을 반환
// join 배열 원소 전부를 하나의 문자열로 합침

var arr = [0,1,2,3,4,5,6,7];

for(var i = 0; i < arr.length; i++){
    // 3시간
    // if (i % 2 === 0){ 
    //     arr[i] = null;
    // }

    // 6시간
    
}
console.log(arr);
