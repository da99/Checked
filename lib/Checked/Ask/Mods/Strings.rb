
module Checked
class Ask
module Mods
module Strings

  def self.apply? d
    d.target.is_a?(String)
  end
  
  def empty?
    target.strip.empty?
  end
  
  def includes? matcher
    !!target[matcher]
  end
  
  def excludes? matcher
    !includes?(matcher)
  end

end # === module Strings
end # === module Mods
end # === class Ask
end # === module Checked
