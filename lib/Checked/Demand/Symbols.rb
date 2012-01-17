
class Checked
  class Symbols

    def check!
      demand return!.is_a?(Symbol), '...must be a symbol.'
    end

    def in! 
      arr = args_hash['args'].first
      demand arr.include?(return!), "...must be in array: #{arr}"
    end # === def in!

  end # === class Symbols
end # === class Checked
