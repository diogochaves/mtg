require 'spec_helper'

RSpec.describe Magic::Cards::LibraryLarcenist do
  include_context "two player game"

  subject(:library_larcenist) { ResolvePermanent("Library Larcenist", controller: p1) }

  context "when attacking" do
    before do
      skip_to_combat!
      current_turn.declare_attackers!
    end

    it "controller draws a card" do
      current_turn.declare_attacker(library_larcenist, target: p2)
      expect(p1).to receive(:draw!)
      current_turn.attackers_declared!
    end
  end
end
