
class Checked
  class Vars

    def respond_to_all? *args
      arr = not_empty!( args.flatten )
      
      arr.all? { |a|
        return!.respond_to? a
      }
    end

    def respond_to_any? *args
      arr = not_empty!(args)

      arr.any? { |a|
        return!.respond_to? a
      }
    end

  end # === class Vars
end # === class Checked
