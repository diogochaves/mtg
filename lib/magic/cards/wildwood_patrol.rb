module Magic
  module Cards
    WildwoodPatrol = Creature("Wildwood Patrol") do
      type "Creature -- Centaur Scout"
      cost generic: 2, green: 1
      power 4
      toughness 2
      keywords :trample
    end
  end
  end
