var Board = require("./board.js");
var net = require('net');

var clients = [];

net.createServer(function (socket) {
  if (clients.length > 2) {
    return "too many clients in room";
  }
  if (clients.length === 0) {
    clients.push(socket);
    socket.name = "X";
  } else {
    clients.push(socket);
    socket.name = "O";

    game = new TicTacToeGame(clients);
    game.promptMove();
  }

  // Handle incoming moves from clients.
  socket.on('data', function (data) {
    if (game.currentPlayer === socket) {
      game.receiveMove(data.toString('ascii'));
    } else {
      socket.write("You can't move right now!");
    }
  });

  // Remove the client from the list when it leaves
  socket.on('end', function () {
    clients.splice(clients.indexOf(socket), 1);
    broadcast(socket.name + " left the chat.\n");
  });

  // Send a message to all clients
  function broadcast(message, sender) {
    clients.forEach(function (client) {
      // Don't want to send it to sender
      if (client === sender) return;
      client.write(message);
    });
    // Log it to the server output too
    process.stdout.write(message);
  }

}).listen(5000);

// Put a friendly message on the terminal of the server.
console.log("Chat server running at port 5000\n");


var TicTacToeGame = function (clients) {
  this.clients = clients;
  this.board = new Board();
  this.currentPlayer = clients[0];
};

TicTacToeGame.prototype.promptMove = function () {
  this.currentPlayer.write(this.board.render());
  this.currentPlayer.write("Which move would you like to make, " +
    this.currentPlayer.name + " (e.g. '1, 2')?\n");
};

TicTacToeGame.prototype.receiveMove = function (input) {
  // console.log(input.constructor)
  var strArr = input.split(",");
  var intArr = strArr.map (function (el) {
    return parseInt(el);
  });
  var idx1 = intArr[0];
  var idx2 = intArr[1];

  if (!this.board.makeMove(idx1, idx2, this.currentPlayer.name)) {
    this.currentPlayer.write("Bad move!\n");
    this.promptMove();
  } else if (this.board.isWon(this.currentPlayer.name)) {
    this.broadcast("Congratulations, " + this.currentPlayer.name + " won!");
  } else if (this.board.isDraw()) {
    this.broadcast("Cat won the game!");
  } else {
    this.switchPlayer();
    this.promptMove();
  }
};

TicTacToeGame.prototype.broadcast = function (message) {
  clients.forEach(function (client) {
    client.write(message);
  });
  // Log it to the server output too
  process.stdout.write(message);
};

TicTacToeGame.prototype.switchPlayer = function () {
  this.currentPlayer.write("Waiting on other player\n\n")
  this.currentPlayer = this.currentPlayer.name === "X" ? this.clients[1] : this.clients[0];
};

module.exports = TicTacToeGame;
