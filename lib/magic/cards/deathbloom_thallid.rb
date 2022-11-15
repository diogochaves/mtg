module Magic
  module Cards
    DeathbloomThallid = Creature("Deathbloom Thallid") do
      type "Creature -- Fungus"
      cost generic: 2, black: 1
      power 3
      toughness 2
    end
  
    class DeathbloomThallid < Creature
      class Death < TriggeredAbility::Death
        def perform
          Tokens::Saproling.new(game: game).resolve!(controller)
        end
      end
      
      def death_triggers = [Death]
    end
  end
end
