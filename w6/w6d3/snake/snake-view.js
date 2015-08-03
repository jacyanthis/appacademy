(function () {
  if (typeof Snakes === "undefined") {
    window.Snakes = {};
  }

  var View = Snakes.View = function ($el) {
    this.board = new Snakes.Board();
    // console.log("board is " + this.board);
    this.$el = $el;
    this.render();
    this.buildListener.call(this);
    var view = this;
    setInterval(this.step.bind(view), 500);
  };

  View.prototype.render = function () {
    remove(this.$el)
    var art = (this.board.render());
    var arr = art.split("\n");
    arr.forEach(function (row){
      var cssRow = $("<div>");
      row.forEach(function (char){
        var cssChar = $("<div>")
        cssChar.addClass(char);
        cssRow.append(cssChar);
      })
      this.$el
    })
  };

  View.prototype.buildListener = function () {
    console.log(this);
    $('body').on("keydown", this.handleKeyEvent.bind(this));
  };

  View.prototype.handleKeyEvent = function (event) {
    var dir = this.board.snake.dir;
    console.log();
    switch (event.keyCode) {
        case 37:
          if (dir !== "E") { dir = "W"; }
          break;
        case 38:
          if (dir !== "S") { dir = "N"; }
          break;
        case 39:
          if (dir !== "W") { dir = "E"; }
          break;
        case 40:
          if (dir !== "N") { dir = "S"; }
          break;
    }
    this.board.snake.turn(dir);
  };

  View.prototype.step = function () {
    this.board.snake.move();
    this.render();
  };
})();
