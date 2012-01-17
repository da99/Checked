class Checked
  class File_Paths < Strings

    INVALID_CHARS = %r!([^a-zA-Z0-9\.\_\-\/~,]+)!

    def check!
      super
      string! return!

      return! return!.strip
      not_empty! return!

      validate_format!
      expand_target if File.exists?(File.expand_path return!)

      return! 
    end

    def not_dir!
      demand !File.directory?(return!), "...can't be an existing directory."
    end

    def not_file!
      demand !File.file?(return!), "...can't be a file."
    end

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
end # === class Checked

