
require File.expand_path('spec/helper')
require "Bacon_Colored"
require 'Checked'


FOLDER = ("/tmp/Checked_Test")
%x! mkdir -p #{FOLDER}!
at_exit {
  %x! rm -rf #{FOLDER} !
}

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
  %x[ bundle exec ruby #{file} 2>&1].strip
  ensure
    File.delete file
  end
end


Dir.glob('spec/tests/*.rb').each { |file|
  require File.expand_path(file.sub('.rb', '')) if File.file?(file)
}
