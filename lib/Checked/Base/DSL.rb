
module Checked
  module DSL
    
    # ============ Demand ==============
    
    %w{ var array bool file_path string symbol hash }.each { |klass|
      eval %~
        def #{klass}! *args
          raise "No block allowed here." if block_given?
          check_it( 'demand', '#{klass}', *args )
        end
      
        def #{klass}? *args
          raise "No block allowed here." if block_given?
          check_it( 'ask', '#{klass}', *args )
        end
      
        def #{klass} *args
          raise "No block allowed here." if block_given?
          check_it( 'clean', '#{klass}', *args )
        end
      ~
    }
    
    alias_method :demand!, :var!
    alias_method :ask?, :var?

    # ============= Ask ================

    def check_it action, klass, *args
      args.unshift(nil) if args.size == 1
      ::Checked::DSL::Obj.new( action, klass, *args )
    end

    def _main_class_ unk
      case unk
      when String
        'string'
      when Hash
        'hash'
      when Array
        'array'
      when Symbol
        'symbol'
      when TrueClass, FalseClass
        'bool'
      else
        raise ArgumentError, "Unknown class: #{unk.inspect}"
      end
    end

    def any? target, *args
      raise "No block allowed." if block_given?
      
      args.map { |a|
        send "#{klass}?", target, a
        check_it( 'ask', _main_class_(target), nil, target).send( a ).request.response.body
      }.compact == [true]
    end

    # ============ Clean ===============
    
  end # === module DSL
end
