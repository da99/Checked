

module Checked
  class Ask
    class Arrays

      include Ask::Base

      namespace '/array!'

      route
      def symbols?
        return false if target.empty?
        answ = target.all? { |val| val.is_a? Symbol }
        
        body! answ
      end 
      
      route
      def include? 
        body! target.include?(*args)
      end

      route
      def exclude? 
        body! !target.include?(*args)
      end
      
    end # === class Arrays


  end # === class Ask
end # === class Checked
