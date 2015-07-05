require 'rspec'
require 'game'

describe Game do
  let(:player_one_hand) { double("player one hand") }
  let(:player_two_hand) { double("player one hand") }
  let(:player_one) { double("player one", :hand => player_one_hand, :pay_winnings => nil) }
  let(:player_two) { double("player two", :hand => player_two_hand) }
  let(:players) { [player_one, player_two] }
  let(:deck) { double("deck") }
  let(:game) { Game.new(players, deck) }

  it "stores the player" do
    expect(game.players).to eq(players)
  end

  it "stores the deck" do
    expect(game.deck).to eq(deck)
  end

  it "initializes with an empty pot" do
    expect(game.pot).to eq(0)
  end

  describe "#current_player" do
    it "makes the first player the current player at the start" do
      expect(game.current_player).to eq(player_one)
    end
  end

  describe "#switch_player" do
    it "makes the next player the current player when switching turn" do
      game.switch_player
      expect(game.current_player).to eq(player_two)
    end
  end



  describe "#recieve_bet" do
    it "adds bet to the pot" do
      game.receive_bet(100)
      expect(game.pot).to eq(100)
    end
  end


  describe "#determine_winner" do
    before(:each) do
      allow(player_one_hand).to receive(:beats?).with(player_two_hand).and_return(true)
    end

    it "correctly determines the winner" do
      expect(game.determine_winner).to eq(player_one)
    end
  end

  describe "#pay_player" do
    it "pays winner the entirety of the pot" do
      expect(player_one).to receive(:pay_winnings).with(0)
      game.pay_player(player_one)
    end
  end
end
