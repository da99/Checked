require "Checked/version"
require "Checked/DSL"
require "Checked/Arch"

require "Checked/Demand/Demand"


class Checked
  class Check_Args < Sinatra::Base
    
    include Checked::Arch
    
    before 
    def set_target
      keys! args_hash, 'target_name', 'target'
      request.env['original_target'] = args_hash['target']
      
      target = args_hash['target']
      # === target_name
      request.env['target_name'] ||= begin
                                       if target.respond_to?(:english_name)
                                         target.english_name 
                                       else
                                         target.class.name.gsub('_', ' ')
                                       end
                                     end
      
      return! args_hash['target']
    end
    
  end # === class Check_Args < Sinatra::Base

  use Check_Args

  class App
    include Sin_Arch::App
    
    def get! path, *args
      case args.size
      when 1
        name = nil
        val  = args.shift
      when 2
        name = args.shift
        val  = args.shift
      else
        raise ArgumentError, "Unknown arguments: #{args[2, args.size - 2]}"
      end
      super( path, 'target_name' => name, 'target' => val )
    end
  end # === class App
  
end # === class Checked

%w{ Arrays Vars }.each { |c|
  require "Checked/Demand/#{c}"
  Checked.use Checked::Demand.const_get(c.to_sym)
}

puts "\n"
at_exit { puts "\n\n" }
# class Box
#   include Checked::DSL
# end
# BOX = Box.new

app = Checked::App.new
puts "Returned: " + app.get!("/array!/not_empty!", 'Six', [6]).to_s
puts 'body: ' + app.last_response.body.inspect

begin
  app.get!("/array!/symbols!", 'strings', %w{ 6 })
rescue Checked::Demand::Failed
puts "Array containted strings: #{app.last_request.env['sin_arch.return']}"
end

# puts BOX.Array!( [5] ).inspect

# %w{ Demand Ask Clean }.each { |klass|
#   require "Checked/#{klass}/#{klass}"
#   
#   Dir.glob(File.join File.dirname(__FILE__), "Checked/#{klass}/*.rb").each { |path|
#     
#     # Require the file.
#     path =~ %r!lib/Checked/(.+)/(.+)\\\\\\\\.rb!
#     require( "Checked/#{$1}/#{$2}" ) if $1 && $2
#     
#     # Set up routes.
#     if klass != $2
#       Checked::Arch.use Checked.const_get(:"#{klass}").const_get(:"#{$2}")
#     end
#   }
# }
#   
# 
