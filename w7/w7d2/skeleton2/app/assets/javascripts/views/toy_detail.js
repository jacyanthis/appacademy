Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST['toyDetail'],

  initialize: function() {
  },

  events: {
    'change select#owner-reassignment': 'reassignToy'
  },

  render: function () {
    var content = this.template({
        toy: this.model,
        pokeList: this.collection
      });
    this.$el.html(content);

    return this;
  },

  reassignToy: function(e) {
    var newPokemonId = $(e.currentTarget).find("option:selected").val();
    var oldPokemonId = $(e.currentTarget).data("pokemon-id");
    var toyId = $(e.currentTarget).data("toy-id");

    var $oldPokemon = this.collection.get(oldPokemonId);
    var toy = $oldPokemon.toys().get(toyId);

    toy.set({pokemon_id: newPokemonId});
    toy.save({}, {
      success: function () {
        $("#pokedex .toy-detail").empty();
        $oldPokemon.toys().remove(toy);
      }.bind(this)
    });
  },

});
