

class Checked
  
  class Arrays

    def symbols?
      return false if return!.empty?
      return!.all? { |val| val.is_a? Symbol }
    end 

    def include_all? *args
      return!.include_all?(*args)
    end

    def exclude_all? *args
      !return!.detect { |v| args.include?(v) }
    end

  end # === class Arrays

end # === class Checked
