module Magic
	module Cards
	  Cancel = Instant("Cancel") do
		cost generic: 1, blue: 2
	  end
  
	  class Cancel < Instant
		def single_target?
		  true
		end
  
		def target_choices
		  game.stack.spells
		end
  
		def resolve!(_controller, target:)
		  Effects::CounterSpell.new(source: self).resolve(target)
  
		  super
		end
	  end
	end
  end
