require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :starting_position, :root
  attr_accessor :visited_positions

  MOVE_DIFFS = [
    [1, 2],
    [-1, 2],
    [1, -2],
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [-1, -2]
  ]
  BOARD_SIZE = (0...8)

  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [starting_position]
    build_move_tree
  end

  def find_path(ending_position)
    result_node = root.bfs(ending_position)
    trace_path_back(result_node)
  end

  def trace_path_back(result_node)
    current_node = result_node
    path = []
    while current_node
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path
  end

  def build_move_tree
    @root = PolyTreeNode.new(starting_position)
    queue = []
    queue << @root
    until queue.empty?
      curr_node = queue.shift
      children_values = new_move_positions(curr_node.value)
      children = children_values.map { |value| PolyTreeNode.new(value) }
      children.each { |child| curr_node.add_child(child) }
      queue += children
    end
  end

  def valid_moves(x, y)
    moves = MOVE_DIFFS.map { |diff| [diff[0] + x, diff[1] + y] }
    moves.select { |move| BOARD_SIZE.include?(move[0]) && BOARD_SIZE.include?(move[1]) }
  end

  def new_move_positions(pos)
    new_moves = valid_moves(*pos).reject { |move| visited_positions.include?(move) }
    self.visited_positions += new_moves
    new_moves
  end


end
