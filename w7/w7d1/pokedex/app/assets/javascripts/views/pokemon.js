Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.refreshPokemon();
    this.$pokeList.on("click", ".poke-list-item", this.selectPokemonFromList.bind(this));
    this.$newPoke.on("submit", this.submitPokemonForm.bind(this));
    this.$pokeDetail.on("click", ".toy-list-item", this.selectToyFromList.bind(this));
    this.$pokeDetail.on("click", "button", this.updatePokemon.bind(this));
    this.$toyDetail.on("change", "select", this.reassignToy.bind(this));
  }
});

Pokedex.Views.Pokemon.prototype.addPokemonToList = function (model) {
  var $listItem = $('<li>').addClass('poke-list-item')
                          .text("Name: " +  model.get("name") + ", Type: " + model.get("poke_type"))
                          .data("id", model.get("id"));
  this.$pokeList.append($listItem);
};

Pokedex.Views.Pokemon.prototype.refreshPokemon = function () {
  this.pokemon.fetch({success: function () {
    this.pokemon.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  }.bind(this)});
};

Pokedex.Views.Pokemon.prototype.renderPokemonDetail = function (pokemon) {
  this.$pokeDetail.empty();
  var $detail = $("<div>").addClass("detail");
  this.$pokeDetail.append($detail);
  var $pokePortrait = $("<img>").attr("src", pokemon.get("image_url"));
  $detail.append($pokePortrait);
  var $pokeStats = $("<form>").addClass("new-pokemon");
  $detail.append($pokeStats);
  _.each(pokemon.attributes, function (val, key) {
    var $div = $("<div>");
    var $label = $("<label>").
      text(key + ": ").
      attr("for", key);
    $div.append($label);

    if (key === "poke_type") {
      var $inputItem = $(".new-pokemon select").clone();
      $inputItem.find("#poke_type_" + pokemon.get("poke_type")).prop("selected", true);
      // debugger;
    } else if (key === "attack" || key === "defense") {
      var $inputItem = $("<input>").attr("type", "number");
      $inputItem.val(pokemon.get(key));
    } else {
      var $inputItem = $("<input>").attr("type", "text");
      $inputItem.val(pokemon.get(key));
    }
    $inputItem.attr("id", key);
    $div.append($inputItem);
    $pokeStats.append($div);
    $pokeStats.append("<button>Update Pokemon</button>");
  });

  this.$pokeDetail.append($("<ul>").addClass("toys"));
  pokemon.fetch({success: function (pokemon) {
    this.renderToysList(pokemon.toys());
  }.bind(this)});
};

Pokedex.Views.Pokemon.prototype.addToyToList = function (toy) {
  var $li = $("<li>").addClass("toy-list-item");
  $li.text("Name: " + toy.get("name") + ", Happiness: " + toy.get("happiness") + ", Price: " + toy.get("price"))
     .data("toy-id", toy.get("id"))
     .data("pokemon-id", toy.get("pokemon_id"));
  this.$pokeDetail.find("ul.toys").append($li);
};

Pokedex.Views.Pokemon.prototype.selectPokemonFromList = function (e) {
  var id = $(e.currentTarget).data("id");
  this.renderPokemonDetail(this.pokemon.get(id));
};

Pokedex.Views.Pokemon.prototype.createPokemon = function (attributes, callback) {
  var newPokemon = new Pokedex.Models.Pokemon(attributes);
  newPokemon.save({}, { success: function (model) {
    this.addPokemonToList(model);
    this.pokemon.add(model);
    callback(model);
    this.$newPoke[0].reset();
  }.bind(this) });
};

Pokedex.Views.Pokemon.prototype.submitPokemonForm = function (e) {
  e.preventDefault();
  var jsFormObject = $(e.currentTarget).serializeJSON();
  this.createPokemon(jsFormObject.pokemon, this.renderPokemonDetail.bind(this));
};

Pokedex.Views.Pokemon.prototype.renderToyDetail = function (toy) {
  this.$toyDetail.empty();
  var $detail = $("<div>").addClass("detail");
  this.$toyDetail.append($detail);
  var $toyPortrait = $("<img>").attr("src", toy.get("image_url"));
  $detail.append($toyPortrait);
  var $toyStats = $("<ul>");
  $detail.append($toyStats);
  Object.keys(toy.attributes).forEach(function (key) {
    if (key === "image_url") {return;}
    var $listItem = $("<li>");
    $listItem.text(key + ": " + toy.get(key));
    $toyStats.append($listItem);
  });
  var $select = $("<select>")
                  .data("pokemon-id", toy.get("pokemon_id"))
                  .data("toy-id", toy.get("id"));
  this.$toyDetail.append($select);
  this.pokemon.each(function (pokemon) {
    var $option = $("<option>")
                    .val(pokemon.get("id"))
                    .text(pokemon.get("name"));
    if (pokemon.id === toy.get("pokemon_id")) {
      $option.prop("selected", true);
    }

    $select.append($option);
  });
};

Pokedex.Views.Pokemon.prototype.selectToyFromList = function (e) {
  var id = $(e.currentTarget).data("toy-id");
  var pokeId = $(e.currentTarget).data("pokemon-id");

  this.renderToyDetail(this.pokemon.get(pokeId).toys().get(id));
};


Pokedex.Views.Pokemon.prototype.reassignToy = function (e) {
  var newPokemonId = $(e.currentTarget).find("option:selected").val();
  var oldPokemonId = $(e.currentTarget).data("pokemon-id");
  var $oldPokemon = this.pokemon.get(oldPokemonId);
  var toyId = $(e.currentTarget).data("toy-id");
  var toy = $oldPokemon.toys().get(toyId);
  toy.set({pokemon_id: newPokemonId});
  toy.save({}, {
    success: function () {
      $oldPokemon.toys().remove(toy);
      this.renderToysList($oldPokemon.toys());
      this.$toyDetail.empty();
    }.bind(this)
  });
};

Pokedex.Views.Pokemon.prototype.renderToysList = function (toys) {
  this.$pokeDetail.find(".toys").empty();
  toys.each(function (toy) {
    this.addToyToList(toy);
  }.bind(this));
};

Pokedex.Views.Pokemon.prototype.updatePokemon = function (e) {
  // e.currentTarget
}
