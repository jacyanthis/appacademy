require 'rspec'
require 'hand'

describe Hand do
  let(:straight_flush_hand) {
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :six)
    ]
    )
  }
  let(:four_of_a_kind_hand) {
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:diamonds, :deuce),
      Card.new(:clubs, :deuce),
      Card.new(:spades, :six)
    ]
    )
  }
  let(:full_house_hand) {
    Hand.new(
    [
      Card.new(:spades, :seven),
      Card.new(:hearts, :seven),
      Card.new(:diamonds, :seven),
      Card.new(:spades, :five),
      Card.new(:clubs, :five)
    ]
    )
  }
  let(:worse_full_house_hand) {
    Hand.new(
    [
      Card.new(:spades, :nine),
      Card.new(:hearts, :nine),
      Card.new(:diamonds, :deuce),
      Card.new(:spades, :deuce),
      Card.new(:clubs, :deuce)
    ]
    )
  }
  let(:flush_hand) {
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:spades, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :seven)
    ]
    )
  }
  let(:straight_hand){
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:clubs, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :six)
    ]
    )
  }
  let(:three_of_a_kind_hand){
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:diamonds, :deuce),
      Card.new(:clubs, :deuce),
      Card.new(:spades, :five),
      Card.new(:spades, :six)
    ]
    )
  }
  let(:two_pair_hand){
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:hearts, :deuce),
      Card.new(:clubs, :four),
      Card.new(:spades, :four),
      Card.new(:spades, :six)
    ]
    )
  }
  let(:pair_hand){
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:clubs, :deuce),
      Card.new(:clubs, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :six)
    ]
    )
  }
  let(:high_card_hand) {
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:clubs, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :eight)
    ]
    )
  }
  let(:worse_high_card_hand) {
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:clubs, :four),
      Card.new(:spades, :five),
      Card.new(:spades, :seven)
    ]
    )
  }
  let(:worse_suit_high_card_hand) {
    Hand.new(
    [
      Card.new(:spades, :deuce),
      Card.new(:spades, :three),
      Card.new(:clubs, :four),
      Card.new(:spades, :five),
      Card.new(:clubs, :eight)
    ]
    )
  }


  describe "::deal_from" do
    it "deals a hand of five cards" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :king),
        Card.new(:spades, :seven),
        Card.new(:hearts, :nine)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.cards).to eq(deck_cards)
    end
  end

  describe "#hand_category" do
    it "identifies straight flush" do
      expect(straight_flush_hand.hand_category).to eq(:straight_flush)
    end

    it "identifies four of a kind" do
      expect(four_of_a_kind_hand.hand_category).to eq(:four_of_a_kind)
    end

    it "identifies full house" do
      expect(full_house_hand.hand_category).to eq(:full_house)
    end

    it "identifies flush" do
      expect(flush_hand.hand_category).to eq(:flush)
    end

    it "identifies straight" do
      expect(straight_hand.hand_category).to eq(:straight)
    end

    it "identifies three of a kind" do
      expect(three_of_a_kind_hand.hand_category).to eq(:three_of_a_kind)
    end

    it "identifies two pair" do
      expect(two_pair_hand.hand_category).to eq(:two_pair)
    end

    it "identifies pair" do
      expect(pair_hand.hand_category).to eq(:pair)
    end

    it "identifies high card" do
      expect(high_card_hand.hand_category).to eq(:high_card)
    end
  end

  describe "#beats?" do
    it "knows a straight flush beats a full house" do
      expect(straight_flush_hand.beats?(full_house_hand)).to be(true)
    end
    it "knows a full house beats a two pair" do
      expect(full_house_hand.beats?(two_pair_hand)).to be(true)
    end
    it "knows a higher high card wins" do
      expect(high_card_hand.beats?(worse_high_card_hand)).to be(true)
    end
    it "knows a full house with higher three of a kind wins" do
      expect(full_house_hand.beats?(worse_full_house_hand)).to be(true)
    end
    it "knows a better suit high card wins" do
      expect(high_card_hand.beats?(worse_suit_high_card_hand)).to be(true)
    end
  end

  describe "#return_cards" do
    let (:hand) do
      Hand.new([
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six)
        ])
    end
    let (:deck) { double("deck") }

      let (:cards_to_return) do
        hand.cards.take(3)
      end

      it "returns cards to deck" do
        expect(deck).to receive(:return) do |cards|
          expect(cards).to eq(cards_to_return)
        end

        hand.return_cards(deck, cards_to_return)
      end

      it "removes cards from hand" do
        allow(deck).to receive(:return)

        hand.return_cards(deck, cards_to_return)
        expect(hand.cards.count).to eq(2)
        end
      end

    end
