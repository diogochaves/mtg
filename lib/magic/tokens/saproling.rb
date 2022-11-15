module Magic
  module Tokens
    class Saproling < Creature
      POWER = 1
      TOUGHNESS = 1
      NAME = "Saproling"
      TYPE_LINE = "Token Creature -- Saproling"

      def colors
        [:green]
      end
    end
  end
end
