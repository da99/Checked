
module Checked 
  class Arch
    include ::Checked::Base

    before
    def save_key
      target = request.headers.check_target
      request.env.create :target, target
    end

    before
    def validate_type
      request.path =~ %r!\A/(demand|ask|clean)/([^/]+)/!
      if $2 && $2.downcase != 'var'
        klass = eval($2.capitalize)
        target = request.env.target
        if !target.is_a?( klass )
          raise "Target is invalid class: #{target.class} should be #{klass}"
        end
      end
    end
    
  end # === class Arch
  
end # === module Checked
