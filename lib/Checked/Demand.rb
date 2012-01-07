

module Checked

  class Demand

    Failed = Class.new(RuntimeError)

    module Base
      
      include ::Checked::Base
      
      def initialize *args
        super
        validate_type
      end
        
      def validate_type
        self.class.included_modules.each { |mod|
          mod.to_s =~ %r!Demand::(.+)::Base\Z!
          next unless $1
          name = ( $1.downcase.sub(/s\Z/, '') + '!' ).to_sym
          send name if respond_to?(name)
        }
      end

      def err_msg msg = "...is invalid."
        message = if msg.strip[ %r!^\.\.\.! ]
                    msg.sub('...', '').strip
                  else
                    msg
                  end
      
        @err_msg || "#{target_name}, #{original_target.inspect}, #{message}"
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


