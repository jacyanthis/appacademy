Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST['pokemonDetail'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.toys(), "remove", this.renderToysList);
  },

  events: {
    "click li.toy-list-item": "selectToyFromList",
  },

  render: function () {
    this.$el.html(this.template({pokemon: this.model}));
    var $toysList = this.$el.find("ul.toys");
    this.model.toys().each(function (toy) {
      var content = JST['toyListItem']({toy: toy});
      $toysList.append(content);
    });
    return this;
  },

  selectToyFromList: function (e) {
    var toyId = $(e.currentTarget).data("toy-id");

    Backbone.history.navigate("pokemon/" + this.model.id + "/toys/" + toyId, {
      trigger: true
    });
  },

  renderToysList: function() {
    this.$el.find(".toys").empty();
    this.model.toys().each(function (toy) {
      this.addToyToList(toy);
    }.bind(this));
  },

  addToyToList: function (toy) {
    var content = JST['toyListItem']({toy: toy});
    $('#pokedex ul.toys').append(content);
  }
});
