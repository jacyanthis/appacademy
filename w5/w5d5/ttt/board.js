var Board = function () {
  this.grid = [];
  for (var i = 0; i < 3; i++) {
    this.grid.push([null,null,null]);
  }
};

Board.prototype.getItem = function (idx1, idx2) {
  return this.grid[idx1][idx2];
};

Board.prototype.isValidMove = function (idx1, idx2) {
  if (idx1 >= 0 && idx1 <= 2 && idx2 >= 0 && idx2 <= 2) {
    return this.getItem(idx1, idx2) === null;
  } else {
    return false;
  }
};

Board.prototype.makeMove = function (idx1, idx2, item) {
  if (this.isValidMove(idx1, idx2)) {
    this.grid[idx1][idx2] = item;
    return true;
  } else {
    return false;
  }
};

Board.prototype.render = function () {
  for (var i = 0; i < 3; i++) {
    console.log(JSON.stringify(this.grid[i]));
  }
};


Board.prototype.isWon = function (item) {
  var cols = this.grid.transpose();

  for (var i = 0; i < 3; i++) {
    if (_threeInARow(this.grid[i], item) || _threeInARow(cols[i], item)) {
      return true;
    }
  }

  var diag1 = [this.grid[0][0], this.grid[1][1], this.grid[2][2]];
  var diag2 = [this.grid[0][2], this.grid[1][1], this.grid[2][0]];
  if (_threeInARow(diag1, item) || _threeInARow(diag2, item)) {
    return true;
  }

  return false;
};

function _threeInARow(array, item) {
  return JSON.stringify(array) === JSON.stringify([item, item, item]);
}

Board.prototype.isDraw = function () {
  var merged = [];
  merged = merged.concat.apply(merged, this.grid);
  return merged.indexOf(null) === -1;
}

Array.prototype.transpose = function () {
  var that = this;
  var cols = this.map(function(row, idx) {
    return that.map(function(row) {
      return row[idx];
    });
  });

  return cols;
};

module.exports = Board;
