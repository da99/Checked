module Checked

  module Base

    include Uni_Arch::Base

    CHECK = begin
              o = Object.new
              o.extend Checked::DSL
              o
            end

    def target_klass
      klass = self.class.name.split('::').last.sub(%r!s/Z!, '')
      if klass == 'Var'
        klass
      else
        eval klass
      end
    end

    def target
      request.response.body
    end
    
    def original_target
      request.headers.check_target
    end
    
    def target_name
      if target.respond_to?(:english_name)
        return target.english_name 
      end
      
      if request.headers.has_key?(:check_name) && request.headers.check_name
        return request.headers.check_name
      end
      
      target.class.name.gsub('_', ' ')
    end
    
    def args
      request.headers.args
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
    
    def not_empty!
      fail!('...can\'t be empty.') if target.empty?
    end

    def be! meth, *args
      answer = target.send meth, *args
      demand answer, :bool!
      return true if answer
      fail!("...failed #{meth} with #{args.inspect}")
    end

    def not_be! meth, *args
      bool!
      pass = target.send(meth, *args)
      demand pass, :bool!
      return true unless pass
      fail!("...#{meth} should not be true with #{args.inspect}")
    end

    def array? val
      respond_to_all?( val, :[], :pop )
    end

    def hash? val
      respond_to_all?( val, :[], :keys, :values )
    end
    
    def respond_to_all? val, *meths
      meths.map { |m|
        val.respond_to? m
      }.uniq == [true]
    end

    def matcher
      request.headers.matcher
    end

    def strip_target
      request.response.body= target.strip
    end

  end # === module Base
  
end # === module Checked

