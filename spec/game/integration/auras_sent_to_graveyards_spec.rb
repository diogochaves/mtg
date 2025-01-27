require 'spec_helper'

RSpec.describe 'When creatures die, auras attached to them are sent to graveyards' do
  include_context "two player game"

  let(:faiths_fetters) { Card("Faith's Fetters") }
  let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p2) }

  it "wood elves is destroyed" do
    cast_and_resolve(card: faiths_fetters, player: p1, targeting: wood_elves)
    fetters = wood_elves.attachments.first
    wood_elves.destroy!
    expect(wood_elves.zone).to eq(p2.graveyard)

    expect(fetters.zone).to eq(p1.graveyard)
    expect(fetters.card.zone).to eq(p1.graveyard)
  end
end
