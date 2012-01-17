require "Checked/version"
require "Checked/DSL"
require "Checked/Arch"


class Checked
  
  class App
    
    def initialize
      @target = nil
    end
  end # === class App
  
end # === class Checked



require "Checked/All"
%w{ Ask Clean Demand }.each { |klass|
  
  require "Checked/#{klass}/#{klass}"
  included = []
  
  Dir.glob(File.join File.dirname(__FILE__), "Checked/#{klass}/*.rb").each { |path|
    next if path["/#{klass}/#{klass}.rb"]
    
    path =~ %r!lib/Checked/(.+)/(.+)\.rb!
    require( "Checked/#{$1}/#{$2}" ) 
    
    unless included.include?($2)
      Checked.const_get($2.to_sym).send :include, Checked::All
      included << $2
    end
  }
  
}
  

