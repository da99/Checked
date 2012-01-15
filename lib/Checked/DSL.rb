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
    return(super) if @count > 6 
    
    raise "Unknown block." if block_given?
    begin
      result = Checked().get!(meth_name, *args)
    rescue Sin_Arch::Not_Found
      return super
    end
    @count = 1
    
    result.Checked.<< Checked()
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
      
      def << checked
        on! checked.map
        self.name = checked.name
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
        self.app ||= Checked::App.new
        app.get!("/#{map}/#{meth_name}", 'name'=>name, 'value'=>value, 'args'=>args)
      end
      
    end # === module Base
    
    include Base
    
  end # === class Obj
  
end # === class Checked

class Checked
  module DSL
  
    module Ruby

      def demand *args
        case args.size
        when 2
          bool, raw_msg = args
          msg = raw_msg.sub(%r!\A\.\.\.!, "#{target_name || return!.class}, #{return!.inspect}, ")
          fail!(msg) unless bool
          return!
        when 3
          val, bool, raw_msg = args
          if respond_to?(:return!) && return! == val
            return demand( bool, raw_msg )
          end
          msg = raw_msg.sub(%r!\A\.\.\.!, "#{val.class}, #{val.inspect}, ")
          fail!(msg) unless bool
          val
        else
          raise ArgumentError, "Too many arguments: #{args.inspect}"
        end
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
        demand val, array?(val), '...is not an array.'
        val
      end
      
      def hash! val
        demand val, hash?(val), '...must be a hash.'
        val
      end
      
      def string? val
        val.is_a?(String)
      end

      def string! val
        demand val, val.is_a?(String), '...must be a string.'
        val
      end
      
      def bool! val
        demand val, val.is_a?(TrueClass) || val.is_a?(FalseClass), '...must be either true (TrueClass) or false (FalseClass).'
        val
      end
      
      def true! val
        demand val, val === true, '...must be true (TrueClass).'
        val
      end
      
      def false! val
        demand val, val === false, '...must be false (FalseClass).'
        val
      end
      
      def not_empty! val
        demand val, !val.empty?, "...can't be empty."
        val
      end

      def keys! h, *args
        missing = args.select { |k| !h.has_key?(k) }
        unless missing.empty?
          raise Checked::Demand::Fail, "Missing keys: #{missing.inspect} in #{h}"
        end
        true
      end

    end # === module Ruby

    module Racked

      include Ruby

      def self.eval! m
        caller(1).first =~ %r!([^\:]+):(\d+):in `.!
        if $1 && $2
          eval m, nil, $1, $2.to_i - m.split("\n").size + 1
        else
          eval m, nil
        end
      end

      %w{ Array Bool File_Path Hash String Symbol Var }.each { |name|
        eval! %~
          def #{name}!( *args )
            Check!( '#{name.downcase}!', *args ).check!
          end
        ~
      }

      def Stripped! *args
        v = String!(*args)
        String!(v.strip)
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

        val.Checked.on! ns
        val.Checked.name = name
        val.Checked.get! 'check!'
        val
      end

      # ============= Ask ================

      def any? target, *args
        raise "No block allowed." if block_given?

        args.map { |a|
          send "#{klass}?", target, a
          check_it( 'ask', _main_class_(target), nil, target).send( a ).request.response.body
        }.compact == [true]
      end


      end # === module Rack_Arch
    
  end # === module DSL
  
end # === class Checked
