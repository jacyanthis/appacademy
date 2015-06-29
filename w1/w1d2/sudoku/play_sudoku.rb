require_relative 'game.rb'

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    Game.new("puzzles/sudoku1-almost.txt").run
  else
    Game.new("#{ARGV[0]}").run
  end
end
