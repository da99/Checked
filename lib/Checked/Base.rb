
module Checked
module Base

  attr_accessor :target
  attr_reader :target_name, :original_target

  def initialize var, other_val = :no_name
    if other_val == :no_name
      @target_name = begin
                       if var.respond_to?(:english_name)
                         var.english_name 
                       else
                         "#{var.class.name.gsub('_', ' ')}"
                       end
                     end

      @original_target = var
      self.target = var
    else
      @target_name = var
      @original_target = other_val
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
  
end # === module Base
end # === module Checked
