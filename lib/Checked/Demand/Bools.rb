module Checked
  class Demand
    class Bools
        
      include Demand::Base

      route '/demand/bool/'
      def validate
        fail!("...must be a Boolean.") unless [TrueClass, FalseClass].include?(target.class)
      end
      
      route  '/demand/true/'
      def true!
        fail! "...must be true (TrueClass)." unless target.class == TrueClass
      end
      
      route  '/demand/false/'
      def false!
        fail! "...must be false (FalseClass)." unless target.class == FalseClass
      end

    end # === class Bools
  end # === class Demand
end # === module Checked
        

