
module Checked
  class Demand
    class Strings

      include Uni_Arch::Base
      include Demand::Base
      namespace '/string!'
      
      route
      def check!
        case target
        when String
        when StringIO
          target.rewind
          request.response.body= target.readlines
          target.rewind
        else
          fail! "...must be a String or StringIO"
        end
      end

      route
      def include!
        included = target[matcher]
        return true if included
        fail!("...must contain: #{matcher.inspect}")
      end

      route
      def exclude! matcher
        raise_e = val[matcher]
        return true unless raise_e
        fail!("...can't contain #{matcher.inspect}")
      end

      route
      def matches_only!
        str = target.gsub(matcher, '')
        if !str.empty?
          fail!( "...has invalid characters: #{str.inspect}" ) 
        end
      end

      route
      def not_empty!
        if target.strip.empty? 
          fail!("...can't be empty.") 
        end
      end

      route
      def file_read!
        request.response.body= target.gsub("\r\n", "\n")
      end

      route
      def file_content! 
        not_empty!   
        file_read!
      end

    end # === class String
  end # === class Demand
end # === module Checked

