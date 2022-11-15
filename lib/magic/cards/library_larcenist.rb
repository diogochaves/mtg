module Magic
  module Cards
    LibraryLarcenist = Creature("Library Larcenist") do
      type "Creature — Merfolk Rogue"
      cost generic: 2, blue: 1
      power 1
      toughness 2
    end

    class LibraryLarcenist < Creature
      def event_handlers
        {
          # whenever Library Larcenist attacks, draw a card.
          Events::FinalAttackersDeclared => -> (receiver, event) do
            controller = receiver.controller
            attacks = event.attacks
            return if attacks.none? { |event| event.attacker == receiver }

            controller.draw!
          end
        }
      end
    end
  end
end
