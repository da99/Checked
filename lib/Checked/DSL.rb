class Object

  def Checked= val
    @sin_arch = val
    val.return! self
    val
  end
  
  def Checked
    raise "Not defined yet." unless Checked_applys?
    @sin_arch
  end

  def Checked_applys?
    instance_variable_defined?(:@sin_arch)
  end

  def method_missing meth_name, *args
    return(super) if !Checked_applys?
    
    # Keep count after :Checked_applys? call
    #   because sometimes value is frozen.
    @count ||= 1
    @count += 1
    return(super) if @count > 6 
    
    raise "Unknown block." if block_given?
    return super unless Checked().respond_to?(meth_name)
    result = Checked().send meth_name, *args
    @count = 1
    
    result.Checked= Checked() if meth_name.to_s['!']
    result
  end

end # === class Object

class Checked
  module DSL
  
    module Ruby

      def demand val, bool, raw_msg
        return val if bool

        fail! raw_msg.sub(%r!\A\.\.\.!, "#{val.class}, #{val.inspect}, ")
        val
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
            Check!( '#{name}s', *args ).check!
          end
        ~
      }

      def demand *pars
        if pars.size == 2
          val = return!
          bool, raw_msg = pars
        elsif respond_to?(:return!) && return! == pars[0] 
          val, bool, raw_msg = pars
        else
          return super
        end
        
        msg = raw_msg.sub(%r!\A\.\.\.!, "#{target_name || return!.class}, #{return!.inspect}, ")
        
        super( return!, bool, msg )
      end

      def Stripped! *args
        v = String!(*args)
        n = v.strip
        n.Checked<< v.Checked
        n
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

        val.Checked=Checked.const_get(ns.to_sym).new
        val.Checked.target_name = name
        val.Checked.return! val
        val.Checked.check!
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
