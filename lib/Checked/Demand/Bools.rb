module Checked
  class Demand
    class Bools
      module Base
        
        include Demand::Base
        
        def bool!
          case target
          when FalseClass, TrueClass
          else
            fail! "...must be a boolean."
          end
        end
        
        def be! meth, *args
          answer = target.send meth, *args
          demand answer, :bool!
          return true if answer
          fail!("...failed #{meth} with #{args.inspect}")
        end

        def not_be! meth, *args
          bool!
          pass = target.send(meth, *args)
          demand pass, :bool!
          return true unless pass
          fail!("...#{meth} should not be true with #{args.inspect}")
        end
        
      end # === module Base
      
      include Base

    end # === class Bools
  end # === class Demand
end # === module Checked
        

