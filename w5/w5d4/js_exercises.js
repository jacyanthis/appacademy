// Arrays

Array.prototype.myUniq = function () {
  var arr = [];
  this.forEach (function (el) {
    if (arr.indexOf(el) === -1) {
      arr.push(el)
    }
  })
  return arr;
}

Array.prototype.twoSum = function () {
  var matches = [];
  for (var i = 0; i < this.length - 1; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        matches.push([i, j]);
      }
    }
  }
  return matches;
}

Array.prototype.transpose = function () {
  var grid = [];

  for (var i = 0; i < this.length; i++) {
    var new_row = [];
    for (var j = 0; j < this.length; j++) {
      new_row.push(this[j][i])
    }
    grid.push(new_row);
  }
  return grid;
}

Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
}

Array.prototype.myMap = function (callback) {
  var result = [];
  this.myEach(function (el) {
    result.push(callback(el));
  })
  return result;
}

Array.prototype.myInject = function(callback) {
  var accum = this[0];
  this.slice(1).myEach(function (el) {
    accum = callback(accum, el);
  })
  return accum;
}

Array.prototype.bubbleSort = function () {
  var flag = true;
  while(flag) {
    flag = false;
    for (var i = 0; i < this.length - 1; i++) {
     if(this[i] > this[i + 1]) {
       var small = this[i + 1];
       this[i + 1] = this[i];
       this[i] = small;
       flag = true;
     }
    }
  }
  return this;
}

String.prototype.substrings = function () {
  var subs = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      subs.push(this.slice(i, j));
    }
  }
  return subs;
}

function range(start, end) {
  if (start > end) { return []; }
  return [start].concat(range(start + 1, end));
}

function exp1(b, n) {
  if (n === 0) { return 1; }
  return b * exp1(b, n - 1);
}

function exp2(b, n) {
  if (n === 0) { return 1 }
  if (n === 1) { return b }

  if (n % 2 === 0) {
    var temp = exp2(b, n / 2);
    return temp * temp;
  } else {
    var temp = exp2(b, (n - 1) / 2);
    return b * temp * temp;
  }
}

function fibs(n) {
  if (n === 1) { return [1] }
  if (n === 2) { return [1, 1] }
  var temp = fibs(n - 1);
  temp.push(temp[temp.length - 1] + temp[temp.length - 2]);

  return temp;
}

function binarySearch(arr, target) {
  if (arr.length === 0) {
    return null;
  }

  var midindex = Math.floor(arr.length / 2);
  var midpoint = arr[midindex];

  if (midpoint === target) {
    return midindex;
  }
  if (midpoint < target) {
    var result = binarySearch(arr.slice(midindex + 1, arr.length), target);
    if (result === null) {
      return null;
    } else {
      return result + midindex + 1;
    }
  }
  if (midpoint > target) {
    return binarySearch(arr.slice(0, midindex), target);
  }
}


function makeChange(target, coins) {
  var results = makeChangeRec(target, coins);
  var best = results[0];
  for (var j = 1; j < results.length; j++) {
    if (best.length > results[j].length) {
      best = results[j];
    }
  }

  return best;
}

function makeChangeRec(target, coins) {
  if (target === 0) { return [[]]; }
  var results = [];

  for (var i = 0; i < coins.length; i++) {
    if (target >= coins[i]) {
      var recursive_call = makeChangeRec(target - coins[i], coins)
      recursive_call.forEach (function (result) {
        result.push(coins[i]);
        results.push(result);
      })
    }
  }

  return results;
}

function mergeSort(arr) {
  if (arr.length < 2) { return arr }
  var midindex = Math.floor(arr.length / 2);
  var left = arr.slice(0, midindex);
  var right = arr.slice(midindex);

  return merge(mergeSort(left), mergeSort(right));
}

function merge(left, right) {
  if (left.length === 0 || right.length === 0) {
    return left.concat(right);
  }
  if (left[0] < right[0]) {
    var num = [left.shift()];
    return num.concat(merge(left, right));
  } else {
    var num = [right.shift()];
    return num.concat(merge(left, right));
  }
}

function subsets(array) {
  if (array.length === 0) { return [[]] }
  var recursive_call = subsets(array.slice(1));
  var results = [];

  recursive_call.forEach (function (el) {
      results.push(el);
      var new_el = el.slice();
      new_el.push(array[0]);
      results.push(new_el);
  })

  return results;
}

var Cat = function (options) {
  this.name = options["name"];
  this.owner = options["owner"];
}

Cat.prototype.cuteStatement = function () {
  console.log(this.owner + " loves " + this.name);
}

Cat.prototype.meow = function () {
  console.log("meow");
}

var breakfast = new Cat({ name: "Breakfast", owner: "Ned" });
var kitty = new Cat({ name: "Kitty", owner: "Brad" });
breakfast.meow = function () {
  console.log("woem");
}
