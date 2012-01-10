

module Checked
  class Demand

    Failed = Class.new(RuntimeError)

    module Base
      
      include Checked::Base
      
      def err_msg msg = "...is invalid."
        message = if msg.strip[ %r!^\.\.\.! ]
                    msg.sub('...', '').strip
                  else
                    msg
                  end
      
        t = if original_target != target
              "#{original_target.inspect} (#{target})"
            else
              original_target.inspect
            end
        @err_msg || "#{target_name}, #{t}, #{message}"
      end

      def err_msg= msg
        demand! msg, :string!, :not_empty!
        @err_msg = msg
      end
      
      private # ==========================================

      def fail! msg
        raise Failed, err_msg(msg)
      end

    end # === module Base
    
    def initialize *args
      raise "Demand not allowed to be used."
    end
    
  end # === class Demand
end # === module Checked


