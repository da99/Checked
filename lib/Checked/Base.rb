
module Checked
module Base
  
  def self.included var
    klass_name = var.to_s.gsub(/::Base$/, '').split('::').last
    klass = Checked.const_get(klass_name)
    
    files = Dir.glob(File.join File.dirname(__FILE__), "#{klass_name}/Mods/*.rb")
    raise "No Mods found for #{klass}" if files.empty?
    
    files.each { |path|
      name = File.basename(path).sub('.rb', '')
      require "Checked/#{klass_name}/Mods/#{name}"
      if name == 'Vars'
        klass.class_eval {
          include klass::Mods::Vars
        }
      else
        klass.const_set(:Mod_List, []) unless klass.const_defined?(:Mod_List)
        klass::Mod_List << klass::Mods.const_get(name)
      end
    }
  end

  attr_accessor :target
  attr_reader :target_name
  
  def initialize target, &blok
    
    if respond_to? :before_init
      if method(:before_init).parameters === []
        before_init
      else
        before_init target, &blok
      end
    end
    
    @target = target
    @target_name = target.respond_to?(:english_name) ?
      target.english_name : 
      "#{target.class.name.gsub('_', ' ')}, #{target.inspect},"
    
    self.class.const_get(:Mod_List).each { |mod|
      if mod.apply?(self)
        extend mod
      end
    }
    
    if respond_to? :after_init
      if method(:after_init).parameters === []
        after_init
      else
        after_init target, &blok
      end
    end

    yield(self) if block_given?
  end

  # 
  # Sets the name.
  #   
  def * name
    @target_name = "#{name}, #{target.inspect},"
    self
  end
  
  #
  # ::Checked::Demand => demand
  # ::Checked::Clean  => clean
  # ::Checked::Ask    => ask
  #
  def purpose
    @purpose ||= self.class.name.split('::').last.downcase.sub(/er$/, '')
  end

  def < name, *args, &blok
    send(name, *args, &blok)
  end

  def << *methods
    meths = begin
              ::Checked::Demand.new(methods.flatten) { |d|
                d.* "(Originally: #{target_name})"
                d.instance_eval { not_empty!; symbols! }
              }.target
            end


    meths.each { |name|
      
      begin
        if block_given?
          yield name
        else
          send name
        end
      rescue NoMethodError => e
        raise e if !e.message[/undefined method `#{name.to_s}' for/]
        to_name = lambda { |m| m.to_s.split('::').last }
        mods = self.class::Mod_List.select { |m| m.instance_methods.include?(name.to_sym) }
        all  = self.class::Mod_List
        
        if mods.empty?
          e_msg = e.message
          raise NoMethodError, "#{e_msg} using mods: #{all.map(&to_name).join(', ')}"
        else
          raise NoMethodError, err_msg(
              "...can not #{purpose} #{name}, which is found in: #{mods.map(&to_name).join(', ')}"
          )
        end
      end
    }
    self
  end 
  
end # === module Base
end # === module Checked
