
module Checked
  
  module DSL
    
    class Obj < BasicObject
      
      attr_reader :prefix, :headers
      def initialize action, klass, name, val
        @prefix = "#{action}/#{klass}"
        @headers = { 'check_name' => name, 'check_target' => val }
        @max_missing = 4
        @miss_count = 0
      end
      
      def method_missing name, *args, &blok
        if @miss_count >= @max_missing
          ::Kernel.raise "Infinite loop: #{name}, #{args}"
        end
        
        @miss_count = @miss_count + 1
        ::Kernel.raise "No block allowed." if blok
        headers['args'] = args
        
        path = '/' + [ @prefix, name ].map(&:to_s).join('/') + '/'
        app = ::Checked::Arch.new( path, headers ) 
        app.fulfill_request
        app.request.response.body
      end # === def method_missing
      
    end # === class Obj < BasicObject
    
  end # === module DSL
  
end # === module Checked
