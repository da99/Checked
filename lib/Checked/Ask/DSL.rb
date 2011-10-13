require 'Checked/Demand/DSL'

module Checked
  class Ask
    module DSL

      include Demand::DSL

      def ask? target, *args
        Checked::Ask.new(target) { |a|
          a.<< args
        }.true?
      end

      def true? target, *args
        demand! block_given?, :no_block!
        q = Ask.new(target)
        q << args
        q.true?
      end

      def any? target, *args
        demand! block_given?, :no_block!
        q = Ask.new(target)
        q << args
        q.any?
      end
      
    end # === module DSL
  end # === class Ask
end # === module Checked
