module Magic
  module Cards
    class EssenceWarden < Creature
      NAME = "Essence Warden"
      COST = { green: 1 }
      TYPE_LINE = "Creature -- Elf Shaman"

      def notify(event)
        case event
        when Events::EnterTheBattlefield
          card = event.card
          game.add_effect(
            Effects::CreatureEntersControllerGainsLife.new(
              source: self,
              controller: controller,
              card: card,
              life: 1
            )
          )
        end
      end
    end
  end
end