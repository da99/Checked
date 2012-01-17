
class Checked
  class Strings

    def check!
      case return!
      when String

        return!
      when StringIO
        target.rewind
        return! target.readlines
        target.rewind

        return!
      else
        demand false, "...must be a String or StringIO."
      end
    end

    def include!
      demand return![matcher], "...must contain: #{matcher.inspect}"
    end

    def exclude! matcher
      demand !(return![matcher]), "...can't contain #{matcher.inspect}"
    end

    def matches_only!
      invalid = return!.gsub(matcher, '')
      demand invalid.empty?, "...has invalid characters: #{str.inspect}" 
    end

    def not_empty!
      demand !(return!.strip.empty?), "...can't be empty."
    end

    def file_read!
      return!.gsub("\r\n", "\n")
    end

    def new_content!
      not_empty!   
      file_read!
    end

    def file_content! 
      new_content!
    end

    def hostname!
      invalid = return![ %r!([^\dA-Za-z_-]+)! ]
      demand !invalid, "...has invalid characters: #{$1.inspect}"
    end

  end # === class String
end # === class Checked

