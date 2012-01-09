require "Checked/version"
require 'Uni_Arch'

require "Checked/Base/DSL"
require "Checked/Base/DSL_Obj"
require "Checked/Base/Base"
require "Checked/Base/Arch"


%w{ Demand Ask Clean }.each { |klass|
  require "Checked/#{klass}/#{klass}"
  
  Dir.glob(File.join File.dirname(__FILE__), "Checked/#{klass}/*.rb").each { |path|
    
    # Require the file.
    path =~ %r!lib/Checked/(.+)/(.+)\.rb!
    require( "Checked/#{$1}/#{$2}" ) if $1 && $2
    
    # Set up routes.
    if klass != $2
      Checked::Arch.use Checked.const_get(:"#{klass}").const_get(:"#{$2}")
    end
  }
}
  

