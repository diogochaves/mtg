require 'spec_helper'

RSpec.describe Magic::Cards::InfernalScarring do
  include_context "two player game"

  subject { Card("Infernal Scarring") }

  context "resolution" do
    let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p1) }

    it "buffs wood elves, gives them “When this creature dies, draw a card.”" do
      p1.add_mana(black: 2)
      action = cast_action(player: p1, card: subject)
        .pay_mana(black: 1, generic: { black: 1 })
        .targeting(wood_elves)
      game.take_action(action)
      game.stack.resolve!

      expect(wood_elves.attachments.count).to eq(1)
      expect(wood_elves.attachments.first).to be_a(Magic::Permanent)
      expect(wood_elves.attachments.first.name).to eq("Infernal Scarring")
      expect(wood_elves.power).to eq(3)
      expect(p1.permanents.by_name("Infernal Scarring").count).to eq(1)

      wood_elves.destroy!
      expect(wood_elves.zone).to be_graveyard
      expect(p1.permanents.by_name("Infernal Scarring").count).to eq(0)
      expect(subject.zone).to be_graveyard
      expect(p1).to receive(:draw!)
    end
  end
end
