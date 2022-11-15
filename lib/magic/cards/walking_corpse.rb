module Magic
  module Cards
    WalkingCorpse = Creature("Walking Corpse") do
      type "Creature -- Zombie"
      cost generic: 1, black: 1
      power 2
      toughness 2
    end
  end
end
