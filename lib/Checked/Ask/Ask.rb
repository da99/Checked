
module Checked
  class Ask
    module Base
      
      include ::Checked::Base
      
      def records
        @records ||= []
      end
      
      private # ==============================
      
    end # === module Base
    
    def initialize *args
      raise "Not allowed to use this Class directly."
    end

  end # === class Ask
end # === module Checked
