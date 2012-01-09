module Checked
  class Demand
    class Vars
      
      include Demand::Base
      
      namespace '/demand/var/'

      route
      def either! 
        request.headers.args.flatten.detect { |m|
          begin
            target.send m
            true
          rescue Failed
            false
          end
        }
      end

      route
      def be!
        rejected = request.headers.args.flatten.select { |m|
          !(target.send m)
        }
        fail!("...must be: #{rejected.map(&:to_s).join(', ')}") unless rejected.empty?
      end
      
      route
      def not_be!
        rejected = request.headers.args.flatten.select { |m|
          !!(target.send m)
        }
        fail!("...must not be: #{rejected.map(&:to_s).join(', ')}") unless rejected.empty?
      end

      route
      def one_of! 
        klasses = request.headers.args
        return true if klasses.flatten.any? { |k| target.is_a?(k) }  
        fail! "...can only be of class/module: #{klasses.map(&:to_s).join(', ')}"
      end

      route
      def nil!
        fail!("...must be nil.") unless target.nil?
      end

      route
      def not_nil!
        fail!("...can't be nil.") if target.nil?
      end

      route
      def respond_to! 
        rejected = request.headers.args.reject { |m|
          !target.respond_to?(m)
        }
        fail!("...must respond to #{rejected.inspect}") unless rejected.empty?
      end

    end # === class Vars
  end # === class Demand
end # === module Checked

