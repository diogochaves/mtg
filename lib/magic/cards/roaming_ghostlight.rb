module Magic
  module Cards
    RoamingGhostlight = Creature("Roaming Ghostlight") do
      cost generic: 3, blue: 2
      type "Creature -- Spirit"
      power 3
      toughness 2
      keywords :flying
    end

    class RoamingGhostlight < Creature
      class ETB < TriggeredAbility::EnterTheBattlefield
        def perform
          
        end
      end

      def etb_triggers = [ETB]
    end
  end
end
