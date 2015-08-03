(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
  };

  View.prototype.bindEvents = function () {
    var view = this;
    $('.cell').click(function (event) {
      if (!view.game.isOver()) {
        view.makeMove($(event.currentTarget));
      }
    });
  };

  View.prototype.makeMove = function ($square) {
    try {
      this.game.playMove($square.data("pos"));
      $square.removeClass("unclicked");
      $square.addClass(this.game.currentPlayer);
      var p = $("<p>");
      p.text(this.game.currentPlayer);
      $square.append(p);
      if (this.game.isOver()) {
        var footer = $("<footer>");
        footer.text("Congratulations, " + this.game.currentPlayer + "!");
        this.$el.append(footer);
        $(".cell.unclicked").addClass("finished");
        $(".cell").removeClass("unclicked");
        $(".cell." + this.game.currentPlayer).addClass("winner");
      }
    }
    catch(MoveError) {
      alert("Invalid move!");
    }
  };

  View.prototype.setupBoard = function () {
    var grid = $("<ul>");
    grid.addClass("grid");
    for (var i = 0; i < 3; i++) {
      var row = $('<div>');
      row.addClass("row");
      row.addClass("group");
      for (var j = 0; j < 3; j++) {
        var cell = $('<div>');
        row.append(cell);
        cell.addClass("cell");
        cell.addClass("unclicked");
        cell.data("pos", [i, j]);
      }
      grid.append(row);
    }
    this.$el.append(grid);
    this.bindEvents();
  };
})();
