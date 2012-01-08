
module Checked
  
  module DSL
    
    class Obj < BasicObject
      
      attr_reader :prefix, :headers
      def initialize action, klass, unk, val = :_no_name_
        if val === :_no_name_
          name = nil
          val  = unk
        else
          name = unk
        end
      
        @prefix = "#{action}/#{klass}"
        @headers = { 'check_name' => name, 'check_target' => val }
      end
      
      def method_missing name, *args, &blok
        raise "No block allowed." if blok
        raise "Unknown options: #{args.inspect}" unless args.empty?
        
        path = '/' + [ @prefix, name ].map(&:to_s).join('/') + '/'
        app = ::Checked::Arch.new( path, headers ) 
        app.fulfill_request
        app.request.response.body
      end # === def method_missing
      
    end # === class Obj < BasicObject
    
  end # === module DSL
  
end # === module Checked
