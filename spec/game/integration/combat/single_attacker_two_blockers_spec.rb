require 'spec_helper'

RSpec.describe Magic::Game, "combat -- single attacker, weaker blocker" do
  include_context "two player game"

  let!(:odric) { ResolvePermanent("Odric, Lunarch Marshal", controller: p1) }
  let!(:wood_elves) { ResolvePermanent("Wood Elves",controller: p2) }
  let!(:vastwood_gorger) { ResolvePermanent("Vastwood Gorger", controller: p2) }

  context "when in combat" do
    before do
      skip_to_combat!
    end

    it "p2 blocks with a wood elves and vastwood gorger" do
      p2_starting_life = p2.life

      current_turn.declare_attackers!

      current_turn.declare_attacker(
        odric,
        target: p2,
      )

      current_turn.attackers_declared!

      current_turn.declare_blocker(
        wood_elves,
        attacker: odric,
      )

      current_turn.declare_blocker(
        vastwood_gorger,
        attacker: odric,
      )

      go_to_combat_damage!

      expect(odric.zone).to be_graveyard
      expect(wood_elves.zone).to be_graveyard
      expect(vastwood_gorger.zone).to be_battlefield
      expect(vastwood_gorger.damage).to eq(2)

      expect(p2.life).to eq(p2_starting_life)
    end
  end
end
