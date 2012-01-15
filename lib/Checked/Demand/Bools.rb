class Checked
  class Demand
    class Bools < Sinatra::Base
        
      include Checked::Arch
      map '/bool!'

      get
      def check!
        is_bool = [TrueClass, FalseClass].include?(return!.class)
        demand is_bool, "...must be either of TrueClass or FalseClass."
      end
      
      get
      def true!
        is_true = return!.class == TrueClass
        demand is_true, "...must be true (TrueClass)." 
      end
      
      get 
      def false!
        is_false = return!.class == FalseClass
        demand is_false, "...must be false (FalseClass)." 
      end

    end # === class Bools
  end # === class Demand
end # === class Checked
        

