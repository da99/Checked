
class Checked
  module All

    include Checked::Arch

    def be! *args
      meth, vals = args
      answer = return!.send meth, *vals
      bool! answer
      demand answer, "...failed #{meth} with #{vals.inspect}"
    end

    def not_be! *args
      meth, vals = args
      answer = return!.send(meth, *vals)
      bool! answer
      demand !answer, "...#{meth} should not be true with #{vals.inspect}"
    end

    def empty!
      demand return!.empty?, "...must be empty."
    end

    def not_empty! *args
      if args.empty?
        demand !return!.empty?, "...can't be empty."
      else
        super
      end
    end

  end # === class All
end # === module Checked
