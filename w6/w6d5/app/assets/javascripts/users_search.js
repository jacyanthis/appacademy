$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$users = this.$el.find(".users");
  this.handleInput();
};

$.UsersSearch.prototype.handleInput = function () {
  this.$input.on("input", function (e) {
    $.ajax({
      data: {
        query: this.$input.val()
      },
      url: "/users/search",
      dataType: "json",
      success: function (data) {
        // debugger
        this.$users.empty();
        data.forEach (function (user) {
          var $item = $("<li>");
          $item.append($("<a>").text(user.username).attr("href", "/users/" + user.id));
          this.$users.append($item);
          var $button = $("<button>").addClass("follow-toggle")
                        .data("user-id", user.id)
                        .data("initial-follow-state", user.followed)
                        .followToggle();
          $item.append($button);
        }.bind(this) );
      }.bind(this)
    });
  }.bind(this));
};



$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

$(function () {
  $("div.users-search").usersSearch();
});
