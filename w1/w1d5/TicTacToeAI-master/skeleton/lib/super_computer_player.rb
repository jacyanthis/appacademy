require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    next_mover_mark = mark == :x ? :o : :x
    node = TicTacToeNode.new(game.board, mark)
    node.children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end
    non_losing_nodes = node.children.reject { |child| child.losing_node?(mark) }
    raise "There's no friggin' way we could have lost." if non_losing_nodes.empty?
    non_losing_nodes.sample.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
