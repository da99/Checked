

module Checked
  class Ask
    class Arrays

      include Ask::Base

      namespace '/array!'

      route
      def symbols?
        return false if target.empty?
        target.all? { |val| val.is_a? Symbol }
      end 
      
      route
      def include? 
        target.include?(*args)
      end

      route
      def exclude? 
        !target.include?(*args)
      end
      
    end # === class Arrays


  end # === class Ask
end # === class Checked
