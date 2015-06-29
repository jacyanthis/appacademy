load 'code.rb'
class Game
  attr_accessor :guesses
  attr_reader :secret_code
  
  def initialize
    @secret_code = Code.random
    @guesses = 0
  end
  
  def play
    puts "Welcome to Mastermind. The colors are red, blue, green, yellow, orange, and purple."
    
    while guesses < 11
      puts "Enter 4 guesses: please type the first letter of your choice color for each peg (e.g., rbgy)."
      player_guess = Code.parse(gets.chomp)
      
      matches = secret_code.matches(player_guess)
      exact_matches, near_matches = matches[0], matches[1]
      
      if exact_matches == 4
        puts "You won!" 
        break
      end
      
      puts "You had #{exact_matches} exact matches and #{near_matches} near matches."
      
      if guesses == 10
        puts "Unfortunately, you lose."
      end
            
      @guesses = guesses + 1
    end
  end
    
end

Game.new.play