
class Checked
  class Symbols

    def check!
      demand return!.is_a?(Symbol), '...must be a symbol.'
    end

    def in! *raw_arrs
      arrs = raw_arrs.flatten
      demand arrs.flatten.include?(return!), "...must be in array: #{arrs}"
    end # === def in!

  end # === class Symbols
end # === class Checked
