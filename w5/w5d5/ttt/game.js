var Board = require("./board.js");

var TicTacToeGame = function (readerInterface) {
  this.reader = readerInterface;
  this.board = new Board();
  this.currentPlayer = "X";
};

TicTacToeGame.prototype.promptMove = function (callback) {
  this.board.render();
  this.reader.question("Which move would you like to make, " +
    this.currentPlayer + " (e.g. '1, 2')?\n",
      function (input) {
        var strArr = input.split(",");
        var intArr = strArr.map (function (el) {
          return parseInt(el);
        });
        callback(intArr[0], intArr[1]);
      });
};

TicTacToeGame.prototype.run = function (callback) {
  var that = this;
  this.promptMove(function (idx1, idx2) {
    // console.log(that.currentPlayer)
    if (!that.board.makeMove(idx1, idx2, that.currentPlayer)) {
      console.log("Bad move!");
      that.run(callback);
    } else if (that.board.isWon(that.currentPlayer)) {
      callback(that.currentPlayer);
    } else if (that.board.isDraw()) {
      callback("cat");
    } else {
      that.switchPlayer();
      that.run(callback);
    }
  });
};

TicTacToeGame.prototype.switchPlayer = function () {
  this.currentPlayer = this.currentPlayer === "X" ? "O" : "X";
};

module.exports = TicTacToeGame;
