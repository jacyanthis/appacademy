require_relative 'board'

class Game
  def initialize(file)
    @board = Board.from_file(file)
  end

  def run
    @board.render
    until @board.solved?
      turn
    end
    finish_game
  end

  def finish_game
    puts "You won!"
  end

  def turn
    input = prompt_user
    make_move(*input)
    @board.render
  end

  def prompt_user
    puts "Please enter the position you want to change:"
    position_input = gets.chomp
    position = position_input.split(",").map(&:to_i)

    puts "Please enter the value:"
    value = gets.chomp

    [position, value]
  end

  def make_move(pos, val)
    puts @board[pos].given
    @board.update_tile(pos, val)
  end
end
