module Magic
  module Cards
    MangaraTheDiplomat = Creature("Mangara, the Diplomat") do
      cost generic: 3, white: 1
      type "Legendary Creature - Human Cleric"
      power 2
      toughness 4
      keywords :lifelink

      def event_handlers
        {
          # Whenever an opponent attacks with creatures, if two or more of those creatures are
          # attacking you and/or planeswalkers you control, draw a card.
          Events::FinalAttackersDeclared => -> (receiver, event) do
            controller = receiver.controller
            incoming_attacks = event.attacks.select do |attack|
              attack.target == controller ||
              controller.planeswalkers.any? { |planeswalker| attack.target == planeswalker }
            end

            controller.draw! if incoming_attacks.count >= 2
          end,
          # Whenever an opponent casts their second spell each turn, draw a card.
          Events::SpellCast => -> (receiver, event) do
            spells_cast_by_player = current_turn.spells_cast.count { |spell| spell.player == event.player }
            receiver.controller.draw! if spells_cast_by_player == 2
          end
        }
      end
    end
  end
end
