
module Checked
  class Demand
    module DSL
      
      def demand! target, *args
        if block_given?
          raise "No block allowed here."
        end
        
        Demand.new(target) { |d|
          d.<< args
        }.target
      end
      
      def named_demand! name, target, *args
        if block_given?
          raise "No block allowed here."
        end
        
        Demand.new(target) { |d|
          d.* name
          d.<< args
        }.target
      end
      
    end # === module Dsl
  end # === class Demand
end # === module Checked
