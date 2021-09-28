module Magic
  module Effects
    class CounterSpell
      def requires_choices?
        true
      end

      def resolve(target:)
        target.counter!
      end
    end
  end
end