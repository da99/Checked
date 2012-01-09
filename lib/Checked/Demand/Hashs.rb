module Checked
  class Demand
    class Hashs
      
      include Demand::Base

      namespace '/hash!'

      before
      def validate_target_class
        fail!("...must be a Hash") unless hash?(target)
      end

      route
      def symbol_keys!
        keys = target.keys

        if keys.all? { |k| k.is_a?(Symbol) }
          # do nothing
        else
          fail! '...must have all symbol keys.'
        end
      end

    end # === class Hashs
  end # === class Demand
end # === module Checked


