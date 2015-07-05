class Player
  attr_reader :name, :game
  attr_accessor :bankroll, :hand

  def initialize(name, bankroll, game)
    @name = name
    @bankroll = bankroll
    @game = game
    @hand = nil
  end

  def pay_winnings(num)
    self.bankroll += num
  end

  def return_cards(deck, cards_to_return)
    hand.return_cards(deck, cards_to_return)
  end

  def place_bet(bet)
    raise "money problem" if bet > bankroll
    self.bankroll -= bet
    game.receive_bet(bet)
  end
end
