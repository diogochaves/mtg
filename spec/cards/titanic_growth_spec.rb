require 'spec_helper'

RSpec.describe Magic::Cards::TitanicGrowth do
  include_context "two player game"

  subject { Card("Titanic Growth") }

  context "resolution" do
    let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p1) }

    it "buffs a target" do
      p1.add_mana(green: 2)
      action = cast_action(player: p1, card: subject)
                .pay_mana(green: 1, generic: { green: 1})
                .targeting(wood_elves)
      game.take_action(action)
      game.stack.resolve!
      buff = wood_elves.modifiers.first
      expect(buff.power).to eq(4)
      expect(buff.toughness).to eq(4)
      expect(buff.until_eot?).to eq(true)
      expect(wood_elves.power).to eq(5)
      expect(wood_elves.toughness).to eq(5)

    end
  end
end
