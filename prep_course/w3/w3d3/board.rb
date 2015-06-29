class Board
  
  TOTAL_SHIPS = 5
  GRID_SIZE = 5
  
  attr_accessor :grid
  
  def initialize
  	@grid = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, :water) }
  end
  
  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, mark)
    grid[row][col] = mark
  end
  
  def ships
    ships = 0
    (0..(GRID_SIZE - 1)).each do |row|
      (0..(GRID_SIZE - 1)).each do |col|
        ships += 1 if self[row, col] == :ship
      end
    end
    ships
  end
  
  def random_ships
    random_positions = create_random_positions
    random_positions.each do |pos|
      self[*pos] = :ship
    end
  end
  
  def create_random_positions
    random_positions = []
    until random_positions.length == TOTAL_SHIPS
      random_number_1 = rand(0..(GRID_SIZE - 1))
      random_number_2 = rand(0..(GRID_SIZE - 1))
      if !random_positions.include?([random_number_1, random_number_2])
        random_positions << [random_number_1, random_number_2]
      end
    end
    random_positions
  end
  
  def in_range?(pos)
    ((0..(GRID_SIZE - 1)).include?pos[0]) && ((0..(GRID_SIZE - 1)).include?pos[1])
  end
  
  def available?(pos)
    self[*pos] == :ship || self[*pos] == :water
  end
  
  def fire(pos)
    self[*pos] = :fired
  end
  
  def self.size
    GRID_SIZE
  end
  
  def self.total_ships
    TOTAL_SHIPS
  end
  
  def display(name)
    puts "#{name}, This is where you have fired before (represented by Fs):"
    (0..(GRID_SIZE - 1)).each do |row|
      (0..(GRID_SIZE - 1)).each do |col|
        if self[row, col] == :ship || self[row, col] == :water
          print "O "
        else
          print "F "
        end
      end
      puts ""
    end
  end
  
end