(function ($) {
  $.Thumbnails = function (el) {
    this.$el = $(el);
    this.$images = this.$el.find('.gutter-images img')
    this.$activeImg = this.$images.eq(0);
    this.activate(this.$activeImg);
    this.gutterIdx = 0;
    this.fillGutterImages();
    this.bindClickHandler();
    this.bindMouseEnter();
    this.bindMouseLeave();
    this.bindNavListener();
  };

  $.Thumbnails.prototype.activate = function ($img) {
    this.$el.find('div.active').empty();
    $displayImg = $img.clone();
    this.$el.find('div.active').append($displayImg);
  };

  $.Thumbnails.prototype.bindClickHandler = function () {
    this.$el.find('.gutter-images').on('click', 'img', function (e) {
      this.$activeImg = $(e.currentTarget);
      this.activate(this.$activeImg);
    }.bind(this));
  };

  $.Thumbnails.prototype.bindMouseEnter = function () {
    this.$el.find('.gutter-images').on('mouseenter', 'img', function (e) {
      this.activate($(e.currentTarget));
    }.bind(this));
  };

  $.Thumbnails.prototype.bindMouseLeave = function () {
    this.$el.find('.gutter-images').on('mouseleave', 'img', function (e) {
      this.activate(this.$activeImg);
    }.bind(this));
  };

  $.Thumbnails.prototype.fillGutterImages = function () {
    this.$el.find('.gutter-images').empty();
    this.$gutterImages = null;
    this.$gutterImages = this.$images.filter(function (i) {
      return (this.gutterIdx <= i) && i < (this.gutterIdx + 5)
    }.bind(this));
    this.$gutterImages.each(function (index, $image) {
      this.$el.find('.gutter-images').append($image);
    }.bind(this));
  };

  $.Thumbnails.prototype.bindNavListener = function () {
    this.$el.find(".nav.left").on("click", function (e) {
      if (this.gutterIdx === 0) {return};
      this.gutterIdx -= 1;
      this.fillGutterImages();
    }.bind(this))

    this.$el.find(".nav.right").on("click", function (e) {
      if (this.gutterIdx === (this.$images.length - 5)) {return};
      this.gutterIdx += 1;
      this.fillGutterImages();
    }.bind(this))
  };

  $.fn.thumbnails = function () {
    return this.each( function () {
      new $.Thumbnails(this);
    });
  };

}(jQuery));
