require 'spec_helper'

RSpec.describe Magic::Cards::FetidImp do
  include_context "two player game"

  subject { ResolvePermanent("Fetid Imp", controller: p1) }

  before do
    game.battlefield.add(subject)
  end  

  context "activated ability" do
    it "pays 1 black mana: Fetid Imp gains deathtouch until end of turn." do
      p1.add_mana(black: 1)

      action = Magic::Actions::ActivateAbility.new(player: p1, permanent: subject, ability: subject.activated_abilities.first)
      action.pay_mana({ black: 1 })
      game.take_action(action)
      game.tick!

      expect(p1.mana_pool[:black]).to eq(0)
      expect(subject).to be_deathtouch
      expect(subject.keyword_grants.first.until_eot?).to eq(true)
    end
  end
end
