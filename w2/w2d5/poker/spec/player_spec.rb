require 'rspec'
require 'player'

describe Player do
  let(:game) { double("game", :receive_bet => nil) }
  let(:player) {Player.new("Shaquille", 100, game)}

  it "assigns the name" do
    expect(player.name).to eq("Shaquille")
  end

  it "assigns the bankroll" do
    expect(player.bankroll).to eq(100)
  end

  describe "#pay_winnings" do
    it "pays winnings" do
      player.pay_winnings(400)
      expect(player.bankroll).to eq(500)
    end
  end

  describe "#return_cards" do
    let(:deck) {double("deck")}
    let(:hand) {double("hand", :return_cards => nil)}
    let(:cards_to_return) { [] }

    before {player.hand = hand}

    it "returns a player's cards to the deck" do
      expect(hand).to receive(:return_cards).with(deck, cards_to_return)
      player.return_cards(deck, cards_to_return)
    end
  end

  describe "#place_bet" do
    it "removes from bankroll" do
      player.place_bet(50)
      expect(player.bankroll).to eq(50)
    end

    it "registers with game" do
      expect(game).to receive(:receive_bet).with(25)
      player.place_bet(25)
    end

    it "enforces limits" do
      expect do
        player.place_bet(1000)
      end.to raise_error
    end
  end
end
