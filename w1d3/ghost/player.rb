require 'byebug'

class Player
  attr_accessor :status
  attr_reader :name, :game

  def initialize(game, name)
    @game = game
    @name = name
    @status = ""
  end
end

class HumanPlayer < Player
  def get_letter
    gets.chomp
  end

end

class ComputerPlayer < Player
  def get_letter
    fragment = game.fragment
    num_players = game.players.length
    losing_moves = find_losing_moves(fragment)
    winning_move = find_a_winning_move(fragment, num_players)
    winning_move ? winning_move : non_winning_move(losing_moves)
  end

  def find_a_winning_move(fragment, num_players)
    ('a'..'z').to_a.find do |letter|

      possible_words = game.dictionary.select do |word|
        word.start_with?(fragment + letter)
      end

      if possible_words.empty?
        false
      else
        possible_words.none? do |word|
          word.length > (fragment.length + 1 + num_players)
        end
      end
    end
  end

  def find_losing_moves(fragment)
    ('a'..'z').to_a.select do |letter|
      game.dictionary.include?(fragment + letter)
    end
  end

  def non_winning_move(losing_moves)
    random_moves = ('a'..'z').to_a - losing_moves
    moves = random_moves.select{|letter| game.valid?(letter)}
    moves ? moves.sample : losing_moves.sample
  end

  def find_the_best_tree(fragment, num_players)
    letters_and_scores = ('a'..'z').to_a.map do |letter|
      good_words, bad_words = 0,0
      game.dictionary.each do |word|
        if word.start_with?(fragment + letter)
          (word.length - fragment.length).even? ? good_words += 1 : bad_words += 1
        end
      end
      [good_words.to_f / bad_words, letter]
    end
    letters_and_scores.empty? ? nil : letters_and_scores.sort[0[1]]
  end


end
