module Checked

  module Base

    include Uni_Arch::Base
    
    def target_klass
      klass = self.class.name.split('::').last.sub(%r!s/Z!, '')
      if klass == 'Var'
        klass
      else
        eval klass
      end
    end

    def target
      request.env.target
    end
    
    def original_target
      request.headers.check_target
    end
    

    def target_name
      if target.respond_to?(:english_name)
        target.english_name 
      else
                         "#{target.class.name.gsub('_', ' ')}"
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
                     if temp
                       temp.downcase.sub(/er$/, '')
                     else
                       raise "Unknown purpose"
                     end
                   end
    end
    
    def fail! msg
      raise Checked::Demand::Failed, "#{request.env.target.inspect} #{msg}"
    end

  end # === module Base
  
end # === module Checked

