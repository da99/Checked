
module Checked
class Demand
module Mods
module File_Addresses

  def self.apply? d
    d.target.is_a?(String)
  end

  def hostname!
    string!
    not_empty!
    contain_only! %r![\dA-Za-z_-]!
  end

  def not_dir!
    string!
    not_empty!
    if File.directory?(target)
      fail! "...can't be a directory."
    end
  end

  def not_file!
    string!
    not_empty!
    if File.file?(target)
      fail! "...can't be a file."
    end
  end

  def dir_address!
    file_address!
  end

  def file_address!
    self.target= target.strip
    string!
    not_empty!
    if target[%r!([^a-zA-Z0-9\.\_\-\/~]+)!]
      fail! "...has invalid characters: #{$1.inspect}"
    end
  end

  def file_read!
    self.target= target.gsub("\r\n", "\n")
  end

  def file_content! 
    string!
    not_empty!   
    file_read!
  end
      
end # === module File_Addresses
end # === module Mods
end # === class Demand
end # === module Checked
