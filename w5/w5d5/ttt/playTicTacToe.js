var TTT = require("./index.js");
var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

new TTT.Game(reader).run(function (winner) {
  console.log("You win " + winner + "!");
  reader.close();
});
