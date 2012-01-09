
module Checked 
  class Arch
    include ::Checked::Base

    before
    def save_key
      request.response.body= request.headers.check_target
    end
    
    after_method
    def save_last_response
      unless request.path[%r@!/\Z@]
        request.response.body= request.response.last
      end
    end

  end # === class Arch
  
end # === module Checked
