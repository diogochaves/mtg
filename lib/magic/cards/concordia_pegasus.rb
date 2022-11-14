module Magic
  module Cards
    ConcordiaPegasus = Creature("Concordia Pegasus") do
      type "Creature -- Pegasus"
      cost generic: 1, white: 1
      power 1
      toughness 3
      keywords :flying
    end
  end
end
