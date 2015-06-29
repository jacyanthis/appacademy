class Card

  attr_accessor :value

  def initialize(value)
    @value = value
    @face = :down
  end

  def self.bomb
    Card.new(:bomb)
  end

  def to_s(bombs)
    if bombs && bomb?
      value
    elsif @face == :down
      "   0"
    else
      value.to_s.rjust(4, " ")
    end
  end



  def flip
    @face = @face == :down ? :up : :down
  end

  def face_up?
    @face == :up
  end

  def bomb?
    value == :bomb
  end

end
