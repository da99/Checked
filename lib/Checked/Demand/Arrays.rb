module Checked
  class Demand
    class Arrays

      include Demand::Base

      namespace '/array!'
      
      before
      def validate_target_class
        fail! "...is not an Array." unless array?(target)
      end

      route
      def no_nils!
        if target.include?(nil)
          fail!("...can't contain nils.")
        end
      end

      route
      def no_empty_strings!
        target.each { |s| 

          if s.respond_to?(:rewind) 
            s.rewind
          end

          final = if s.respond_to?(:readlines)
                    s.readlines
                  else
                    s
                  end

          if !final.is_a?(::String)
            fail!("Array contains unknown class: #{final.inspect}")
          end
          
          if final.is_a?(String) && final.strip.empty?
            fail!("...can't contain empty strings.")
          end
        }
      end

      route
      def symbols!
        not_empty!
        if !target.all? { |v| v.is_a?(Symbol) }
          fail! "...contains a non-symbol."
        end
      end

      route
      def include! 
        return true if target.include?(matcher)
        fail!("...must contain: #{matcher.inspect}")
      end

      route
      def exclude! 
        raise_e = val.include?(matcher)
        return true unless raise_e
        fail!("...can't contain #{matcher.inspect}")
      end

      route
      def matches_only! 
        arr = target.reject { |val| val == matcher }
        fail!( "...invalid elements: #{arr.inspect}" ) if !arr.empty?
      end
      
      private


    end # === class Arrays
  end # === class Demand
end # === module Checked

