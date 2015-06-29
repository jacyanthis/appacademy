require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos, :children

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    opponent_mark = evaluator == :x ? :o : :x
    return board.winner == opponent_mark if board.over?

    if next_mover_mark != evaluator
      # opponent's turn
      children.any? { |child| child.losing_node?(evaluator)}
    else
      # our turn
      children.all? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?

    if next_mover_mark == evaluator
      # oppoennt's turn
      children.all? { |child| child.winning_node?(evaluator)}
    else
      # our turn
      children.any? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    new_children = []
    (0..2).each do |row|
      (0..2).each do |col|
        if board.empty?([row, col])
          new_board = self.board.dup
          child_node = TicTacToeNode.new(new_board, new_mark, [row, col])
          child_node.board[[row, col]] = next_mover_mark
          new_children << child_node
        end
      end
    end
    new_children
  end

  def new_mark
    next_mover_mark == :x ? :o : :x
  end
end
