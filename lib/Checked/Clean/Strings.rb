
class Checked
  class Clean
    class Strings < Sinatra::Base

      include Checked::Arch

      map '/string!'

      before '/:name' 
      def strip_val 
        return!( return!.strip ) if strippable_route?
      end
      
      def strippable_route?
        params['name'][%r![^\?\!]\Z!] && !%w{chop_slash_r}.include?(params['name'])
      end

      get
      def untar
        return!
        .sub(/\.tar\.gz$/, '')
        .sub(/\.tar/, '')
      end

      get
      def file_names 
        ( return!.split.select { |word| word[*args] } )
      end 

      get
      def file_names_by_ext  
        names = CHECK.string!(return!).file_names(*args)
        bases = names.map { |s|
          s.sub(%r!#{ext}$!, '')
        }

        names.zip bases
      end

      get
      def shell 
         return!
        .split("\n")
        .map(&:strip)
        .reject { |line| line.empty? }
        .join(' && ')
      end

      get
      def chop_ext
         return!.sub /\.[^\.]+$/, ''
      end

      get
      def ruby_name
        File.basename chop_rb
      end

      get
      def chop_rb
         return!.sub %r!\.rb$!, '' 
      end

      get
      def chop_slash_r
        return!.gsub "\r", ''
      end

      get
      def os_stardard
        chop_slash_r
      end

      get
      def to_single
        return!.gsub( /s\Z/, '' )
      end

      get
      def to_plural
        return!.to_single + 's'
      end

      get
      def to_class_name
        return!.split('_').map(&:capitalize).join('_')
      end

      get
      def to_camel_case
        return!.split('_').map(&:capitalize).join
      end

    end # === class Strings
  end # === class Clean
end # === class Checked
