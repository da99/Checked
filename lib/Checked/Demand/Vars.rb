module Checked
  class Demand
    module Base

      def no_block_given!
        one_of! NilClass, FalseClass
        if target
          fail! "No block allowed."
        end
      end

      def no_block!
        no_block_given!
      end

      def either! *meths
        meths.flatten.detect { |m|
          begin
            send m
            true
          rescue Failed
            false
          end
        }
      end

      def one_of! *klasses
        return true if klasses.flatten.any? { |k| target.is_a?(k) }  
        fail! "...can only be of class/module: #{klasses.map(&:to_s).join(', ')}"
      end

      def a! klass
        one_of! klass
      end

      def nil!
        return true if target == nil
        fail!("...must be nil.")
      end

      def not_nil!
        fail!("...can't be nil.") if target.nil?
        true
      end

      def respond_to! meth
        return true if target.respond_to?(meth)
        fail!("...must respond to #{meth.inspect}")
      end

      def not_empty!
        respond_to! :empty?
        is_empty = target.empty?
        fail!("...can't be empty.") if is_empty
      end

      def exists!
        respond_to! :exists?
        return true if target.exists?
        fail!("...must exist.")
      end

      def not_exists!
        respond_to! :exists?
        return true unless target.exists?
        fail!("...must not exist.")
      end


    end # === module Base
  end # === class Demand
end # === module Checked

