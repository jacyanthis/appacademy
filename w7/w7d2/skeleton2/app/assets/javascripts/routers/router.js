Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
  },

  pokemonForm: function () {
    var newPokemon = new Pokedex.Models.Pokemon();
    this._pokemonForm = new Pokedex.Views.PokemonForm({
      model: newPokemon,
      collection: this._pokemonIndex.collection
    });
    $('#pokedex .pokemon-form').html(this._pokemonForm.render().$el);
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  pokemonDetail: function (pokemonId, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(function () {
         this.pokemonDetail(pokemonId, callback);
       }.bind(this));

    } else {
      var pokemon = this._pokemonIndex.collection.get(pokemonId);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});
      $("#pokedex .toy-detail").empty();
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      pokemon.fetch({
        success: function () {
          callback && callback();
        }
      });
    }
  },

  toyDetail: function (pokemonId, toyId) {

    if (!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, function (){
        this.toyDetail(pokemonId, toyId);
      }.bind(this));

    } else {
      var toy = this._pokemonDetail.model.toys().get(toyId);
      this._toyDetail = new Pokedex.Views.ToyDetail({
        model: toy,
        collection: this._pokemonIndex.collection
      });
      $("#pokedex .toy-detail").html(this._toyDetail.$el);
      this._toyDetail.render();
    }
  }
});
