module Magic
  module Cards
    class GriffinAerie < Card
      NAME = "Griffin Aerie"
      TYPE_LINE = "Enchantment"
      COST = { generic: 1, white: 1 }

      def event_handlers
        {
          Events::BeginningOfEndStep => -> (receiver, event) do
            controller = receiver.controller
            return unless event.active_player == controller
            life_gain_events = game.current_turn.events.select do |event|
              event.is_a?(Events::LifeGain) && event.player == controller
            end
            life_gained = life_gain_events.sum(&:life)

            if life_gained >= 3
              Permanent.resolve(game: game, controller: controller, card: Tokens::Griffin.new)
            end
          end
        }
      end
    end
  end
end
