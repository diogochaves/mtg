module Magic
  module Permanents
    class Enchantment < Permanent
      extend Forwardable
      def_delegators :@card, :power_buff, :toughness_buff, :can_attack?, :can_block?, :keyword_grants, :type_grants, :can_activate_ability?

      attr_reader :attached_to

      def attach_to!(permanent)
        permanent.attachments << self
        @attached_to = permanent
      end

    end
  end
end
