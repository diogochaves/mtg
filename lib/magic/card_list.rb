module Magic
  class CardList < SimpleDelegator
    def controlled_by(player)
      select { |card| card.controller == player }
    end

    def not_controlled_by(player)
      select { |card| card.controller != player }
    end

    def basic_lands
      select(&:basic_land?)
    end

    def creatures
       select(&:creature?)
    end

    def planeswalkers
      select(&:planeswalker?)
    end

    def permanents
      select { |card| card.is_a?(Magic::Permanent) }
    end

    def permanent_types
      by_any_type(*%w(Artifact Creature Enchantment Land Planeswalker))
    end

    def dead
      select(&:dead?)
    end

    def with_power(&block)
      select { |creature| yield(creature.power) }
    end

    def by_name(name)
      select { |c| c.name == name }
    end

    def cmc_lte(cmc)
      select { |c| c.cmc <= cmc }
    end

    def by_any_type(*types)
      select { |c| c.any_type?(*types) }
    end
    alias_method :by_type, :by_any_type

    def except(target)
      self.class.new(reject { |c| c == target })
    end

    private

    def select(&condition)
      self.class.new(super(&condition))
    end

  end
end
