class Checked
  class Demand
    class Arrays < Sinatra::Base

      include Checked::Arch
      map '/array!'
      
      get
      def check!
        demand \
          array?(return!), \
          "...is not an Array."
      end

      get
      def no_nils!
        demand \
          return!.include?(nil), \
          "...can't contain nils."
      end

      get
      def no_empty_strings!
        return!.each { |memo,s| 

          final = if s.respond_to?(:readlines)
                    s.rewind
                    s.readlines
                  else
                    s
                  end

          demand \
            final.is_a?(::String), \
            "...can't contain unknown class: #{final.inspect}"
            
          demand \
            final.is_a?(::String) && final.strip.empty?, \
            "...can't contain empty strings."
            
        }
        return!
      end

      get
      def symbols!
        Checked::App.new.get!("/array!/not_empty!", 'name'=>target_name, 'value'=>return!, 'args'=>[])
        demand \
          return!.all? { |v| v.is_a?(Symbol) }, \
          "...contains a non-symbol."
      end

      get
      def include! 
        demand return!.include?(matcher), \
          "...must contain: #{matcher.inspect}"
      end

      get
      def exclude! 
        demand val.include?(matcher), "...can't contain #{matcher.inspect}"
      end

      get
      def matches_only! 
        demand \
          return!.reject { |val| val == matcher }.empty?, \
          "...invalid elements: #{arr.inspect}"
      end
      

    end # === class Arrays
  end # === class Demand
end # === class Checked

