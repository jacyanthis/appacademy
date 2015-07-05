class Game
  attr_accessor :players, :deck, :pot

  def initialize(players, deck)
    @players = players
    @deck = deck
    @pot = 0
  end

  def current_player
    players.first
  end

  def switch_player
    players.rotate!
  end

  def receive_bet(bet)
    self.pot += bet
  end

  def determine_winner
    i = 0
    while i < players.length
      j = 0
      puts "i is #{i}"
      while j <= players.length
        puts "j is #{j}"
        if i == j
          j += 1
          next
        end
        if j == players.length
          pay_player(players[i])
          return players[i]
        end
        break unless players[i].hand.beats?(players[j].hand)
        j += 1
      end
      i += 1
    end
  end

  def pay_player(player)
    player.pay_winnings(pot)
    self.pot = 0
  end
end
