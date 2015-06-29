class Player

  def initialize(game)
    @game = game
  end

end

class HumanPlayer < Player

  def get_guesses
    @game.MATCH_NUMBER.times do
      pos = prompt
      if @board[*pos].bomb?
        puts "BOOM!"
        throw :bomb
      end
      @game.make_guess(pos)
      @guesses << pos
    end
  end

end
