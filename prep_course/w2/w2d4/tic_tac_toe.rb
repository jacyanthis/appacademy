class Board
  
  attr_accessor :grid
  
  def initialize
    @grid = Array.new(3) { Array.new(3) }
  end
  
  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end
  
  def check_matrix(matrix)
    matrix.each do |row|
      if row == [:x, :x, :x]
        return :x
      elsif row == [:o, :o, :o]
        return :o
      end
    end
    false
  end
  
  def check_rows
    check_matrix(grid)
  end
  
  def check_cols
    cols = [[], [], []]
    grid.each do |row|
      row.each_with_index { |mark, index| cols[index] << mark }
    end
    check_matrix(cols)
  end
  
  def check_diagonals
    diagonal_1 = [self[0, 0], self[1, 1], self[2, 2]]
    diagonal_2 = [self[0, 2], self[1, 1], self[2, 0]]
    diagonals = [diagonal_1, diagonal_2]
    check_matrix(diagonals)
  end
  
  def finished?
    winner || tied?
  end
  
  def winner
    checks = [check_rows, check_cols, check_diagonals]
    checks.each {|check| return check if check != false }
    return false
  end
  
  def tied?
    grid.all? do |row|
      row.all? { |mark| mark != nil }
    end
  end
  
  def empty?(pos)
    self[*pos].nil?
  end
  
  def place_mark(pos, mark)
    self[*pos] = mark
  end
  
  def display_board
    grid.each { |row| p row }
  end
  
  def clone_2d_array
    fake_board = Board.new
    grid.each_with_index { |array, index| fake_board.grid[index] = array.clone}
    fake_board
  end
  
end

class Game
  
  attr_accessor :board, :player_1, :player_2, :turn
  
  def self.start
    puts "Welcome to tic tac toe! Please enter the name of the first player."
    puts "If first player is a computer, type 'Computer' (no quotes)."
    name_of_player_1 = gets.chomp
    puts "Please enter the name of the second player."
    puts "If second player is a computer, type 'Computer' (no quotes)."
    name_of_player_2 = gets.chomp
    Game.new(name_of_player_1, name_of_player_2)
  end
  
  def create_players(name_of_player_1, name_of_player_2)
    if name_of_player_1 == "Computer"
      player_1 = ComputerPlayer.new("Computer 1", :x, board)
    else
      player_1 = HumanPlayer.new(name_of_player_1, :x, board)
    end
    if name_of_player_2 == "Computer"
      player_2 = ComputerPlayer.new("Computer 2", :o, board)
    else
      player_2 = HumanPlayer.new(name_of_player_2, :o, board)
    end
    return [player_1, player_2]
  end
  
  def initialize(name_of_player_1, name_of_player_2)
    @board = Board.new
    players = create_players(name_of_player_1, name_of_player_2)
    @player_1 = players[0]
    @player_2 = players[1]
    @turn = player_1
    play
  end
  
  def play
    board.display_board
    until board.finished?
      turn.move
      board.display_board
      switch_turn
    end
    
    finished_game
  end
  
  def finished_game
    winner = board.winner
    if winner == :x
      puts "Winner = #{player_1.name}!"
    elsif winner == :o
      puts "Winner = #{player_2.name}!"
    else
      puts "Tie!"
    end
  end
  
  def switch_turn
    @turn == player_1 ? @turn = player_2 : @turn = player_1
  end

end

class Player
  
  attr_accessor :name, :symbol, :board
  
  def initialize(name, symbol, board)
    @name = name
    @symbol = symbol
    @board = board
  end

  def move
    pos = self.get_input
    until board.empty?(pos)
      if self.is_a?(HumanPlayer)
        puts "Sorry! That position isn't empty. Please try another."
      end
      pos = self.get_input
    end
    board.place_mark(pos, symbol)
    puts "#{self.name} moved #{pos}"
  end

end

class HumanPlayer < Player
  
  def get_input
    puts "#{self.name}, where would you like to place your mark (e.g. 0, 0)?"
    pos = gets.chomp.split(",").map { |str| str.strip.to_i }
    get_input if pos[1].nil?
  end
  
end

class ComputerPlayer < Player
  
  def get_input
    move = winning_move
    move != false ? move : [rand(0..2), rand(0..2)]
  end
  
  def winning_move
    fake_array = create_possible_places
    fake_array.each do |pos|
      fake_board = board.clone_2d_array
      fake_board.place_mark(pos, symbol)
      return pos if fake_board.winner != false
    end
    false
  end
  
  def create_possible_places
    array = []
    board.grid.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        array << [row_index, col_index] if board[row_index, col_index].nil?
      end
    end
    array
  end
  
end

Game.start