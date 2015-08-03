$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  this.followState = this.getFollowedState();
  this.render();
  this.handleClick();
};

$.FollowToggle.prototype.getFollowedState = function (el) {
  if (this.$el.data("initial-follow-state")) {
    return "followed";
  } else {
    return "unfollowed";
  }
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === "following" || this.followState === "unfollowing") {
    this.$el.prop("disabled", true);
    return;
  }
  this.$el.prop("disabled", false);
  var innerHtml = "Follow!";
  if (this.followState === "followed") {
    innerHtml = "Unfollow!";
  }

  this.$el.text(innerHtml);
};

$.FollowToggle.prototype.handleClick = function () {
  this.$el.on("click", function (e) {

    if (this.followState === "followed") {
      this.followState = "following";
      this.render();
      $.ajax({
        url: "/users/" + this.userId + "/follow",
        dataType: "json",
        type: "delete",
        success: function (data, statusText, jqXHR) {
          this.followState = "unfollowed";
          this.render();
        }.bind(this)
      });

    } else {
      this.followState = "unfollowing";
      this.render();
      $.ajax({
        url: "/users/" + this.userId + "/follow",
        type: "post",
        dataType: "json",
        success: function (data, statusText, jqXHR) {
          this.followState = "followed";
          this.render();
        }.bind(this)
      });
    }

  }.bind(this));
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
