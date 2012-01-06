
module Checked
  class Clean
    module Mods
      module Strings

        def self.apply? d
          d.target.is_a?(String) ||
            d.target.is_a?(StringIO)
        end

        def self.on_apply d
          case d.target
          when StringIO
            d.target.rewind
            d.target= d.target.readlines
          else
            # Do nothing.
          end
        end

        def untar
          target
          .sub(/\.tar\.gz$/, '')
          .sub(/\.tar/, '')
        end

        def file_names matcher
          target.strip.split.select { |word| word[matcher] }
        end 

        def file_names_by_ext ext
          names = file_names(ext)
          bases = names.map { |s|
            s.sub(%r!#{ext}$!, '')
          }

          names.zip bases 
        end

        def shell 
          target
          .strip
          .split("\n")
          .map(&:strip)
          .reject { |line| line.empty? }
          .join(' && ')
        end

        def chop_ext
          target.sub /\.[^\.]+$/, ''
        end

        def ruby_name
          c = ::Checked::Clean.new( File.basename( target ) ) 
          c.< :chop_rb
          c.target
        end

        def chop_rb
          target.sub %r!\.rb$!, ''
        end

        def chop_slash_r
          target.gsub "\r", ''
        end

        def os_stardard
          chop_slash_r.strip
        end

        def file_names matcher
          strip.split.select { |word| word[matcher] }
        end

        def file_names_by_ext  ext
          names = file_names(ext)
          bases = names.map { |s|
            s.sub(%r!#{ext}$!, '')
          }

          names.zip bases
        end

        def to_single
          target.gsub( /s\Z/, '' )
        end

        def to_plural
          target.to_single + 's'
        end

        def to_class_name
          target.split('_').map(&:capitalize).join('_')
        end

        def to_camel_case
          target.split('_').map(&:capitalize).join
        end

      end # === module Strings
    end # === module Mods
  end # === class Clean
end # === module Checked
