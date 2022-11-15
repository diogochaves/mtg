module Magic
  module Cards
    RambunctiousMutt = Creature("Rambunctious Mutt") do
      cost generic: 3, white: 2
      type "Creature -- Dog"
      power 3
      toughness 4
    end

    class RambunctiousMutt < Creature
      class ETB < TriggeredAbility::EnterTheBattlefield
        def perform
          effect = Effects::DestroyTarget.new(
            source: permanent,
            choices: game.battlefield.cards.by_any_type("Artifact", "Enchantment").not_controlled_by(controller)
          )
          game.add_effect(effect)
        end
      end

      def etb_triggers = [ETB]
    end
  end
end
