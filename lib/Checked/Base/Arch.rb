
module Checked 
  class Arch
    include ::Checked::Base

    before
    def save_key
      request.response.body= request.headers.check_target
    end

  end # === class Arch
  
end # === module Checked
