/*
var friends = {
    june: {
        firstName : "June",
        lastName : "Kim",
        number : "010-1111-1234",
        address : ["Dobongu", "Dobong-ro", "117-gil"],
    },
    bill : {
        firstName : "Bill",
        lastName : "Yun",
        number : "010-0000-0000",
        address : ["Dobongu", "Dobong-ro", "117-gil"],
    },
    steve:{
        firstName : "Steve",
        lastName : "Kim",
        number : "010-1111-1234",
        address : ["Dobongu", "Dobong-ro", "117-gil"],
    }
};

var list = function(){
    for(var key in friends){
        console.log(friends[key].firstName);
    }
}
list();

var search = function(name){
    for(var key in friends){
        if(friends[key].firstName === name){
            console.log(friends[key].firstName);
            return friends[key];
        }
    }
}
search("June");*/

var book = {
    _year: 2004,
    edition: 1
};

Object.defineProperty(book, "year", {
    get: function(){
        return this._year;
    },
    set: function(newValue){
        if(newValue > 2004){
            this._year = newValue;
            this.edition += newValue - 2004;
        }
    }
});

book.year = 2005;
console.log(book.year);