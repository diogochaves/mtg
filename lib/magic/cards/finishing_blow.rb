module Magic
  module Cards
    FinishingBlow = Instant("Finishing Blow") do
      cost generic: 4, black: 1
    end

    class FinishingBlow < Instant
      def target_choices
        battlefield.cards.by_any_type("Creature", "Planeswalker")
      end

      def single_target?
        true
      end

      def resolve!(_controller, target:)
        target.destroy!

        super
      end
    end
  end
end
