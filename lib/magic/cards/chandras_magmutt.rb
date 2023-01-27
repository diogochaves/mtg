module Magic
  module Cards
    ChandrasMagmutt = Creature("Chandra's Magmutt") do
      power 2
      toughness 2
      cost generic: 1, red: 1
      type "Creature -- Elemental Dog"
    end

    class ChandrasMagmutt < Creature
      class ActivatedAbility < Magic::ActivatedAbility
        attr_reader :source

        def initialize(source:)
          @source = source
          @costs = [Costs::Mana.new(generic: 1, white: 1), Costs::Tap.new(source)]
          super(
            source: source,
            requirements: [
              -> {
                source.controller.creatures.any?(&:flying?)
              }
            ]
          )
        end

        def single_target?
          true
        end

        def resolve!(target:)
          target.tap!
        end
      end
    end
  end
end
