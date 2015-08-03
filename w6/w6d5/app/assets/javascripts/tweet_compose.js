$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$el.on("submit", this.submit.bind(this));
  this.$el.find("textarea").on("input", this.updateCount.bind(this));
  this.$el.find("a.add-mentioned-user").on("click", this.addMentionedUser.bind(this));
  this.$el.find("div.mentioned-users")
         .on("click", "a.remove-mentioned-user", this.removeMentionedUser.bind(this));
};

$.TweetCompose.prototype.addMentionedUser = function (e) {
  var $scriptTag = this.$el.find("script");
  this.$el.find("div.mentioned-users").append($scriptTag.html());
  // debugger;
};

$.TweetCompose.prototype.removeMentionedUser = function (e) {
  // debugger;
  $(e.currentTarget).parent().remove();
};

$.TweetCompose.prototype.submit = function (e) {
  e.preventDefault();
  // debugger
  var $form = $(e.currentTarget);
  var formData = $form.serializeJSON();
  $form.find(":input").prop("disabled", true);

  $.ajax({
    url: "/tweets",
    type: "post",
    data: formData,
    dataType: "json",
    success: this.handleSuccess.bind(this)
  });
};

$.TweetCompose.prototype.updateCount = function (e) {
  this.$el.find("strong")
      .text(140 - this.$el.find("textarea").val().length);
};

$.TweetCompose.prototype.handleSuccess = function (tweet) {
  tweet = $("<li>").text(JSON.stringify(tweet));
  // debugger
  $(this.$el.data("tweets-ul")).prepend(tweet);
  this.clearInput();
  this.$el.find(":input").prop("disabled", false);
};

$.TweetCompose.prototype.clearInput = function () {
  this.$el.find("div.mentioned-users").empty();
  this.$el.find("textarea").val("");
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $("form.tweet-compose").tweetCompose();
});
