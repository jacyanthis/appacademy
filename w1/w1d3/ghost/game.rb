require 'byebug'
require 'set'
require_relative 'player.rb'

class Game
  WORD = "ghost"
  attr_accessor :fragment, :players, :current_player
  attr_reader :dictionary, :superghost

  def initialize
    @superghost = ask_game
    @fragment = ""
    @dictionary = create_dictionary
    @players = get_players
    @current_player = players[0]
  end

  def ask_game
    puts "Would you like to play superghost?(y or n)"
    answer = gets.chomp
    return false if answer == 'n'
    true
  end

  def create_dictionary
    dictionary = Set.new
    File.foreach('ghost-dictionary.txt') do |line|
      dictionary << line.chomp
    end
    dictionary
  end

  def get_players
    puts "Please enter the names of the players (commas seperate)"
    create_players(gets.chomp.split(","))
  end

  def create_players(names)
    names.map do |name|
      if name.strip == "computer"
         ComputerPlayer.new(self, name.strip)
      else
        HumanPlayer.new(self, name.strip)
      end
    end
  end

  def run
    play_round until game_over?
    finish_game
  end

  def play_round
    take_turn until dictionary.include?(fragment)
    finish_round
  end

  def game_over?
    players.select { |player| player.status != 'ghost'}.length == 1
  end

  def finish_game
    winner = players.find { |name| name.status != 'ghost'}
    puts "Congratulations, #{winner.name}!"
  end

  def take_turn
    switch_current_player
    side = "end"
    puts "The current fragment is: #{fragment}"
    if !superghost
      puts "#{current_player.name}, please give the next letter."
    else
      puts "#{current_player.name}, would you like to add to the beginning or end?"
      side = gets.chomp
      puts "#{current_player.name}, please give the next letter."
    end
    letter = nil
    if side == "end"
      letter = current_player.get_letter until letter && valid?(letter)
      fragment << letter
    else
      letter = current_player.get_letter until letter && front_valid?(letter)
      fragment.insert(0,letter)
    end
  end

  def front_valid?(letter)
    potential_word = letter + fragment.dup
    dictionary.find{|word| word.include?(potential_word)} ?
    true : (raise_human_error)
  end

  def raise_human_error
    puts "That letter won't lead to a word." if current_player.is_a?(HumanPlayer)
  end

  def valid?(letter)
    potential_word = fragment.dup + letter
    if superghost
      dictionary.find{|word| word.include?(potential_word)} ?
      true : raise_human_error
    else
      dictionary.find{|word| word.start_with?(potential_word)} ?
      true : raise_human_error
    end
  end

  def switch_current_player
    number_of_players = players.length
    new_player_idx = players.index(current_player) + 1
    new_player_idx = 0 if new_player_idx == number_of_players
    self.current_player = players[new_player_idx]
  end

  def finish_round
    puts "#{current_player.name} has completed the word: #{fragment}!"
    add_letter
    puts "#{current_player.name} has now spelled: #{current_player.status}"
    self.fragment = ""
  end

  def add_letter
    current_word = current_player.status
    if current_word == ""
      new_letter_idx = 0
    else
      new_letter_idx = WORD.index(current_word[-1]) + 1
    end
    current_word << WORD[new_letter_idx]
  end
end

# g = Game.new
# g.run
