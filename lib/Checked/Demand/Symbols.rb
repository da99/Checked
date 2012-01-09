
module Checked
  class Demand
    class Symbols

      include Demand::Base

      namespace '/demand/symbol'
      
      before
      def check
        case target
        when Symbol
        else
          fail! '...must be a Symbol.'
        end
      end

    end # === class Symbols
  end # === class Demand
end # === module Checked
