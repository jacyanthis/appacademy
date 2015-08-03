(function ($) {
  $.Carousel = function (el) {
    this.$el = $(el);
    this.activeIdx = 0;
    // this.$el.find(".items img:first-child");

    this.slide("left");
    this.slide("right");
  };

  $.Carousel.prototype.slide = function (dir) {
    $(".slide-" + dir).on("click", function (e) {
      if (this.transitioning) {
        return;
      }
      this.transitioning = true;

      var $oldImg = this.$el.find(".active");
      $oldImg.addClass(this.oppDir(dir));
      this.updateIdx(dir);
      var $currentImg = this.$el.find(".items img").eq(this.activeIdx)
      $currentImg.addClass("active").addClass(dir);

      setTimeout(function () {
        $currentImg.removeClass("left").removeClass("right");
      }, 0);

      $oldImg.one('transitionend', function () {
        $oldImg.removeClass("active")
               .removeClass("left")
               .removeClass("right");
        this.transitioning = false;
      }.bind(this));

    }.bind(this))
  };

  $.Carousel.prototype.oppDir = function (dir) {
    if (dir === "left") {
      return "right";
    } else if (dir === "right") {
      return "left";
    } else {
      console.log("Invalid direction.");
    }
  };

  $.Carousel.prototype.updateIdx = function (dir) {
    if (dir === "left") {
      this.updateIdxLeft();
    } else if (dir === "right") {
      this.updateIdxRight();
    } else {
      console.log("Invalid direction.");
    }
  };

  $.Carousel.prototype.updateIdxRight = function () {
    if (this.activeIdx === this.$el.find(".items img").length - 1) {
      this.activeIdx = 0;
    } else {
      this.activeIdx += 1;
    }
  };

  $.Carousel.prototype.updateIdxLeft = function () {
    if (this.activeIdx === 0) {
      this.activeIdx = this.$el.find(".items img").length - 1;
    } else {
      this.activeIdx -= 1;
    }
  };

  $.fn.carousel = function () {
    return this.each(function () {
      new $.Carousel(this);
    });
  };
})(jQuery);
