class Checked

  module Arch
    
    module Class_Methods
      def map name
        @map = name
      end
    end # === module Class_Methods
    
    def self.included klass
      klass.extend Class_Methods
    end
    
    include DSL::Racked
    
    def initialize *args
      @target = nil
      super
    end
    
    def request
      self
    end

    def env
      @env ||= {}
    end

    def return! val = :return_it
      return @target if val === :return_it
      @target = val
    end
    
    def target_name= val
      request.env['target_name'] = val
    end

    def target_name
      request.env['target_name']
    end

    def original_target
      request.env['original_target']
    end
    
    #
    # ::Checked::Demand::Arrays => demand
    # ::Checked::Clean::Arrays  => clean
    # ::Checked::Ask::Arrays    => ask
    #
    def purpose
      @purpose ||= begin
                     temp = self.class.name.split('::')[-2]
                     (temp && temp.downcase) || raise("Unknown purpose")
                   end
    end

    private

    def strip_target
      return! return!.strip
    end

    def not_empty_args!
      not_empty! args_hash['args']
    end
      
    def fail! raw_msg
      msg = if raw_msg['...'] == 0
              raw_msg.sub '...', target_name
            else
              raw_msg
            end

      super(msg)
    end
    
  end # === module Arch
  
end # === module Checked

