
module Checked
class Demand
module Mods
module Symbols

  def self.before_apply d
  end

  def self.apply? d
    d.target.is_a? Symbol
  end
  
  def self.after_apply d
  end

end # === module Symbols
end # === class DEMANDS
end # === class Demand
end # === module Checked
