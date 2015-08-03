$.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.$el.find("a.fetch-more").on("click", this.fetchTweets.bind(this));
};

$.InfiniteTweets.prototype.fetchTweets = function (e) {
  $.ajax({
    url: "/feed",
    dataType: "json",
    success: this.insertTweets.bind(this)
  });
};

$.InfiniteTweets.prototype.insertTweets = function (feed) {
  // debugger
  this.$el.find("#feed").append(
    $("<li>").append(JSON.stringify(feed))
  );
};

$.fn.infiniteTweets = function () {
  return this.each(function () {
    new $.InfiniteTweets(this);
  });
};

$(function () {
  $("div.infinite-tweets").infiniteTweets();
});
