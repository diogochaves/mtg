module Magic
  module Cards
    InfernalScarring = Aura("Infernal Scarring") do
      type "Enchantment -- Aura"
      cost generic: 1, black: 1
    end

    class InfernalScarring < Aura
      def target_choices
        battlefield.creatures
      end

      def power_buff
        2
      end

      def event_handlers
        {
          #Events::PermanentWillDie => -> (receiver, event) do
          Events::EnteredTheBattlefield => -> (receiver, event) do
            return unless event.permanent.controller == receiver.controller

            receiver.controller.draw!
          end
        }
      end
    end
  end
end
