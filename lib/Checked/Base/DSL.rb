
module Checked
  module DSL
    
    # ============ Demand ==============
    
    def demand *args
      raise "No block allowed here." if block_given?
      
      Demand.new( *args )
    end
    
    %w{ Arrays Bools File_Paths Strings Symbols Hashs }.each { |plural|
      single = plural.downcase.sub(/s\Z/, '')
      
      eval %~
        def #{single}! *args, &blok
          ::Checked::DSL::Obj.new( 'demand', '#{single}', *args )
        end
      ~
    }

    # ============= Ask ================

    def ask? target, *args
      Checked::Ask.new(target) { |a|
        a.<< args
      }.true?
    end

    def true? target, *args
      demand! block_given?, :no_block!
      q = Ask.new(target)
      q << args
      q.true?
    end

    def any? target, *args
      demand! block_given?, :no_block!
      q = Ask.new(target)
      q << args
      q.any?
    end

    # ============ Clean ===============
    
    def clean target, *args
      raise "No block allowed here." if block_given?

      c = Clean.new(target)
      c.<(*args)
      c.target
    end


  end # === module DSL
end
