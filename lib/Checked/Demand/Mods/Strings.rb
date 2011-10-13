
module Checked
class Demand
module Mods
module Strings
    
  def self.before_apply d
  end

  def self.apply? d
    d.target.is_a?( String ) ||
      d.target.is_a?(StringIO)
  end
  
  def self.after_apply d
    if d.target.is_a?(StringIO)
      d.target.rewind
      d.target= d.target.readlines
      d.target.rewind
    end
  end

  def include! matcher
    included = target[matcher]
    return true if included
    fail!("...must contain: #{matcher.inspect}")
  end

  def exclude! matcher
    raise_e = val[matcher]
    return true unless raise_e
    fail!("...can't contain #{matcher.inspect}")
  end

  def matches_only! matcher
      str = target.gsub(matcher, '')
      if !str.empty?
        fail!( "...invalid characters: #{str.inspect}" ) 
      end
  end

  def not_empty!
    if target.strip.empty? 
      fail!("...can't be empty.") 
    end
  end
  
end # === module Strings
end # === module DSL
end # === class Demand
end # === module Checked
