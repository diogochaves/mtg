module Magic
  module Cards
    LegionsJudgement = Sorcery("Legion's Judgement") do
      cost generic: 2, white: 1
    end

    class LegionsJudgement < Sorcery
      def target_choices
        battlefield.creatures.with_power { |power| power >= 4 }
      end

      def single_target?
        true
      end

      def resolve!(controller, target:)
        game.add_effect(Effects::DestroyTarget.new(source: self,  targets: [target], choices: target_choices))

        super
      end
    end
  end
end
