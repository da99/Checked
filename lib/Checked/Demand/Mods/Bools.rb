
module Checked
class Demand
module Mods
module Bools
        
  def self.before_apply d
  end

  def self.apply? d
    target = d.target
    target.is_a?( FalseClass ) ||
      target.is_a?(TrueClass)
  end
  
  def self.after_apply d
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
        
end # === module Bools      
end # === module Mods
end # === class Demand
end # === module Checked
