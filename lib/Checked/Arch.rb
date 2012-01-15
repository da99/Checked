class Checked

  module Arch
    include DSL::Ruby

    def self.included klass
      klass.send :include, Sin_Arch::Arch
    end
    
    def target_name
      request.env['target_name']
    end

    def original_target
      request.env['original_target']
    end

    def matcher
      @matcher ||= begin
                    m = args_hash['args'].first
                    if !m
                      raise Sin_Arch::Missing_Argument, "Missing argument for matcher."
                    end
                    m
                   end
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
