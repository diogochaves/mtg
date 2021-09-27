module Magic
  module Cards
    class ChargeThrough < Instant
      def initialize(**args)
        super(
          name: "Charge Through",
          cost: { green: 1 },
          **args
        )
      end

      def resolve!
        controller.draw!
        super
      end
    end
  end
end