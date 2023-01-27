module Magic
  module Cards
    RiseAgain = Sorcery("Rise Again") do
      cost generic: 4, black: 1
    end

    class RiseAgain < Sorcery
      def target_choices
        controller.graveyard.creatures
      end

      def single_target?
        true
      end

      def resolve!(controller, target:)
        game.add_effect(
          # Effects::SearchGraveyard.new(
          #   source: permanent,
          #   choices: target_choices,
          #   resolve_action: -> (c) { c.move_zone!(game.battlefield) }
          # )
          Effects::MoveToBattlefield.new(
            battlefield: game.battlefield,
            maximum_choices: 1,
            choices: target_choices,
            targets: [target]
          )
        )

        super
      end
    end
  end
end
