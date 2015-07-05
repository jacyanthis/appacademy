require_relative 'card'

class Deck

  def self.all_cards
    all_cards = []
    Card::SUIT_STRINGS.each_key do |suit|
      Card::VALUE_STRINGS.each_key do |value|
        all_cards << Card.new(suit,value)
      end
    end

    all_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def card_count
    cards.count
  end

  def take(num)
    taken_cards = []
    num.times do
      raise "not enough cards" if card_count == 0
      taken_cards << cards.shift
    end

    taken_cards
  end

  def return(returned_cards)
    returned_cards.each do |card|
      cards << card
    end
  end

  protected
  attr_accessor :cards
end
