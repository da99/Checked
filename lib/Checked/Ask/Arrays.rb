

class Checked
  
  class Arrays

    def symbols?
      return false if return!.empty?
      return!.all? { |val| val.is_a? Symbol }
    end 

    def include? 
      return!.include?(*args_hash['args'])
    end

    def exclude? 
      !return!.include?(*args_hash['args'])
    end

  end # === class Arrays

end # === class Checked
