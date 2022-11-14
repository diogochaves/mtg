module Magic
  module Cards
    Shock = Instant("Shock") do
      cost red: 1
      type "Instant"
    end

    class Shock < Instant
      def target_choices
        battlefield.cards.by_any_type("Creature", "Planeswalker")
      end

      def single_target?
        true
      end

      def resolve!(_controller, target:)
        game.add_effect(Effects::DealDamage.new(source: self, targets: [target], damage: 2))
        super
      end
    end
  end
end
