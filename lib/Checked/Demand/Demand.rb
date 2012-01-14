
class Checked
  class Demand
    Failed = Class.new(RuntimeError)
        
    def initialize *args
      raise "Demand not allowed to be used."
    end
  end # === class Demand	
end # === class Checked


