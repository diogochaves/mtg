module Magic
  module Cards
    CelestialEnforcer = Creature("Celestial Enforcer") do
      power 2
      toughness 3
      cost generic: 2, white: 1
      type "Creature -- Human Cleric"
    end

    class CelestialEnforcer < Creature
      class ActivatedAbility < Magic::ActivatedAbility
        attr_reader :source

        def initialize(source:)
          @source = source
          @costs = [Costs::Tap.new(source)]
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
