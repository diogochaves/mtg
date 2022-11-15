module Magic
  module Cards
    BloodGlutton = Creature("Blood Glutton") do
      type "Creature -- Vampire"
      cost generic: 4, black: 1
      power 4
      toughness 3
      keywords :lifelink
    end
  end
end
