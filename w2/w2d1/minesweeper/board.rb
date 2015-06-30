require_relative 'tile'

class Board
  def initialize(game = nil, size = 9, bombs = 10)
    @game = game
    @size = size
    @bombs = bombs
    create_grid
  end

  def swap_flag(pos)
    self[pos].swap_flag
  end

  def render(pos = nil)
    system("clear")
    puts "    " + (0...size).to_a.join(" ")
    @grid.each_with_index do |row, id|
      printable = ["#{id}: "]
      row.each do |tile|
        printable << tile.to_s(pos)
      end
      puts printable.join(" ")
    end
  end

  def over?
    won? || lost?
  end

  def won?
    @grid.flatten.all? { |tile| tile.revealed? || tile.bombed? }
  end

  def lost?
    @grid.flatten.any? { |tile| tile.revealed? && tile.bombed? }
  end

  def reveal_tiles(pos, checked_positions = [])
    return nil if !on_board?(pos) || checked_positions.include?(pos)

    if self[pos].flagged?
      puts "Sorry, that tile is flagged! Unflag first to reveal."
      return
    end
    self[pos].reveal

    checked_positions << pos

    if self[pos].value == "0"
      self[pos].adj_positions.each do |adj|
        reveal_tiles(adj, checked_positions) if on_board?(adj)
      end
    end
  end

  def on_board?(pos)
    (0...size).include?(pos[0]) && (0...size).include?(pos[1])
  end

  protected

  attr_accessor :grid
  attr_reader :bombs, :size

  def create_grid
    create_tiles
    add_bombs
    update_values
  end

  def create_tiles
    @grid = []
    (0...size).each do |row_idx|
      grid << []
      (0...size).each do |col_idx|
        self.grid[row_idx][col_idx] = Tile.new(self, [row_idx, col_idx])
      end
    end
  end

  def add_bombs
    bomb_positions = []

    until bomb_positions.length == bombs
      position = [rand(size), rand(size)]
      bomb_positions << position unless bomb_positions.include?(position)
    end

    bomb_positions.each { |bomb_pos| self[bomb_pos].bomb }
  end

  def update_values
    (0...size).each do |row_idx|
      (0...size).each do |col_idx|

        pos = [row_idx, col_idx]

        unless self[pos].bombed?
          bomb_count = 0

          self[pos].adj_positions.each do |adj|
            bomb_count += 1 if on_board?(adj) && self[adj].bombed?
          end

          self[pos].value = bomb_count.to_s
        end

      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end

end
