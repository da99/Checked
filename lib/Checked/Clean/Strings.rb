
class Checked
  class Strings

    def untar
      return!
      .sub(/\.tar\.gz$/, '')
      .sub(/\.tar/, '')
    end

    def file_names matcher
      ( return!.split.select { |word| word[matcher] } )
    end 

    def file_names_by_ext matcher 
      names = file_names(matcher)
      bases = names.map { |s|
        s.sub(%r!#{matcher}$!, '')
      }

      names.zip bases
    end

    def shell 
      return!
      .split("\n")
      .map(&:strip)
      .reject { |line| line.empty? }
      .join(' && ')
    end

    def chop_ext
      return!.sub /\.[^\.]+$/, ''
    end

    def ruby_name
      File.basename chop_rb
    end

    def chop_rb
      return!.sub %r!\.rb$!, '' 
    end

    def chop_slash_r
      return!.gsub "\r", ''
    end

    def os_stardard
      chop_slash_r
    end

    def to_single
      return!.gsub( /s\Z/, '' )
    end

    def to_plural
      return!.to_single + 's'
    end

    def to_class_name
      return!.split('_').map(&:capitalize).join('_')
    end

    def to_camel_case
      return!.split('_').map(&:capitalize).join
    end

  end # === class Strings
end # === class Checked
