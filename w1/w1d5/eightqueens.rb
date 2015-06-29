require 'set'

class EightQueens
  attr_accessor :valid_positions, :invalid_positions, :grid, :queens, :current_row
  attr_reader :size
  DIAGONAL_DIRECTIONS = [[1,1],[1,-1],[-1,1],[-1,-1]]

  def initialize(size = 8, valid_positions = nil, invalid_positions = Set.new, queens = [], current_row = 0)
    @size = size
    @valid_positions = valid_positions || generate_all_positions
    @invalid_positions = invalid_positions
    @queens = queens
    @current_row = current_row
  end

  def generate_all_positions
    all_positions = Set.new
    size.times do |row|
      size.times do |col|
        all_positions.add([row, col])
      end
    end
    all_positions
  end

  def update_positions(pos)
    row, col = pos[0], pos[1]

    (0...size).each do |idx|
      invalid_positions.add([row, idx])
      valid_positions.delete([row, idx])
    end

    (0...size).each do |idx|
      invalid_positions.add([idx, col])
      valid_positions.delete([idx, col])
    end

    DIAGONAL_DIRECTIONS.each do |direction|
      diagonals = get_diagonals(pos, direction)
      invalid_positions.merge(diagonals)
      valid_positions.subtract(diagonals)
    end
  end

  def get_diagonals(pos, direction)
    diagonals = []
    row, col = pos[0], pos[1]
    while board_include?([row, col])
      diagonals << [row, col]
      row += direction[0]
      col += direction[1]
    end
    diagonals
  end

  def board_include?(pos)
    pos.all? { |coordinate| (0...size).include?(coordinate)}
  end

  def run
    if queens.length == size
      p queens
      # throw :done
    end
    return queens.sort if queens.length == size
    return nil if invalid_positions.size == size * size
    queens_solutions = []
    valid_and_correct_row_positions = valid_positions.select do |row, col|
      row == current_row
    end
    valid_and_correct_row_positions.each do |pos|
        child = EightQueens.new(size, valid_positions.dup, invalid_positions.dup, queens.dup, current_row + 1)
        child.update_positions(pos)
        child.queens << pos
        output = child.run
        if output
          if output.length == size
            queens_solutions << output
          else
            queens_solutions.concat(output)
          end
        end
    end

    queens_solutions.length == 0 ? nil : queens_solutions.uniq
  end


end

start = Time.now
# catch (:done) do
e = EightQueens.new(8)
e.run
# end
finish = Time.now

puts (finish - start)
