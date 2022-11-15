module Magic
  module Cards
    ValorousSteed = Creature("Valorous Steed") do
      cost generic: 4, white: 1
      type "Creature -- Unicorn"
      power 3
      toughness 3
	  keywords :vigilance
    end

    class ValorousSteed < Creature
      class ETB < TriggeredAbility::EnterTheBattlefield
        def perform
          Permanent.resolve(game: game, controller: controller, card: Tokens::Knight.new)
        end
      end

      def etb_triggers = [ETB]
    end
  end
end
