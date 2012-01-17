
class Checked
  module All

    include Checked::Arch

    def not_empty!
      demand !return!.empty?, "...can't be empty."
    end

    def be! 
      meth, vals = args_hash['args']
      answer = return!.send meth, *vals
      bool! answer
      demand answer, "...failed #{meth} with #{vals.inspect}"
    end

    def not_be! 
      meth, vals = args_hash['args']
      answer = return!.send(meth, *vals)
      bool! answer
      demand !answer, "...#{meth} should not be true with #{vals.inspect}"
    end

    def empty!
      demand return!.empty?, "...must be empty."
    end

    def not_empty!
      demand !return!.empty?, "...can't be empty."
    end

  end # === class All
end # === module Checked
