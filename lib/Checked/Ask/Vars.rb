
class Checked
  class Ask
    class Vars < Sinatra::Base
      
      include Checked::Arch

      map '/var!'

      get
      def respond_to_all?
        return false if args_hash['args'].empty?

        args_hash['args'].all? { |a|
          return!.respond_to? a
        }
      end

      get
      def respond_to_any?
        args_hash['args'].any? { |a|
          return!.respond_to? a
        }
      end

    end # === class Vars
  end # === class Ask
end # === class Checked
