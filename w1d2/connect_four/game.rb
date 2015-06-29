class Game
  attr_accessor :turn
  attr_reader :board

  def initialize(rows = 6, cols = 7, matches = 4)
    @board = Board.new(rows,cols, matches)
    @turn = :X
  end

  def run
    board.render

    until board.over?
      take_turn
    end

    finish_game
  end

  def take_turn
    move = prompt_user
    board.drop_disc(move, turn)
    board.render
    switch_turn
  end

  def prompt_user
    puts "#{turn}, which column would you like to drop a disc into?"
    gets.chomp.to_i
  end

  def switch_turn
    turn == :X ? self.turn = :O : self.turn = :X
  end

  def finish_game
    winner = board.winner
    puts winner ? "#{winner} is the winner!" : "It's a tie!"
  end

end
