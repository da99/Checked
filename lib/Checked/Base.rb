
module Checked
module Base

  attr_accessor :target
  attr_reader :target_name

  def initialize var, other_val = :no_name
    if other_val == :no_name
      @target_name = begin
                       if target.respond_to?(:english_name)
                         target.english_name 
                       else
                         "#{target.class.name.gsub('_', ' ')}, #{target.inspect},"
                       end
                     end

      @original_value = var
      self.target = var
    else
      @target_name = var
      @original_value = other_val
      self.target = other_val
    end
    
    raise "No block allowed." if block_given?
  end

  #
  # ::Checked::Demand => demand
  # ::Checked::Clean  => clean
  # ::Checked::Ask    => ask
  #
  def purpose
    @purpose ||= self.class.name.split('::').last.downcase.sub(/er$/, '')
  end

  def method_missing name, *args, &blok
    to_name = lambda { |m| m.to_s.split('::').last }
    mods    = self.class.included_modules.select { |m| m.instance_methods.include?(name.to_sym) }
    all     = self.class.included_modules

    if mods.empty?
      # Raise original message with added info.
      raise NoMethodError, "#{name.inspect} not found using mods: #{all.map(&to_name).join(', ')}"
    else
      # Tell the user which module to use.
      raise NoMethodError, err_msg(
              "...can not #{purpose} #{name}, which is found in: #{mods.map(&to_name).join(', ')}"
      )
    end
  end 
  
end # === module Base
end # === module Checked
