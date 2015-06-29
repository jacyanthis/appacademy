class Player
  
  attr_accessor :name, :board
  
  def initialize(name)
    @name = name
    @board = create_board
  end

end

class HumanPlayer < Player
  
  def move
    puts "#{self.name}, where would you like to fire (e.g. 0, 0)?"
    gets.chomp.split(",").map { |str| str.strip.to_i }
  end
  
  def create_board
    new_board = Board.new
    while new_board.ships < Board.total_ships
      puts "#{self.name}, where would you like to place a ship (e.g. 0, 0)?"
      puts "Reminder, you can place #{Board.total_ships - new_board.ships} more ships."
      pos = gets.chomp.split(",").map { |str| str.strip.to_i }
      new_board[*pos] = :ship
    end
    new_board
  end
  
end

class ComputerPlayer < Player
  
  def move
    [rand(0..(Board.size - 1)), rand(0..(Board.size - 1))]
  end
  
  def create_board
    new_board = Board.new
    new_board.random_ships
    new_board
  end
  
end