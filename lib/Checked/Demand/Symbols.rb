
class Checked
  class Demand
    class Symbols < Sinatra::Base

      include Checked::Arch
      map '/symbol!'
      
      get
      def check!
        demand return!.is_a?(Symbol), '...must be a symbol.'
      end
      
      get 
      def in! 
        arr = args_hash['args'].first
        demand arr.include?(return!), "...must be in array: #{arr}"
      end # === def in!
      
    end # === class Symbols
  end # === class Demand
end # === class Checked
