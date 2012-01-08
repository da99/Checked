

module Checked
  class Demand
    class Hashs
      include Demand::Base

      namespace '/demand/hash/'

      route
      def symbol_keys!
        keys = request.env.target.keys

        if keys.all? { |k| k.is_a?(Symbol) }
          # do nothing
        else
          fail! '...must have all symbol keys.'
        end
      end

    end # === class Hashs
  end # === class Demand
end # === module Checked



Checked::Arch.use Checked::Demand::Hashs

