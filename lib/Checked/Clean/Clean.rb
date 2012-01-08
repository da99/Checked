
module Checked
  class Clean
    module Base
      
      private # =============================
      include ::Checked::DSL

      public # ==============================
      include ::Checked::Base

      def < meth, *args
        val = super
        named_demand!("Cleaned val", val, :not_nil!)
          
        self.target= super
      end
      
      def << *args
        args.flatten.each { |name|
          self.< name
        }
      end

      private # ===========================================
      
      def target= val
        named_demand! "Clean target", val, :not_nil!
          
        @target = val
      end

    end # === module Base
    
    include Base
    
  end # === class Clean
end # === class Checked
