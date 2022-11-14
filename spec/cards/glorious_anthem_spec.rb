require 'spec_helper'

RSpec.describe Magic::Cards::GloriousAnthem do
  include_context "two player game"

  let!(:glorious_anthem) { ResolvePermanent("Glorious Anthem", controller: p1) }
  let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p1) }
  let!(:wood_elves_2) { ResolvePermanent("Wood Elves", controller: p1) }

  context "two creatures from the same controller are on the battlefield" do
    it "creature gets buffed" do
      expect(wood_elves.power).to eq(2)
      expect(wood_elves.toughness).to eq(2)
      expect(wood_elves_2.power).to eq(2)
      expect(wood_elves_2.toughness).to eq(2)
    end
  end

  context "when this card's ability exists" do
    context "leaving the battlefield" do
      it "clears the static ability" do
        glorious_anthem.destroy!
        expect(game.battlefield.static_abilities.count).to eq(0)
        expect(wood_elves.power).to eq(1)
        expect(wood_elves.toughness).to eq(1)
        expect(wood_elves_2.power).to eq(1)
        expect(wood_elves_2.toughness).to eq(1)
      end
    end
  end
end
