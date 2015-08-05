Pokedex.Views.PokemonForm = Backbone.View.extend({
  template: JST['pokemonForm'],

  events: {
    "submit form": "savePokemon"
  },

  render: function() {
    this.$el.html(this.template({
      pokemon: this.model
    }));

    return this;
  },

  savePokemon: function (e) {
    e.preventDefault();
    var json = $(e.currentTarget).serializeJSON();

    this.model.set(json.pokemon);

    this.model.save({}, {
      success: function() {
        this.collection.add(this.model);
        Backbone.history.navigate(
          "pokemon/" + this.model.get("id"),
          {trigger: true}
        );
        this.model = new Pokedex.Models.Pokemon();
        this.render();
      }.bind(this)
    });
  }
});
