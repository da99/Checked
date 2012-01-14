class Checked
  class Demand
    class Vars < Sinatra::Base
      
      include Checked::Arch
      
      map '/:type!'
      
      get 
      def not_empty!
        demand !return!.empty?, "...can't be empty."
      end

      get 
      def be! meth, *args
        answer = return!.send meth, *args
        demand answer, :bool!
        return true if answer
        fail!("...failed #{meth} with #{args.inspect}")
      end

      get
      def not_empty!
        demand !return!.empty?, "...can't be empty."
      end

      get
      def not_be! meth, *args
        bool!
        pass = return!.send(meth, *args)
        demand pass, :bool!
        return true unless pass
        fail!("...#{meth} should not be true with #{args.inspect}")
      end


      map '/var!' # ===============================

      get
      def either! 
        request.headers.args.flatten.detect { |m|
          begin
            return!.send m
            true
          rescue Failed
            false
          end
        }
      end

      get
      def be!
        rejected = request.headers.args.flatten.select { |m|
          !(return!.send m)
        }
        fail!("...must be: #{rejected.map(&:to_s).join(', ')}") unless rejected.empty?
      end
      
      get
      def not_be!
        rejected = request.headers.args.flatten.select { |m|
          !!(return!.send m)
        }
        fail!("...must not be: #{rejected.map(&:to_s).join(', ')}") unless rejected.empty?
      end

      get
      def one_of! 
        klasses = request.headers.args
        return true if klasses.flatten.any? { |k| return!.is_a?(k) }  
        fail! "...can only be of class/module: #{klasses.map(&:to_s).join(', ')}"
      end

      get
      def nil!
        fail!("...must be nil.") unless return!.nil?
      end

      get
      def not_nil!
        fail!("...can't be nil.") if return!.nil?
      end

      get
      def respond_to! 
        rejected = request.headers.args.reject { |m|
          !return!.respond_to?(m)
        }
        fail!("...must respond to #{rejected.inspect}") unless rejected.empty?
      end

    end # === class Vars
  end # === class Demand
end # === module Checked

