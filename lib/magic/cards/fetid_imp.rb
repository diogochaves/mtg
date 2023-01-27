module Magic
  module Cards
    FetidImp = Creature("Fetid Imp") do
      type "Creature -- Imp"
      power 1
      toughness 2
      keywords :flying
    end

    class FetidImp < Creature
      class ActivatedAbility < Magic::ActivatedAbility
        def costs
          [Costs::Mana.new(black: 1)]
        end

        def resolve!
          source.grant_keyword(Keywords::DEATHTOUCH, until_eot: true)
        end
      end

      def activated_abilities = [ActivatedAbility]
    end
  end
end
