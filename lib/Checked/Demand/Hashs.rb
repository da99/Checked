module Checked
  class Demand
    class Hashs
      
      include Uni_Arch::Base
      include Demand::Base
      namespace '/hash!'

      route
      def check!
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


