Pokedex.Views.PokemonIndex = Backbone.View.extend({
  initialize: function() {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "sync", this.render);
  },

  events: {
    'click li.poke-list-item': 'selectPokemonFromList'
  },

  render: function () {
    this.$el.empty();
    var view = this;

    this.collection.each(function (pokemon) {
      view.addPokemonToList(pokemon);
    });

    return this;
  },

  addPokemonToList: function (pokemon) {
    var content = JST['pokemonListItem']({ pokemon: pokemon });
    this.$el.append(content);
  },

  refreshPokemon: function (callback) {
    var view = this;

    this.collection.fetch({ success: function () {
      view.collection.each(function (poke) {
        view.addPokemonToList(poke);
      });

      callback && callback();
    }});

    // this.$el.html(JST['pokemonForm']());
  },

  selectPokemonFromList: function (e) {
    var id = $(e.currentTarget).data("id");
    var pokemon = this.collection.get(id);
    Backbone.history.navigate("pokemon/" + id, { trigger: true });
  }
});
