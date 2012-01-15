

class Checked
  class Ask
    class Arrays < Sinatra::Base

      include Checked::Arch

      map '/array!'

      get
      def symbols?
        return false if return!.empty?
        return!.all? { |val| val.is_a? Symbol }
      end 
      
      get
      def include? 
        return!.include?(*args_hash['args'])
      end

      get
      def exclude? 
        !return!.include?(*args_hash['args'])
      end
      
    end # === class Arrays


  end # === class Ask
end # === class Checked
