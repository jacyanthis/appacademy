(function ($) {
  $.Tabs = function (el) {
    this.$el = $(el);
    var data = this.$el.data("content-tabs");
    this.$contentTabs = $(data);
    this.$activeTab = this.$contentTabs.find(".active");
    this.$el.on('click', 'a', this.clickTab.bind(this));
  };

  $.Tabs.prototype.clickTab = function (e) {
    $("a.active").removeClass("active");
    this.$activeTab.toggleClass("active transitioning");
    this.$activeTab.one("transitionend", function () {
      this.$activeTab.removeClass("transitioning");
      $(e.currentTarget).addClass("active");
      this.$activeTab = $($(e.currentTarget).attr("for"));
      this.$activeTab.addClass("active transitioning");
      setTimeout(function () {
        this.$activeTab.removeClass("transitioning");
      }.bind(this), 0);
    }.bind(this));

  };

  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };
})(jQuery);
