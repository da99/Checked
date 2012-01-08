require "Checked/version"
require 'Uni_Arch'

require "Checked/Base/DSL"
require "Checked/Base/DSL_Obj"
require "Checked/Base/Base"
require "Checked/Base/Arch"


%w{ Demand Ask Clean }.each { |klass|
  require "Checked/#{klass}/#{klass}"
  
  Dir.glob(File.join File.dirname(__FILE__), "Checked/#{klass}/*.rb").each { |path|
    path =~ %r!lib/Checked/(.+)/(.+)\.rb!
    require( "Checked/#{$1}/#{$2}" ) if $1 && $2
  }
}

%w{ Arrays Hashs Strings File_Paths }.each { |k|
  Checked::Arch.use Checked::Demand.const_get(:"#{k}")
}
  


