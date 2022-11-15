module Magic
  module Cards
    SwiftResponse = Instant("Swift Response") do
      cost generic: 1, white: 1
    end

    class SwiftResponse < Instant
      def target_choices
        battlefield.creatures
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
