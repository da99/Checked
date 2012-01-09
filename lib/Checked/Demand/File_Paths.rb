module Checked
  class Demand
    class File_Paths
      
      include Demand::Base

      namespace '/file_path!'
      
      before
      def validate
        fail!('...must be a String.') unless target.is_a?(String)
        
        strip_target
        not_empty!
        validate_format!
        expand_target if fs_path?
      end

      route
      def hostname!
        matches_only! %r![\dA-Za-z_-]!
      end

      route
      def not_dir!
        if File.directory?(target)
          fail! "...can't be an existing directory."
        end
      end

      route
      def not_file!
        fail! "...can't be a file." if File.file?(target)
      end

      route
      def dir!
        fail! "...must be an existing directory." unless File.directory?(target)
      end

      private 

      def validate_format!
        if target[%r!([^a-zA-Z0-9\.\_\-\/~,]+)!]
          fail! "...has invalid characters: #{$1.inspect}"
        end
      end
      
      def expand_target
        request.response.body= File.expand_path(target)
      end

      # 
      # fs_path => File system object path
      # 
      def fs_path?
        request.path[%r!(_|/)(dir|file)[^a-zA-Z]+\Z!]
      end

    end # === class File_Addresses
  end # === class Demand
end # === module Checked

