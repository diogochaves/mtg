module Magic
  module Cards
    SiegeStriker = Creature("Siege Striker") do
      cost generic: 2, white: 1
      type "Creature -- Human Soldier"
      power 1
      toughness 1
      keywords :double_strike
    end

    class SiegeStriker < Creature
      def event_handlers
        {
          Events::PermanentTapped => -> (receiver, event) do
            return unless game.current_turn.active_player == receiver.controller
            return unless game.current_turn.step?(:declare_attackers)
            return unless event.permanent.creature?

            receiver.modifiers << Permanents::Creature::Buff.new(power: 1, toughness: 1, until_eot: true)
          end
        }
      end
    end
  end
end
