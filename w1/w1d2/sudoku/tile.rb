require 'colorize'

class Tile
  attr_reader :given
  attr_accessor :value

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    given ? ("#{value}".colorize(:blue)) : ("#{value}".colorize(:red))
  end

end
