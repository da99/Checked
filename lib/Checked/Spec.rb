
class Checked
  
  class Specs
    
    include Term::ANSIColor
      
    def initialize
      @specs = []
      @print = true
    end

    def spec val, msg
      if to_a.empty?
        at_exit { ::Checked::SPECS.print }
      end
      @specs << [val, msg]
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
      return nil if $! || !print?
      @specs.each { |pair|
        
        val, msg = pair
        
        if val
          puts green(msg)
        else
          puts red(msg)
        end
        
      }
    end

  end # === class Specs
  
  SPECS = Specs.new
end # === class Checked
