module Magic
  module Cards
    TideSkimmer = Creature("Tide Skimmer") do
      type "Creature — Drakee"
      cost generic: 3, blue: 1
      power 2
      toughness 3
    keywords :flying
    end

    class TideSkimmer < Creature
      def event_handlers
        {
          # Whenever you attack with two or more creatures with flying, draw a card.
          Events::FinalAttackersDeclared => -> (receiver, event) do
            controller = receiver.controller
            attacks = event.attacks
            return if attacks.count { |event| event.attacker.flying? } < 2

            controller.draw!
          end
        }
      end
    end
  end
end
