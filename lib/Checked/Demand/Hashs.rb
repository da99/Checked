class Checked
  class Demand
    class Hashs < Sinatra::Base
      
      
      include Checked::Arch
      map '/hash!'

      get
      def check!
        demand hash?(return!), "...is not a Hash."
      end

      get
      def symbol_keys!
        all_syms = return!.keys.all? { |k| k.is_a?(Symbol) }
        demand all_syms, '...must have all symbol keys.'
      end

    end # === class Hashs
  end # === class Demand
end # === class Checked


