require 'spec_helper'

RSpec.describe Magic::Cards::FinishingBlow do
  include_context "two player game"

  subject(:card) { Card("Finishing Blow") }

  context "destroys a creature" do
    let(:loxodon_wayfarer) { ResolvePermanent("Loxodon Wayfarer", controller: p1) }
    it "destroys the creature" do
      action = cast_action(card: card, player: p1).targeting(loxodon_wayfarer)
      add_to_stack_and_resolve(action)
      expect(loxodon_wayfarer.zone).to be_graveyard
    end
  end

  context "destroys a planeswalker" do
    let(:basri_ket) { ResolvePermanent("Basri Ket", controller: p1) }

    it "destroys the planeswalker" do
      action = cast_action(card: card, player: p1).targeting(basri_ket)
      add_to_stack_and_resolve(action)
      expect(basri_ket.zone).to be_graveyard
    end
  end
end
