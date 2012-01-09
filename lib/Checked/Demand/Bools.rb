module Checked
  class Demand
    class Bools
        
      include Demand::Base

      namespace '/bool!'

      before
      def validate
        fail!("...must be either of TrueClass or FalseClass.") unless [TrueClass, FalseClass].include?(target.class)
      end
      
      route
      def true!
        fail! "...must be true (TrueClass)." unless target.class == TrueClass
      end
      
      route 
      def false!
        fail! "...must be false (FalseClass)." unless target.class == FalseClass
      end

    end # === class Bools
  end # === class Demand
end # === module Checked
        

