
module Checked
  class Demand
    class Symbols

      include Uni_Arch::Base
      include Demand::Base
      namespace '/symbol!'
      
      route
      def check!
        case target
        when Symbol
        else
          fail! '...must be a Symbol.'
        end
      end

    end # === class Symbols
  end # === class Demand
end # === module Checked
