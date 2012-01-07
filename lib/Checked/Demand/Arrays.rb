module Checked
  class Demand
    class Arrays
      module Base
        
        include Demand::Base
        
        def array!
          case target
          when Array
          else
            fail! "is not an Array."
          end
        end
        
        def no_nils!
          array!
          if target.include?(nil)
            fail!("...can't contain nils.")
          end
        end

        def no_empty_strings!
          array!
          target.each { |s| 

            if s.respond_to?(:rewind) 
              s.rewind
            end

            final = if s.respond_to?(:readlines)
                      s.readlines
                    else
                      s
                    end

            if final.is_a?(String) && final.strip.empty?
              fail!("...can't contain empty strings.")
            end
          }
        end

        def symbols!
          array!
          not_empty!
          if !target.all? { |v| v.is_a?(Symbol) }
            fail! "...contains a non-symbol."
          end
        end

        def include! matcher
          included = target.include?(matcher)
          return true if included
          fail!("...must contain: #{matcher.inspect}")
        end

        def exclude! matcher
          raise_e = val.include?(matcher)
          return true unless raise_e
          fail!("...can't contain #{matcher.inspect}")
        end

        def matches_only! matcher
          arr = target.reject { |val| val == matcher }
          fail!( "...invalid elements: #{arr.inspect}" ) if !arr.empty?
        end

      end # === module Base
      
      include Base

    end # === class Arrays
  end # === class Demand
end # === module Checked
