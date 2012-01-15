require "Checked/version"
require "Checked/DSL"
require "Checked/Arch"


class Checked
  
  class Check_Args < Sinatra::Base
    
    include Checked::Arch
    
    before 
    def set_target
      keys! args_hash, 'name', 'value', 'args'
      a = args_hash['args']
      t = args_hash['value']

      demand a, array?(a), ':args must be an array.' 
      
      request.env['original_target'] = t
      
      # === target_name
      request.env['target_name'] ||= begin
                                       if t.respond_to?(:english_name)
                                         t.english_name 
                                       elsif !args_hash['name'].to_s.strip.empty?
                                         args_hash['name'].strip
                                       else
                                         t.class.name.gsub('_', ' ')
                                       end
                                     end
      
      return! t
    end
    
  end # === class Check_Args < Sinatra::Base

  use Check_Args

  class App
    include Sin_Arch::App
  end # === class App
  
end # === class Checked



%w{ Ask Clean Demand }.each { |klass|
  
  require "Checked/#{klass}/#{klass}"
  
  Dir.glob(File.join File.dirname(__FILE__), "Checked/#{klass}/*.rb").each { |path|
    next if path["/#{klass}/#{klass}.rb"]
    
    path =~ %r!lib/Checked/(.+)/(.+)\.rb!
    require( "Checked/#{$1}/#{$2}" ) 
    Checked.use eval("Checked::#{klass}::#{$2}")
  }
  
}
  

