module Magic
  module Cards
    RainOfRevelation = Instant("Rain of Revelation") do
      cost generic: 3, blue: 1
    end

    class RainOfRevelation < Instant
      def resolve!(controller)
        # Draw three cards, then discard a card.
        controller.draw!(3)
        #TODO: discard a card

        super #needed?
      end
    end
  end
end
