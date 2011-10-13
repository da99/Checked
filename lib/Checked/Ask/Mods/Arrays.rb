

module Checked
class Ask
module Mods
module Arrays
  
  def self.apply?(d)
    d.target.is_a?(Array)
  end

  def symbols?
    valid! target, :array!
    return false if target.empty?
    target.all? { |val| val.is_a? Symbol }
  end 
  
  def excludes? matcher
    !target.includes?(matcher)
  end
  
end # === module Arrays
end # === module Mods
end # === class Ask
end # === class Checked
