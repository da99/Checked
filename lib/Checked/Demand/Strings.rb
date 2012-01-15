
class Checked
  class Demand
    class Strings < Sinatra::Base

      include Checked::Arch
      map '/string!'
      
      get
      def check!
        case return!
        when String
          
          return!
        when StringIO
          target.rewind
          return! target.readlines
          target.rewind
          
          return!
        else
          demand false, "...must be a String or StringIO."
        end
      end

      get
      def include!
        demand return![matcher], "...must contain: #{matcher.inspect}"
      end

      get
      def exclude! matcher
        demand !(return![matcher]), "...can't contain #{matcher.inspect}"
      end

      get
      def matches_only!
        invalid = return!.gsub(matcher, '')
        demand invalid.empty?, "...has invalid characters: #{str.inspect}" 
      end

      get
      def not_empty!
        demand !(return!.strip.empty?), "...can't be empty."
      end

      get
      def file_read!
        return!.gsub("\r\n", "\n")
      end
      
      get
      def new_content!
        not_empty!   
        file_read!
      end

      get
      def file_content! 
        new_content!
      end

      get
      def hostname!
        invalid = return![ %r!([^\dA-Za-z_-]+)! ]
        demand !invalid, "...has invalid characters: #{$1.inspect}"
      end

    end # === class String
  end # === class Demand
end # === class Checked

