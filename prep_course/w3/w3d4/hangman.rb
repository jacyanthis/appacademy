require_relative 'human'
require_relative 'computer'

class Hangman
  MISS_LIMIT = 7
  
  attr_accessor :turns, :checker, :guesser, :misses
  def initialize(checker, guesser)
    @misses = 0
    @checker = checker
    @guesser = guesser
  end
  
  def self.start
    puts "Welcome to Hangman!"
    puts "Is the checker a human or a computer?"
    checker = create_player(player_identity)

    puts "Is the guesser a human or a computer?"
    guesser = create_player(player_identity)
    
    game = Hangman.new(checker, guesser)
    game.play
  end
  
  def self.player_identity
    answer = gets.chomp.downcase
    until ["human", "computer"].include?(answer)
      puts "Please enter human or computer."
      answer = gets.chomp.downcase
    end
    answer
  end
  
  def self.create_player(player)
    player == "human" ? Human.new : Computer.new
  end
      
  def play
    @checker.get_word
    @guesser.get_common_words
    puts checker.current_guess
    while @misses < MISS_LIMIT
      if !@checker.guess_correct?(@guesser.get_guess(@checker.current_guess))
        @misses += 1
      end
      puts "#{MISS_LIMIT - @misses} misses left."
      break if @checker.won?
    end
    finished_game
  end
  
  def finished_game
    if @checker.won?
      @checker.write(@checker.current_guess)
      puts "Yay! You won."
    else
      puts "Sorry :( You lose"
    end
  end
  
end

Hangman.start