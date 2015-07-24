var Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  var grid = [];
  for (var i = 0; i < 8; i++) {
    grid.push(new Array(8));
  }
  grid[3][3] = new Piece("white");
  grid[4][4] = new Piece("white");
  grid[3][4] = new Piece("black");
  grid[4][3] = new Piece("black");

  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  var x = pos[0];
  var y = pos[1];

  this.isValidPos(pos);

  return this.grid[x][y];
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  this.validMoves(color).length > 0
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  this.getPiece(pos) === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  this.getPiece(pos) !== undefined;
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  this.hasMove("white") === false && this.hasMove("black") === false;
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  var x = pos[0];
  var y = pos[1];

  if (x > 7 || y > 7 || x < 0 || y < 0) {
    throw "not on board!";
  }
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
function _positionsToFlip (board, pos, color, dir, piecesToFlip) {
  var newPos = [dir[0] + pos[0], dir[1] + pos[1]];

  if (board.isMine(newPos) && piecesToFlip.length > 0) { return piecesToFlip }
  if (!board.isValidPos(newPos) ||
      !board.isOccupied(newPos) ||
      board.isMine(newPos)) { return null; }

  piecesToFlip.push(board.grid[newPos[0]][newPos[1]])

  return _positionsToFlip(board, newPos, color, dir, piecesToFlip);
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)) { throw "not a valid move" }
  this.grid[pos[0]][pos[1]] = new Piece(color);
  var flips = [];
  Board.DIRS.forEach (function (dir) {
    flips.concat(_positionsToFlip(this, pos, color, dir, []));
  })

  flips.forEach (function (pos) {
    this.grid[pos[0]][pos[1]].flip;
  })
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  this.grid.forEach (function (row) {
    rowStr = "";
    row.forEach (function (piece) {
      rowStr += piece.toString;
    })
    console.log(rowStr);
  })
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  var potentialFlips = [];
  Board.DIRS.forEach (function (dir) {
    potentialFlips.concat(_positionsToFlip(this, pos, color, dir, []));
  })
  return !this.isOccupied(pos) && potentialFlips.length > 0;
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  var moves = [];

  for (var i = 0; i < 8; i++) {
    for (var j = 0; j < 8; j++) {
      if (this.validMove([i,j], color)) {
        moves.push([i,j]);
      }
    }
  }

  return moves;
};

module.exports = Board;
