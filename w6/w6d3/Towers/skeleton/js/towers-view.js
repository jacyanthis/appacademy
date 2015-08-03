(function () {
  if (typeof Towers === "undefined") {
    window.Towers = {};
  }

  var View = Towers.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.render();
  };

  View.prototype.render = function () {
    this.game.towers.forEach(function (stack, index) {
      var $stack = $(".stack:nth-child(" + (index + 1) + ")");
      for (var i = 0; i < 3 ; i++) {
        var discEl = $(".stack:nth-child(" + (index + 1) + ") .disc:nth-child(" + (3 - i) + ")");
        if (stack[i] === undefined) {
          discEl.addClass("hidden");
          discEl.removeClass("s1");
          discEl.removeClass("s2");
          discEl.removeClass("s3");
        } else {
          discEl.removeClass("hidden");
          discEl.addClass("s" + stack[i]);
        }
      }
    });

  };

  View.prototype.bindEvents = function () {
    var view = this;
    $('.stack').click(function (event) {
      if (!view.game.isWon()) {
        view.clickStack($(event.currentTarget));
      }
    });
  };

  View.prototype.clickStack = function ($stack) {
    if (this.selectedStack) {
      this.makeMove(this.selectedStack, $stack);
      this.selectedStack.removeClass("selected");
      this.selectedStack = null;
      if (this.game.isWon()) {
        var footer = $("<footer>");
        footer.text("Congratulations!");
        this.$el.append(footer);
      }
    } else {
      this.selectedStack = $stack;
      $stack.addClass("selected");
    }
  };

  View.prototype.makeMove = function ($startStack, $endStack) {
    if (this.game.move($startStack.data("idx"), $endStack.data("idx"))) {
      this.render();
    } else {
      alert("Invalid Move");
    }
  };

  View.prototype.setupTowers = function () {
    var towers = $("<ul>");
    towers.addClass("towers");
    towers.addClass("group");
    for (var i = 0; i < 3; i++) {
      var stack = $('<div>');
      stack.addClass("stack");
      stack.data("idx", i);
      towers.append(stack);
      for (var j = 0; j < 3; j++) {
        var disc = $('<div>');
        disc.addClass("disc");
        disc.addClass("hidden");
        disc.data("pos", [i, j]);
        stack.append(disc);
      }
    }
    this.$el.append(towers);
    this.bindEvents();
  };
})();
