require_relative 'deck'

class Hand
  POKER_VALUE = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace => 14
  }

  HAND_ARRAY = [
    :straight_flush,
    :four_of_a_kind,
    :full_house,
    :flush,
    :straight,
    :three_of_a_kind,
    :two_pair,
    :pair,
    :high_card
  ]

  SUIT_ARRAY = [
    :spades,
    :hearts,
    :diamonds,
    :clubs
  ]

  attr_reader :cards
  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  def initialize(cards)
    @cards = cards
  end

  def hand_category
    if straight_flush
      :straight_flush
    elsif four_of_a_kind
      :four_of_a_kind
    elsif full_house
      :full_house
    elsif flush
      :flush
    elsif straight
      :straight
    elsif three_of_a_kind
      :three_of_a_kind
    elsif two_pair
      :two_pair
    elsif pair
      :pair
    else
      :high_card
    end
  end

  def straight_flush
    straight && flush
  end

  def four_of_a_kind
    x_of_a_kind(4)
  end

  def full_house
    cards.map(&:poker_value).uniq.count == 2
  end

  def straight
    sorted_poker_values = cards.map(&:poker_value).sort
    sorted_poker_values.take(4).each_with_index do |value, idx|
      return false if value + 1 != sorted_poker_values[idx + 1]
    end

    true
  end

  def flush
    cards.map(&:suit).uniq.count == 1
  end

  def three_of_a_kind
    x_of_a_kind(3)
  end

  def two_pair
    cards.map(&:poker_value).uniq.count == 3
  end

  def pair
    x_of_a_kind(2)
  end

  def x_of_a_kind(num)
    arr_of_values = cards.map(&:poker_value)
    arr_of_values.any? { |value| arr_of_values.count(value) >= num }
  end

  def beats?(other_hand)
    HAND_ARRAY.each do |hand|
      if hand_category == hand && other_hand.hand_category == hand
        return compare_same_hands(other_hand)
      elsif hand_category == hand
        return true
      elsif other_hand.hand_category == hand
        return false
      end
    end
  end

  def compare_same_hands(other_hand)
    if hand_category == :straight_flush
      resolve_high_card(other_hand)
    elsif hand_category == :four_of_a_kind
      resolve_x_of_a_kind(other_hand,4)
    elsif hand_category == :full_house
      resolve_x_of_a_kind(other_hand,3)
    elsif hand_category == :flush
      resolve_high_card(other_hand)
    elsif hand_category == :straight
      resolve_high_card(other_hand)
    elsif hand_category == :three_of_a_kind
      resolve_x_of_a_kind(other_hand,3)
    elsif hand_category == :two_pair
      resolve_two_pair(other_hand)
    elsif hand_category == :pair
      resolve_pair(other_hand,2)
    else
      resolve_high_card(other_hand)
    end
  end

  def resolve_high_card(other_hand)
    our_max_card = cards.max_by { |card| card.poker_value }
    other_max_card = other_hand.cards.max_by { |card| card.poker_value }
    #TODO finish this when you have a spare week
    if our_max_card.poker_value == other_max_card.poker_value
      resolve_suit(our_max_card, other_max_card)
    else
      our_max_card.poker_value > other_max_card.poker_value
    end
  end

  def resolve_x_of_a_kind(other_hand, num)
    our_value = max_value(self, num)
    other_value = max_value(other_hand, num)
    our_value > other_value
  end

  def resolve_pair(other_hand)
    our_value = max_value(self, 2)
    other_value = max_value(other_hand, 2)
    if our_value == other_value
      resolve_tied_pair(other_hand, our_value)
    else
      our_value > other_value
    end
  end

  def resolve_tied_pair(other_hand, our_value)
    our_other_three = cards.reject { |card| card.poker_value == our_value }
    other_other_three = other_hand.cards.reject { |card| card.poker_value == our_value }
    our_sorted_values = our_other_three.map(&:poker_value).sort.reverse
    other_sorted_values = other_other_three.map(&:poker_value).sort.reverse

    our_sorted_values.each_with_index do |value, index|
      if value == other_sorted_values[index]
        next
      else
        return value > other_sorted_values[index]
      end
    end

    our_pair_suits = cards.select { |card| card.poker_value == our_value }.map(&:suit)
    our_pair_suits.include?(:spades)
  end

  def resolve_two_pair(other_hand)
    #TODO finish this method. will probably take > 5 hours
  end

  def max_value(hand, num)
    arr_of_values = hand.cards.map(&:poker_value)
    arr_of_values.find { |value| arr_of_values.count(value) >= num }
  end

  def resolve_suit(card1, card2)
    SUIT_ARRAY.each do |suit|
      if card1.suit == suit
        return true
      elsif card2.suit == suit
        return false
      end
    end
  end

  def return_cards(deck, cards_to_return)
    deck.return(cards_to_return)
    cards_to_return.each do |card|
      cards.delete(card)
    end
  end

end
