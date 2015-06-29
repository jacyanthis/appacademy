require 'byebug'

class Board
  attr_reader :col_num, :row_num, :matches

  def initialize(rows = 6, cols = 7, matches = 4)
    @grid = Array.new(rows) {Array.new(cols, :-)}
    @matches = matches
    @col_num = cols
    @row_num = rows
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

  def render
    @grid.each do |row|
      printable = ""
      row.each do |disc|
        printable << disc.to_s
      end
      puts printable
    end
  end

  def drop_disc(col, disc)
    (row_num - 1).downto(0) do |row|
      pos = [row, col]
      if self.empty?(pos)
        self[pos] = disc
        return
      end
    end
  end

  def empty?(pos)
    self[pos] == :-
  end

  def over?
    !!winner || full?
  end

  def full?
    @grid.flatten.none? { |disc| disc == :- }
  end

  def winner
    output = [
      check_arrays(find_rows),
      check_arrays(find_cols),
      check_arrays(find_diagonals)
      ]
    winning_symbol = output.select { |symbol| symbol }

    winning_symbol == [] ? false : winning_symbol[0]
  end

  def check_array(array)
    slices = []
    array.each_cons(matches) { |slice| slices << slice }
    winning_slice = slices.find { |slice| slice[0] != :- && slice.uniq.length == 1 }
    winning_slice.nil? ? false : winning_slice.first
  end

  def check_arrays(arrays)
    arrays.each do |array|
      output = check_array(array)
      return output if output
    end

    false
  end

  def find_rows
    @grid
  end

  def find_cols
    @grid.transpose
    # could use @grid.transpose
    # cols = []
    # (0...col_num).each do |col_num|
    #   cols << []
    #   @grid.each do |row|
    #     cols[col_num] << row[col_num]
    #   end
    # end
    #
    # cols
  end

  def find_diagonals
    right_diagonals = make_mirrored_board.find_left_diagonals
    find_left_diagonals + right_diagonals
  end

  def find_left_diagonals
    left_diagonals = []
    row_num.times do |t|
      left_diagonals << construct_left_diagonal(t, 0)
    end

    col_num.times do |t|
      left_diagonals << construct_left_diagonal(0, t)
    end

    left_diagonals
  end

  def construct_left_diagonal(row, col)
    diagonal = []
    until @grid[row].nil? || self[[row, col]].nil?
      diagonal << self[[row, col]]
      row += 1
      col += 1
    end

    diagonal
  end

  def make_mirrored_board
    new_board = Board.new
    @grid.each_with_index do |row, i|
      row.each_with_index do |_, j|
        new_board[[i, j]] = self[[i, col_num - 1 - j]]
      end
    end

    new_board
  end

end
