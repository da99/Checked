class Checked
  class Bools 

    def check!
      is_bool = [TrueClass, FalseClass].include?(return!.class)
      demand is_bool, "...must be either of TrueClass or FalseClass."
    end

    def true!
      is_true = return!.class == TrueClass
      demand is_true, "...must be true (TrueClass)." 
    end

    def false!
      is_false = return!.class == FalseClass
      demand is_false, "...must be false (FalseClass)." 
    end

  end # === class Bools
end # === class Checked


