require 'spec_helper'

RSpec.describe Magic::Cards::SwiftResponse do
  include_context "two player game"

  let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p2) }

  let(:swift_response) { described_class.new(game: game) }

  it "destroy tapped wood elves" do
    p2_starting_life = p2.life
    p1.add_mana(white: 2)
    action = cast_action(player: p1, card: swift_response)
    action.pay_mana(generic: { white: 1 }, white: 1)
    action.targeting(wood_elves)
    game.take_action(action)
    game.tick!
    expect(wood_elves.zone).to be_graveyard
  end

  it "can't destroy untapped wood elves" do
    p2_starting_life = p2.life
    p1.add_mana(white: 2)
    action = cast_action(player: p1, card: swift_response)
    action.pay_mana(generic: { white: 1 }, white: 1)
    action.targeting(wood_elves)
    game.take_action(action)
    game.tick!
    expect(wood_elves.zone).to be_battlefield
  end

end
