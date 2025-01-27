require 'spec_helper'

RSpec.describe Magic::Game, "combat -- single attacker with vigilance, no blockers" do
  include_context "two player game"

  let!(:alpine_watchdog) { ResolvePermanent("Alpine Watchdog", controller: p1) }

  context "when in combat" do
    before do
      skip_to_combat!
    end

    it "p1 deals damage to p2" do
      p2_starting_life = p2.life

      current_turn.declare_attackers!

      current_turn.declare_attacker(
        alpine_watchdog,
        target: p2,
      )

      current_turn.attackers_declared!
      go_to_combat_damage!

      expect(p2.life).to eq(p2_starting_life - 2)
      expect(alpine_watchdog).not_to be_tapped
    end
  end
end
