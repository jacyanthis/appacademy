class Board


  def initialize(rows, match_number, bombs)
    @grid = new_grid(rows, match_number, bombs)
  end

  def new_grid(rows, match_number, bombs)
    card_no = (((rows ** 2) / match_number) - (bombs / match_number))
    cards = ((1..card_no).to_a * match_number)
    cards.map! { |x| Card.new(x) }
    bombs.times { |i| cards << Card.bomb }
    cards.shuffle.each_slice(rows).to_a
  end

  def render(bombs)
    @grid.each do |row|
      puts row.map { |card| card.to_s(bombs) }.join
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def flip_guesses(guesses)
    guesses.each do |pos|
      self[*pos].flip
    end
  end

  def all_face_up?
    @grid.flatten.all? { |card| card.face_up? || card.bomb? }
  end


end
