class Checked
  class Demand
    class File_Paths < Sinatra::Base
      
      INVALID_CHARS = %r!([^a-zA-Z0-9\.\_\-\/~,]+)!
      include Checked::Arch
      map '/file_path!'
      
      get
      def check!
        string! return!
        
        return! return!.strip
        demand !return!, !return!.empty?, '...is_empty.'
        
        validate_format!
        expand_target if File.exists?(File.expand_path return!)
        
        return! 
      end

      get
      def not_dir!
        demand !File.directory?(return!), "...can't be an existing directory."
      end

      get
      def not_file!
        demand !File.file?(return!), "...can't be a file."
      end

      get
      def dir!
        demand File.directory?(return!), "...must be an existing directory." 
      end

      private 

      def validate_format!
        demand !( return![INVALID_CHARS] ), "...has invalid characters: #{$1.inspect}"
      end
      
      def expand_target
        return! File.expand_path(return!)
      end

      # 
      # fs_path => File system object path
      # 
      def fs_path?
        request.path[%r!(_|/)(dir|file|check)[^a-zA-Z]+\Z!]
      end

    end # === class File_Addresses
  end # === class Demand
end # === class Checked

