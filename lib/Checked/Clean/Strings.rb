
module Checked
  class Clean
    class Strings

      include Clean::Base

      namespace '/string!'

      before_these_methods
      def strip_string
         target.strip
      end

      route
      def untar
        target
        .sub(/\.tar\.gz$/, '')
        .sub(/\.tar/, '')
      end

      route
      def file_names 
        ( target.strip.split.select { |word| word[*args] } )
      end 

      route
      def file_names_by_ext  
        names = CHECK.string!(target).file_names(*args)
        bases = names.map { |s|
          s.sub(%r!#{ext}$!, '')
        }

        names.zip bases
      end

      route
      def shell 
         target
        .strip
        .split("\n")
        .map(&:strip)
        .reject { |line| line.empty? }
        .join(' && ')
      end

      route
      def chop_ext
         target.sub /\.[^\.]+$/, ''
      end

      route
      def ruby_name
         CHECK.string!( File.basename( target ) ).chop_rb
      end

      route
      def chop_rb
         target.sub %r!\.rb$!, '' 
      end

      route
      def chop_slash_r
        target.gsub "\r", ''
      end

      route
      def os_stardard
        CHECK.string!(target).chop_slash_r.strip
      end

      route
      def to_single
        target.gsub( /s\Z/, '' )
      end

      route
      def to_plural
        target.to_single + 's'
      end

      route
      def to_class_name
        target.split('_').map(&:capitalize).join('_')
      end

      route
      def to_camel_case
        target.split('_').map(&:capitalize).join
      end

    end # === class Strings
  end # === class Clean
end # === module Checked
