require 'spec_helper'

RSpec.describe Magic::Cards::Shock do
  include_context "two player game"

  subject(:card) { Card("Shock") }

  context "deals 2 damage to a creature" do
    let(:loxodon_wayfarer) { ResolvePermanent("Loxodon Wayfarer", controller: p1) }
    it "deals 2 damage to a creature" do
      action = cast_action(card: card, player: p1).targeting(loxodon_wayfarer)
      add_to_stack_and_resolve(action)
	  expect(loxodon_wayfarer.damage).to eq(2)
    end
  end

  context "deals 2 damage to a planeswalker" do
	pending
  end

  context "deals 2 damage to an opponent" do
	it "deals 2 damage to an opponent" do
		action = cast_action(card: card, player: p1).targeting( player: p2)
		expect { subject.receive_notification(event) }.to(change { p2.life }.by(-2))
	end
  end

  context "deals 2 damage to yourself" do
	it "deals 2 damage to yourself" do
		action = cast_action(card: card, player: p1).targeting( player: p1)
		expect { subject.receive_notification(event) }.to(change { p1.life }.by(-2))
	end
  end
end
