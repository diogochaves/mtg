require 'spec_helper'

RSpec.describe Magic::Cards::RainOfRevelation do
  include_context "two player game"

  subject { described_class.new(game: game) }

  context "cast" do
    it "draw three cards, ..." do
      expect(p1).to receive(:draw!)
	  expect(p1).to receive(:draw!)
	  expect(p1).to receive(:draw!)
	  expect(p1).to receive(:draw!)
      cast_and_resolve(card: subject, player: p1)

      #expect(p1.graveyard.by_name("RainOfRevelation").count).to eq(1)
    end

	it "... then discard a card"

  end
end
