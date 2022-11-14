require 'spec_helper'

RSpec.describe Magic::Cards::SureStrike do
  include_context "two player game"

  subject { Card("Sure Strike") }

  context "resolution" do
    let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p1) }

    it "buffs a target" do
      p1.add_mana(red: 2)
      action = cast_action(player: p1, card: subject)
                .pay_mana(red: 1, generic: { red: 1})
                .targeting(wood_elves)
      game.take_action(action)
      game.stack.resolve!
      buff = wood_elves.modifiers.first
      expect(buff.power).to eq(3)
      expect(buff.until_eot?).to eq(true)
      expect(wood_elves.power).to eq(4)
      expect(wood_elves).to be_first_strike
      expect(wood_elves.keyword_grants.count).to eq(1)
      expect(wood_elves.keyword_grants.first.until_eot?).to eq(true)

    end
  end
end
