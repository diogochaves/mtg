require 'spec_helper'

RSpec.describe Magic::Cards::KeenGlidemaster do
  include_context "two player game"

  subject { ResolvePermanent("Keen Glidemaster", controller: p1) }
  let(:wood_elves) { Card("Wood Elves") }

  before do
    game.battlefield.add(wood_elves)
    game.battlefield.add(subject)
  end

  context "activated ability" do
    it "pays 2 generic 1 blue mana: target creature gains flying until end of turn." do
      p1.add_mana(blue: 3)

      action = Magic::Actions::ActivateAbility.new(player: p1, permanent: subject, ability: subject.activated_abilities.first)
        .pay_mana({ generic: { blue: 2 }, blue: 1 })
        .targeting(wood_elves)
      game.take_action(action)

      expect(p1.mana_pool[:blue]).to eq(0)
      expect(wood_elves).to be_flying
      expect(wood_elves.keyword_grants.first.until_eot?).to eq(true)
    end
  end
end
