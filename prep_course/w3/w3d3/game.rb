class Game
  
  FIRST = :player_1
  
  attr_accessor :player_1, :player_2, :turn
  
  def self.start
    puts "Welcome to Battleship!"
    
    player_names = get_player_names
    name_of_player_1, name_of_player_2 = player_names[0], player_names[1]
    
    players = create_players(name_of_player_1, name_of_player_2)
    player_1, player_2 = players[0], players[1]
    
    Game.new(player_1, player_2)
  end
  
  def self.get_player_names
    puts "Please enter the name of the first player."
    puts "If first player is a computer, type 'Computer' (no quotes)."
    name_of_player_1 = gets.chomp
    
    puts "Please enter the name of the second player."
    puts "If second player is a computer, type 'Computer' (no quotes)."
    name_of_player_2 = gets.chomp
    
    [name_of_player_1, name_of_player_2]
  end
  
  def self.create_players(name_of_player_1, name_of_player_2)
    if name_of_player_1 == "Computer"
      player_1 = ComputerPlayer.new("Computer 1")
    else
      player_1 = HumanPlayer.new(name_of_player_1)
    end
    
    if name_of_player_2 == "Computer"
      player_2 = ComputerPlayer.new("Computer 2")
    else
      player_2 = HumanPlayer.new(name_of_player_2)
    end
    
    [player_1, player_2]
  end
  
  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    set_turn
    play
  end
  
  def set_turn
    (FIRST == :player_1) ? @turn = player_1 : @turn = player_2
  end
  
  def play
    loop do
      opponent_board.display(turn.name)
      get_move
      break if opponent_board.ships == 0
      switch_turn
    end
    
    finished_game
  end
  
  def get_move
    pos = turn.move

    if !opponent_board.in_range?(pos)
      if turn.is_a?(HumanPlayer)
        puts "Sorry, that position is off the board!"
        puts "Just to remind you, the board is #{Board.size} x #{Board.size}."
      end
      get_move
      
    elsif !opponent_board.available?(pos)
      if turn.is_a?(HumanPlayer)
        puts "Sorry, you've already fired there!"
      end
      get_move
      
    else
      opponent_board.fire(pos)
      puts "#{turn.name} moved #{pos}, #{opponent_board.ships} ships remaining."
      puts ""
    end
  end
  
  def opponent_board
    if turn == player_1
      player_2.board
    else
      player_1.board
    end
  end
  
  def switch_turn
    @turn == player_1 ? @turn = player_2 : @turn = player_1
  end
  
  def finished_game
    puts "Congratulations, #{turn.name}! You're the winner!"
  end

end