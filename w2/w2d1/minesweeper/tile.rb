require 'colorize'

class Tile
  ADJ_POS = [
    [-1, -1],
    [-1 , 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ]
  COLORS = {
    "1" => :blue,
    "2" => :green,
    "3" => :light_red,
    "4" => :yellow,
    "5" => :magenta,
    "6" => :magenta,
    "7" => :magenta,
    "8" => :magenta,
    "B" => :red
  }

  attr_reader :board, :pos
  attr_accessor :value

  def initialize(board, pos, value = "0", flagged = false, revealed = false)
    @board = board
    @pos = pos
    @value = value
    @flagged = flagged
    @revealed = revealed
  end

  def bomb
    self.value = "B"
  end

  def bombed?
    value == "B"
  end

  def flagged?
    flagged
  end

  def revealed?
    revealed
  end

  def swap_flag
    self.flagged = flagged ? false : true
  end

  def reveal
    self.revealed = true
  end

  def to_s(cursor_pos = nil)
    if self.pos == cursor_pos
      "X".colorize(:yellow)
    elsif revealed?
      value == "0" ? "_" : value.colorize(COLORS[value])
    elsif flagged
      "F".colorize(:magenta)
    else
      "*"
    end
  end

  def adj_positions
    ADJ_POS.map { |adj| [pos[0] + adj[0], pos[1] + adj[1]] }
  end

  protected
  attr_accessor :flagged, :revealed
end
