
module Checked
  class Clean
    module DSL

      def clean target, *args
        raise "No block allowed here." if block_given?

        c = Clean.new(target)
        c.<(*args)
        c.target
      end

    end # === module DSL
  end # === class Clean
end # === module Checked
