class Object
  
  def Checked
    @sin_arch ||= begin
                    o = ::Checked::Obj.new
                    o.value = self
                    o
                  end
  end

  def Checked_applys?
    (instance_variable_defined?(:@sin_arch) && Checked().on?)
  end

  def method_missing meth_name, *args
    return(super) if !Checked_applys?
    
    # Keep count after :Checked_applys? call
    #   because sometimes value is frozen.
    @count ||= 1
    @count += 1
    return(super) if @count > 2 
    
    raise "Unknown block." if block_given?
    result = Checked().get!(meth_name, *args)
    @count = 1
    result
  end

end # === class Object

class Checked

  class Obj

    module Base
      
      attr_accessor :map, :name, :value, :app
      
      def initialize
        off!
        self.map  = nil
        self.name = nil
      end
      
      def on?
        @on
      end
      
      def on! new_map
        raise ArgumentError, "Map value unacceptable: #{new_map.inspect}" unless new_map
        self.map = new_map
        @on = true
      end
      
      def off?
        !@on
      end

      def off!
        @on = false
      end
      
      def get! meth_name, *args
        self.app = Checked::App.new
        app.get!("/#{map}/#{meth_name}", 'name'=>name, 'value'=>value, 'args'=>args)
      end
      
    end # === module Base
    
    include Base
    
  end # === class Obj
  
end # === class Checked

class Checked
  module DSL
    
    module Ruby

      def demand bool, msg
        fail!(msg) unless bool
        bool
      end

      def fail! msg
        raise Checked::Demand::Failed, msg
      end

      def respond_to_all? val, *meths
        meths.map { |m|
          val.respond_to? m
        }.uniq == [true]
      end

      def array? val
        respond_to_all?( val, :[], :pop )
      end

      def hash? val
        respond_to_all?( val, :[], :keys, :values )
      end
      
      def array! val
        demand array?(val), 'must be array.'
      end
      
      def hash! val
        demand val, 'Must be a hash.'
      end
      
      def string! val
        demand val.is_a?(String), 'Must be a string.'
      end
      
      def bool! val
        demand val.is_a?(TrueClass) || val.is_a?(FalseClass), 'Must be a boolean.'
      end
      
      def true! val
        demand val === true, 'Must be true (TrueClass).'
      end
      
      def false! val
        demand val === false, 'Must be false (FalseClass).'
      end

      def keys! h, *args
        missing = args.select { |k| !h.has_key?(k) }
        unless missing.empty?
          raise Checked::Demand::Fail, "Missing keys: #{missing.inspect} in #{h}"
        end
        true
      end
      
      def not_empty! val
        demand !val.empty?, "...can't be empty."
      end
      
      def Check! ns, *name_and_or_val
        name, val = case name_and_or_val.size
                    when 1
                      [ nil, name_and_or_val.first ]
                    when 2
                      name_and_or_val
                    else
                      raise ArgumentError, "Unknown values for name/value: #{name_and_or_val.inspect}"
                    end
        
        send ns, val if respond_to?(ns)
        val.Checked.on! ns
        val.Checked.name = name
        val
      end
      
      %w{ Array Hash String }.each { |t|
        eval %~
          def #{t}! *args
            Check! "#{t.downcase}!", *args
          end
        ~
      }

    end # === module Ruby
  
    class Obj < BasicObject
      
      attr_reader :prefix, :headers
      def initialize prefix, name, val
        @prefix      = prefix
        @headers     = { 'check_name' => name, 'check_target' => val }
        @max_missing = 4
        @miss_count  = 0
      end
      
      def method_missing name, *args, &blok
        if @miss_count >= @max_missing
          ::Kernel.raise "Infinite loop: #{name}, #{args}"
        end
        
        @miss_count = @miss_count + 1
        ::Kernel.raise "No block allowed." if blok
        headers['args'] = args
        
        path = '/' + [ @prefix, name ].map(&:to_s).join('/') + '/'
        app = ::Checked::Arch.new( path, headers ) 
        app.fulfill_request
        app.request.response.body
      end # === def method_missing
      
    end # === class Obj < BasicObject

    module Racked

      # ============ Demand ==============

      %w{ String File_Path Hash Bool }.each { |name|
        eval %~
          def #{name}!( val, *args )
            Checked.new.get!( "/#{name.downcase}!/check!", [ val ], *args )
          end
        ~
      }

      def Array! raw_name, raw_val = :_default_name_
        if raw_val === :_default_name_
          name = nil
          val  = raw_name
        else
          name = raw_name
          val  = raw_val
        end

        check = val.Checked
        check.on!
        check.name = name
        check.namespace= 'array!'
        check.get 'check!', :check_name => check.name, :check_target => val

        val
      end

      %w{ True False }.each { |bool|
        eval %~
          def #{bool}! *args
            bool!(*args).#{bool.downcase}!
          end
        ~
      }

      %w{ var array bool file_path string symbol hash }.each { |klass|
        eval %~
          def #{klass}! *args
            raise "No block allowed here." if block_given?
            check_it( '#{klass}!', *args )
          end
        
          def #{klass}? *args
            raise "No block allowed here." if block_given?
            check_it( 'ask', *args )
          end
        
          def #{klass} *args
            raise "No block allowed here." if block_given?
            check_it( 'clean',  *args )
          end
        ~
      }

      alias_method :demand!, :var!
      alias_method :ask?, :var?

      # ============= Ask ================

      def check_it namespace, *args
        args.unshift(nil) if args.size == 1
        ::Checked::DSL::Obj.new( namespace, *args )
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


      end # === module Rack_Arch
    
  end # === module DSL
end
