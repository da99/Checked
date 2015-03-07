
require 'Bacon_Colored'
require 'Checked'
require 'pry'

shared :ruby_dsl do
  before { extend Checked::DSL::Ruby }
end

shared :racked_dsl do
  before { extend Checked::DSL::Racked }
end


FOLDER = ("/tmp/Checked_Test")
%x! rm -r #{FOLDER} ! if File.directory?(FOLDER)
%x! mkdir -p #{FOLDER}!

require 'open3'
def ruby_e cmd
  file = "#{FOLDER}/delete_me_perf_#{rand(100000)}.rb"
  begin
    loader = File.expand_path( File.dirname(__FILE__) + '/../lib' )
    File.open(file, 'w') { |io|
      io.write %~
      $LOAD_PATH.unshift('#{loader}')
      #{cmd}
    ~
    }
  # %x[ bundle exec ruby #{file} 2>&1].strip
  
  data = ''
  Open3.popen3(" bundle exec ruby #{file}") { |i, o, e, t|
    data << o.read
    data << e.read
  }
  data.strip
  end
end

def dsl_e cmd
  ruby_e %~
    require 'Checked'
    extend Checked::DSL
    #{cmd}
  ~
end



