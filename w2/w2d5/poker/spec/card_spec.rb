require 'rspec'
require 'card'

#same cards for all card games??
describe Card do

  describe "#initialize" do
    let(:new_jack_of_diamonds) { Card.new(:diamonds, :jack)}

    it "creates a new card with correct value" do
      expect(new_jack_of_diamonds.value).to eq(:jack)
    end

    it "creates a new card with correct suit" do
      expect(new_jack_of_diamonds.suit).to eq(:diamonds)
    end
  end

end
