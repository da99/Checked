
module Checked
  class Ask
    class Vars
      
      include Ask::Base

      namespace '/var!'

      route
      def respond_to?
        answ = args.map { |a|
          target.respond_to? a
        }.uniq == [true]
        
        answ
      end

    end # === class Vars
  end # === class Ask
end # === module Checked
