
module Checked
  class Demand
    class Symbols
      module Base

        include Demand::Base

        def symbol!
          case target
          when Symbole
          else
            fail! '...must be a symbol.'
          end
        end
        
      end # === module Base
    end # === class Symbols
  end # === class Demand
end # === module Checked
