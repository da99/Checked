
class Checked
  class Ask
    class Vars < Sinatra::Base
      
      include Checked::Arch

      map '/var!'

      get
      def respond_to_all?
        a = not_empty_args!

        a.all? { |a|
          return!.respond_to? a
        }
      end

      get
      def respond_to_any?
        a = not_empty_args!
        
        a.any? { |a|
          return!.respond_to? a
        }
      end
      
    end # === class Vars
  end # === class Ask
end # === class Checked
