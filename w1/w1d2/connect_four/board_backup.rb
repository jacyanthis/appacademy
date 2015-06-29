class Board

  def initialize(rows, cols, matches)
    @grid = Array.new(rows) {Array.new(cols, :-)}
    @matches = matches
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
    (@grid.length - 1).downto(0) do |row|
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
    winner
  end

  def winner
    output = [
      check_arrays(find_rows),
      check_arrays(find_cols),
      check_arrays(find_diagonals)
      ]
    winning_symbol = output.select { |symbol| symbol }

    if winning_symbol == []
      false
    else
      winning_symbol[0]
    end
  end

  def check_array(array)
    slices = []
    array.each_cons(@matches) { |slice| slices << slice }
    symbol = slices.select { |slice| slice.uniq.length == 1 && slice[0] != :- }
    symbol.empty? ? false : symbol.first.first
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
    cols = []
    num_cols = @grid[0].length
    (0...num_cols).each do |col_num|
      cols << []
      @grid.each do |row|
        cols[col_num] << row[col_num]
      end
    end
    cols
  end

  def find_diagonals
    find_left_diagonals + find_right_diagonals
  end

  def find_left_diagonals
    left_diagonals = []
    @grid.length.times do |t|
      left_diagonals << construct_left_diagonal(t - 1, 0)
    end

    @grid[0].length.times do |t|
      left_diagonals << construct_left_diagonal(0, t - 1)
    end

    left_diagonals
  end

  def find_right_diagonals
    right_diagonals = []
    @grid.length.times do |t|
      right_diagonals << construct_right_diagonal(t - 1, @grid[0].length - 1)
    end

    @grid[0].length.times do |t|
      right_diagonals << construct_right_diagonal(0, t - 1)
    end

    right_diagonals
  end

  def construct_left_diagonal(row, col)
    diagonal = []
    until @grid[row] == nil
      diagonal << @grid[row][col]
      row += 1
      col += 1
    end
    diagonal
  end

  def construct_right_diagonal(row, col)
    diagonal = []
    until @grid[row] == nil
      diagonal << @grid[row][col]
      row += 1
      col -= 1
    end
    diagonal
  end

end
