require "Checked/Base"
require "Checked/Demand/DSL"


module Checked

  class Demand

    Failed = Class.new(RuntimeError)

    module Base
      
      include DSL
      include ::Checked::Base


      def err_msg msg = "...is invalid."
        message = if msg.strip[ %r!^\.\.\.! ]
                    msg.sub('...', '').strip
                  else
                    msg
                  end
      
        @err_msg || "#{target_name} #{message}"
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
    
    include Base
    
  end # === class Demand
  
end # === module Checked


