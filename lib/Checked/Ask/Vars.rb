
class Checked
  class Vars

    def respond_to_all?
      a = not_empty_args!

      a.all? { |a|
        return!.respond_to? a
      }
    end

    def respond_to_any?
      a = not_empty_args!

      a.any? { |a|
        return!.respond_to? a
      }
    end

  end # === class Vars
end # === class Checked
