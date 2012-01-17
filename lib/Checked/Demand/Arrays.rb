class Checked
  class Arrays

    def check!
      array! return!
    end

    def no_nils!
      demand \
        return!.include?(nil), \
          "...can't contain nils."
    end

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

    def symbols!
      not_empty!
      demand \
        return!.all? { |v| v.is_a?(Symbol) }, \
          "...contains a non-symbol."
    end

    def include! matcher
      demand return!.include?(matcher), \
          "...must contain: #{matcher.inspect}"
    end

    def exclude! matcher
      demand val.include?(matcher), "...can't contain #{matcher.inspect}"
    end

    def matches_only! matcher
      demand \
        return!.reject { |val| val == matcher }.empty?, \
          "...invalid elements: #{arr.inspect}"
    end


  end # === class Arrays
end # === class Checked

