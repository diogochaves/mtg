module Magic
  class Card
    include Types
    extend Forwardable
    def_delegators :@game, :battlefield, :current_turn

    include Cards::Keywords
    attr_reader :game, :name, :cost, :type_line, :countered, :keywords, :attachments, :protections, :delayed_responses, :counters
    attr_accessor :tapped

    attr_accessor :zone

    COST = {}
    KEYWORDS = []
    PROTECTIONS = []

    class << self
      def type(type)
        const_set(:TYPE_LINE, type)
      end

      def cost(cost)
        const_set(:COST, cost)
      end

      def power(power)
        const_set(:POWER, power)
      end

      def toughness(power)
        const_set(:TOUGHNESS, power)
      end

      def keywords(*keywords)
        const_set(:KEYWORDS, Keywords[*keywords])
      end

      def protections(*protections)
        const_set(:PROTECTIONS, *protections)
      end
    end

    def initialize(game: Game.new)
      @countered = false
      @name = self.class::NAME
      @type_line = self.class::TYPE_LINE
      @game = game
      cost = Costs::Mana.new(self.class::COST.dup)
      @cost = cost
      @tapped = tapped
      @attachments = []
      @delayed_responses = []
      @keywords = self.class::KEYWORDS
      @protections = self.class::PROTECTIONS
      super
    end

    def types
      type_line.scan(/\w+/) + attachments.flat_map(&:type_grants)
    end

    def inspect
      "#<Card name:#{name}>"
    end

    def to_s
      name
    end

    def mana_value
      cost.mana_value
    end
    alias_method :cmc, :mana_value
    alias_method :converted_mana_cost, :mana_value

    def multi_colored?
      colors.count > 1
    end

    def colors
      cost.colors
    end

    def colorless?
      colors.count == 0
    end

    def move_to_hand!(target_controller)
      move_zone!(target_controller.hand)
    end

    def move_to_graveyard!(target_controller)
      move_zone!(target_controller.graveyard)
    end

    def countered?
      countered
    end

    def resolve!(controller = nil, enters_tapped: enters_tapped?)
      if permanent?
        permanent = Magic::Permanent.resolve(game: game, controller: controller, card: self, from_zone: zone, enters_tapped: enters_tapped)
        move_zone!(game.battlefield)
        permanent
      end
    end

    alias_method :play!, :resolve!

    def discard!
      move_zone!(zone.owner.graveyard)
    end

    def exile!
      move_zone!(controller.exile)
    end

    def notify!(event)
      game.current_turn.notify!(event)
    end

    def enters_tapped?
      false
    end

    def activated_abilities
      []
    end

    def etb_triggers
      []
    end

    def death_triggers
      []
    end

    def static_abilities
      []
    end

    def event_handlers
      {}
    end

    private

    def move_zone!(new_zone)
      old_zone = zone
      if old_zone
        game.notify!(
          Events::CardLeavingZoneTransition.new(
            self,
            from: old_zone,
            to: new_zone
          )
        )

        old_zone.remove(self)
      end

      new_zone.add(self)

      game.notify!(
        Events::CardEnteredZoneTransition.new(
          self,
          from: old_zone,
          to: new_zone
        )
      )

    end
  end
end
