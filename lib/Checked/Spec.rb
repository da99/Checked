
class Checked
  
  class Spec
    Fail = Class.new(RuntimeError)
  end

  class Specs
    
    include Term::ANSIColor
      
    def initialize
      @specs = []
      @print = true
    end

    def spec val, msg
      if to_a.empty?
        at_exit { ::Checked::SPECS.print if !$! && ::Checked::SPECS.print? }
      end
      @specs << [val, msg]
    end
    
    def spec! val, msg
      if val
        spec val, msg
      else
        print
        dont_print
        raise Checked::Spec::Fail, red(msg)
      end
    end
    
    def to_a
      @specs
    end
    
    def dont_print
      @print = false
    end

    def print?
      @print
    end

    def print
      @specs.each { |pair|
        
        val, msg = pair
        
        if val
          $stdout.print green(msg), "\n"
        else
          $stdout.print red(msg), "\n"
        end
        
      }
    end

  end # === class Specs
  
  SPECS = Specs.new
end # === class Checked
