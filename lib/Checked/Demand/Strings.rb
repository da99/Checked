
module Checked
  class Demand
    class String
      module Base
        include ::Checked::Demand::Base
        
        def string!
          case target
          when String
          when StringIO
            target.rewind
            target= target.readlines
            target.rewind
          else
            fail! "...must be a String or StringIO"
          end
        end
        
        def include! matcher
          included = target[matcher]
          return true if included
          fail!("...must contain: #{matcher.inspect}")
        end

        def exclude! matcher
          raise_e = val[matcher]
          return true unless raise_e
          fail!("...can't contain #{matcher.inspect}")
        end

        def matches_only! matcher
          str = target.gsub(matcher, '')
          if !str.empty?
            fail!( "...has invalid characters: #{str.inspect}" ) 
          end
        end

        def not_empty!
          if target.strip.empty? 
            fail!("...can't be empty.") 
          end
        end
        
      end # === module Base
    end # === class String
  end # === class Demand
end # === module Checked

