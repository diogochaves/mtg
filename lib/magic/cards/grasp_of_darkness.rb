module Magic
  module Cards
    GraspOfDarkness = Instant("Grasp of Darkness") do
      cost black: 2
    end

    class GraspOfDarkness < Instant
      def target_choices
        battlefield.creatures
      end

      def single_target?
        true
      end

      def resolve!(controller, target:)
        if target.zone == battlefield
          game.add_effect(Effects::ApplyBuff.new(source: self, power: -4, toughness: -4, targets: target))
        end

        super
      end
    end
  end
end
