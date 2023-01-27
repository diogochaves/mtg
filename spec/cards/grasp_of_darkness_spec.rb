require 'spec_helper'

RSpec.describe Magic::Cards::GraspOfDarkness do
  include_context "two player game"

  subject { Card("Grasp Of Darkness") }

  context "creature with toughness bigger than 4" do
    let!(:aegis_turtle) { ResolvePermanent("Aegis Turtle", controller: p1) }

    it "debuffs the target creature" do
      p1.add_mana(black: 2)
      action = cast_action(player: p1, card: subject)
                .pay_mana(black: 2)
                .targeting(aegis_turtle)
      game.take_action(action)
      game.stack.resolve!
      buff = aegis_turtle.modifiers.first
      expect(buff.power).to eq(-4)
      expect(buff.toughness).to eq(-4)
      expect(buff.until_eot?).to eq(true)
      expect(aegis_turtle.power).to eq(-4)
      expect(aegis_turtle.toughness).to eq(1)
      expect(aegis_turtle.zone).to be_battlefield
    end
  end

  context "creature with toughness less than 4" do
    let!(:wood_elves) { ResolvePermanent("Wood Elves", controller: p1) }
    it "debuffs the target creature and destroy it" do
      p1.add_mana(black: 2)
      action = cast_action(player: p1, card: subject)
            .pay_mana(black: 2)
            .targeting(wood_elves)
      game.take_action(action)
      game.stack.resolve!
      buff = wood_elves.modifiers.first
      expect(buff.power).to eq(-4)
      expect(buff.toughness).to eq(-4)
      expect(buff.until_eot?).to eq(true)
      expect(wood_elves.power).to eq(-3)
      expect(wood_elves.toughness).to eq(-3)
      expect(wood_elves.zone).to be_graveyard
    end
  end
end
