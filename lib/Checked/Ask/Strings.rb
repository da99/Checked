
module Checked
	class Ask
			class Strings

				include Ask::Base
				
				namespace '/string!'

				route
				def empty?
					body! target.strip.empty?
				end

				route
				def include? 
					body! !!target[*args]
				end

				route
				def exclude? 
					body! !target[*args]
				end

			end # === class Strings
	end # === class Ask
end # === module Checked
