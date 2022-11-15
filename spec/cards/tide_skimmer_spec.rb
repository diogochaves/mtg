require 'spec_helper'

RSpec.describe Magic::Cards::TideSkimmer do
  include_context "two player game"

  subject(:tide_skimmer) { ResolvePermanent("Tide Skimmer", controller: p1) }
  let(:pegasus) { ResolvePermanent("Concordia Pegasus", controller: p1) }
  # let(:wood_elves) { ResolvePermanent("Wood Elves", controller: p1) }

  context "when attacking" do
    before do
      skip_to_combat!
    current_turn.declare_attackers!
    end

    it "draw a card if you attack with two or more creatures with flying" do
      current_turn.declare_attacker(tide_skimmer, target: p2)
      current_turn.declare_attacker(pegasus, target: p2)

      expect(p1).to receive(:draw!)
      current_turn.attackers_declared!
    end

  end
end
