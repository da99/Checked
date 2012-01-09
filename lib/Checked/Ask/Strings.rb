
module Checked
  class Ask
      class Strings

        include Ask::Base
        
        namespace '/string!'

        route
        def empty?
          target.strip.empty?
        end

        route
        def include? 
          !!target[*args]
        end

        route
        def exclude? 
          !target[*args]
        end

      end # === class Strings
  end # === class Ask
end # === module Checked
