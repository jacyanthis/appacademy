(function () {
  $.Zoomable = function (el) {
    this.$el = $(el);
    this.focusBoxSize = 80;
    this.bindMouseEvents();
  };

  $.Zoomable.prototype.bindMouseEvents = function () {
    this.$el.on('mouseover', function (e) {
      if (this.focusBox) { this.focusBox.remove();}
      this.showFocusBox(e);
    }.bind(this));
    this.$el.on('mouseleave', function (e) {
      // debugger
      if (this.focusBox) { this.focusBox.remove();}
    });
  };

  $.Zoomable.prototype.showFocusBox = function (e) {
    this.focusBox = $("<div>").css("height", this.focusBoxSize)
                              .css("width", this.focusBoxSize)
                              .addClass("focus-box");
    this.positionFocusBox(e.pageX, e.pageY);
    this.$el.append(this.focusBox);
  };

  $.Zoomable.prototype.positionFocusBox = function (x, y) {
    if (x < this.focusBoxSize / 2 ) {
      x = (this.focusBoxSize / 2);
    } else if (x > (this.$el.width() - this.focusBoxSize / 2)) {
      x = (this.$el.width() - this.focusBoxSize / 2);
    }

    if (y < this.focusBoxSize / 2 ) {
      y = (this.focusBoxSize / 2);
    } else if (y > (this.$el.height() - this.focusBoxSize / 2)) {
      y = (this.$el.height() - this.focusBoxSize / 2);

    }
    x -= this.focusBoxSize / 2
    y -= this.focusBoxSize / 2
    this.focusBox.css("top", y).css("left", x)
  }

  $.fn.zoomable = function () {
    return this.each(function () {
      new $.Zoomable(this);
    });
  };
})(jQuery);
