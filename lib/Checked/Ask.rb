require 'Checked'
require 'Checked/Ask/DSL'

module Checked
  class Ask
    module Base
      
      private # ==============================
      
      include ::Checked::Base
      
      #  
      # Demand::DSL is not used here 
      # because it uses the Questioner.
      # It would cause an stack level/infinite loop 
      # error.
      #
      def valid! target, *args
        v = Demand.new(target) 
        if args.empty?
          yield v
        else
          raise "No block allowed with arguments: #{args.inspect}" if block_given?
          v << args
        end
        
        v.target
      end

      public # ==============================
      
      attr_reader :records
      
      def before_init 
        @records = []
      end

      def < name, *args, &blok
        a = super
        valid!(a, :bool!)
        records << a
        a
      end
      
      def << *methods
        valid! block_given?, :no_block!
        super(*methods) { |name|
          self.< name
        }
      end

      def true?
        return false if records.empty?
        records.all?
      end
      
      def any?
        return false if records.empty?
        records.any?
      end
      
      private # ==============================
      
      
    end # === module Base
    
    include Base
  end # === class Ask
end # === module Checked
