// Load the TCP Library
var net = require('net');

var TTT = require("networkttt/index.js");

// Keep track of the chat clients
var clients = [];


// Start a TCP Server
net.createServer(function (socket) {
  if (clients.length > 3) {
    return "too many clients in room";
  }
  if (clients.length === 0) {
    socket.name = "server";
  } else if (clients.length === 1) {
    socket.name = "X";
  } else {
    socket.name = "O";
    var readline = require("readline");

    var readers = [];

    for (var i = 0; i < 3; i++) {
      readers.push(readline.createInterface({
        input: process.stdin,
        output: process.stdout,
        terminal: false
      }));
    }

    new TTT.Game(readers).run(function (winner) {
      broadcast("You win " + winner + "!");
      reader.close();
    });
  }


  // Put this new client in the list
  clients.push(socket);

  // Send a nice welcome message and announce
  broadcast(socket.name + " joined the chat\n", socket);
  socket.write("You are " + socket.name + "\n" + "Enjoy the game!\n");

  // Handle incoming moves from clients.
  socket.on('data', function (data) {
    broadcast(socket.name + "> " + data, socket);
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
