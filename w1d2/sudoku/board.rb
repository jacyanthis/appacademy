require_relative 'tile'
require 'byebug'

class Board

  SOLVED_ARRAY = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9"
  ]

  def self.from_file(file)
    string_array = []
    File.readlines(file).each do |line|
      string_array << line.chomp.split("")
    end
    puzzle = create_tile_array(string_array)

    Board.new(puzzle)
  end

  def self.create_tile_array(string_array)
    tile_array = []
    string_array.each do |row|
      tile_row = []
      row.each do |string|
        if string == "0"
          tile_row << Tile.new(string, false)
        else
          tile_row << Tile.new(string, true)
        end
      end
      tile_array << tile_row
    end

    tile_array
  end

  def initialize(puzzle)
    @puzzle = puzzle
  end

  def [](pos)
    row, col = pos
    @puzzle[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @puzzle[row][col] = mark
  end

  def update_tile(pos, value)
    self[pos].value = value if !self[pos].given
  end

  def render
    @puzzle.each do |row|
      printable = ""
      row.each do |tile|
        printable << tile.to_s
      end
      puts printable
    end
  end

  def solved?
    arrays = rows_solved + columns_solved + squares_solved
    tile_arrays = convert_tile_arrays_to_string_arrays(arrays)
    tile_arrays.all? { |tile_array| tile_array.sort == SOLVED_ARRAY }
  end

  def convert_tile_arrays_to_string_arrays(arrays)
     tile_arrays = []
     arrays.each do |array|
       tile_array = []
       array.each do |tile|
         tile_array << tile.value
       end
       tile_arrays << tile_array
     end
     tile_arrays
  end

  def rows_solved
    @puzzle
  end

  def columns_solved
    @puzzle.transpose
  end

  def squares_solved
    blocks = []
    @puzzle.each_slice(3) do |slice|
      third = [[],[],[]]
      slice.each do |row|
        third[0] << row[0..2]
        third[1] << row[3..5]
        third[2] << row[6..8]
      end

      third.each do |block|
        blocks << block.flatten
      end
    end

    blocks
  end

end
