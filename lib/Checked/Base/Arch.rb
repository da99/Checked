
module Checked 
  class Arch

    include Uni_Arch::Base

    before
    def save_key
      request.response.body= request.headers.check_target
    end
    
    before
    def run_check
      return if request.path['/var!/']
      return if request.path['/check!/']
      request.response.body= begin
                               path = request.path.split('/')[0,2].join('/') + "/check!/"
                               app  = Checked::Arch.new( path, :check_name => request.headers.check_name, :check_target => request.response.body )
                               app.fulfill_request
                               app.request.response.body
                             end
    end

    after_method
    def save_last_response
      unless request.path[%r@!/\Z@]
        request.response.body= request.response.last
      end
    end

  end # === class Arch
  
end # === module Checked
