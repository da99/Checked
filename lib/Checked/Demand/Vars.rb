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
      def be! 
        meth, vals = args_hash['args']
        answer = return!.send meth, *vals
        bool! answer
        demand answer, "...failed #{meth} with #{vals.inspect}"
      end

      get
      def not_be! 
        meth, vals = args_hash['args']
        answer = return!.send(meth, *vals)
        bool! answer
        demand !answer, "...#{meth} should not be true with #{vals.inspect}"
      end

      get
      def empty!
        demand return!.empty?, "...must be empty."
      end

      get
      def not_empty!
        demand !return!.empty?, "...can't be empty."
      end

      map '/var!' # ===============================
      
      get
      def check!
        return!
      end

      get
      def either! 
        answer = args_hash['args'].flatten.detect { |m|
          begin
            return!.send m
            true
          rescue Failed
            false
          end
        }
        demand answer, "...is not any: #{args_hash['args'].inspect}"
      end

      get
      def be!
        rejected = args_hash['args'].flatten.select { |m|
          !(return!.send m)
        }
        demand rejected.empty?, "...must be all of these: #{rejected.map(&:to_s).join(', ')}"
      end
      
      get
      def not_be!
        rejected = args_hash['args'].flatten.select { |m|
          !!(return!.send m)
        }
        demand rejected.empty?, "...must not be: #{rejected.map(&:to_s).join(', ')}"
      end

      get
      def one_of! 
        klasses = args_hash['args']
        demand \
          klasses.flatten.any? { |k| return!.is_a?(k) }, \
          "...can only be of class/module: #{klasses.map(&:to_s).join(', ')}"
      end

      get
      def nil!
        demand return!.nil?, "...must be nil."
      end

      get
      def not_nil!
        demand !return!.nil?, "...can't be nil." 
      end

      get
      def respond_to! 
        rejected = args_hash['args'].reject { |m|
          !return!.respond_to?(m)
        }
        demand rejected.empty?, "...must respond to #{rejected.inspect}"
      end

    end # === class Vars
  end # === class Demand
end # === module Checked

