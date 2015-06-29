class Game


  def initialize(match_number, rows, turn_max, bombs)
    @match_number = match_number
    @rows = rows
    @turn_max = turn_max
    @bombs = bombs
    @board = Board.new(rows, match_number, bombs)
    @guesses = []
    @turns = 0
    #@player = player
  end

  def play
    @board.render(true)
    sleep(5)
    system("clear")

    play_turns
    finish_game
  end

  def play_turns
    catch :bomb do
      until over?
        @board.render(false)
        get_guesses
        sleep(2)
        #system("clear")
        end_turn
      end
    end
  end

  def end_turn
    check_guesses
    @turns += 1
    @guesses = []
  end

  def over?
    @turns == @turn_max || @board.all_face_up?
  end

  def get_guesses
    @match_number.times do
      pos = prompt
      if @board[*pos].bomb?
        puts "BOOM!"
        throw :bomb
      end
      make_guess(pos)
      @guesses << pos
    end
  end

  def check_guesses
    if @guesses.map { |guess| @board[*guess].value }.uniq.length > 1
      @board.flip_guesses(@guesses)
      puts "no match!"
    else
      puts "you found a match!"
    end
  end

  def prompt
    pos = []
    loop do
      puts "Please enter the position of a card (eg. 1, 2)"
      pos = gets.chomp.split(',')
      break unless invalid_pos?(pos)
    end
    pos.map { |n| n.to_i - 1 }
  end

  def invalid_pos?(pos)
    if pos.length == 2 && pos.all? { |x| x =~ /[1-#{@rows}]/ }
      pos = pos.map { |n| n.to_i - 1 }
      return @board[*pos].face_up?
    end

    true
  end

  def make_guess(pos)
    @board[*pos].flip
    @board.render(false)
    @board[*pos]
  end

  def finish_game
     puts @board.all_face_up? ? "You Won!" : "You Lost"

  end


end
