require 'spec_helper'

RSpec.describe Magic::Cards::RiseAgain do
  include_context "two player game"

  context "when p1 has wood elves in the graveyard" do
    let(:wood_elves) { Card("Wood Elves") }
    let(:card) { described_class.new(game: game) }

    before do
      p1.graveyard.add(wood_elves)
    end

    it "return target creature card from your graveyard to the battlefield" do
      cast_and_resolve(card: card, player: p1, targeting: wood_elves)
      expect(wood_elves.zone).to be_battlefield
    end
  end
end
