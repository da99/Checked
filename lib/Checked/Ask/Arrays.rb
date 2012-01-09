

module Checked
  class Ask
    class Arrays

      include Ask::Base

      namespace '/array!'

      before
      def print_path
        puts request.path
      end

      route
      def symbols?
        return false if target.empty?
        answ = target.all? { |val| val.is_a? Symbol }
        
        body! answ
      end 
      
      route
      def includes? 
        body! target.include?(*args)
      end

      route
      def excludes? 
        body! !target.include?(*args)
      end
      
    end # === class Arrays


  end # === class Ask
end # === class Checked
