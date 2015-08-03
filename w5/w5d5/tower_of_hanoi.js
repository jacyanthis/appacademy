var readline = require("readline");

reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

var HanoiGame = function (stackHeight) {
  this.stacks = [];
  for (var i = 0; i < 3; i++) {
    this.stacks.push([]);
  }

  for (var j = stackHeight; j > 0; j--) {
    this.stacks[0].push(j);
  }
};

HanoiGame.prototype.isWon = function () {
  if (this.stacks[0].length === 0) {
    if (this.stacks[1].length === 0 || this.stacks[2].length === 0) {
      return true;
    }
  }

  return false;
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if (this.stacks[startTowerIdx].length > 0) {
    var startTopIdx = this.stacks[startTowerIdx].length - 1;
    var endTopIdx = this.stacks[endTowerIdx].length - 1;
    return this.stacks[endTowerIdx].length === 0 ||
      this.stacks[startTowerIdx][startTopIdx] < this.stacks[endTowerIdx][endTopIdx];
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].push(this.stacks[startTowerIdx].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();
  reader.question("Which move would you like to make (e.g. '1, 2')?\n",
  function (input) {
    var strArr = input.split(",");
    var intArr = strArr.map (function (el) {
      return parseInt(el);
    });
    callback(intArr[0], intArr[1]);
  });
};

HanoiGame.prototype.run = function (callback) {
  var that = this;
  this.promptMove(function (idx1, idx2) {
    if (!that.move(idx1, idx2)) {
      console.log("Bad move!");
    }
    if (!that.isWon()) {
      that.run(callback);
    } else {
      callback();
    }
  });
};

new HanoiGame(2).run(function () {
  console.log("You win!");
  reader.close();
});
