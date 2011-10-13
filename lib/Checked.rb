require "Checked/version"

%w{ Args Base Ask Clean Demand }.each { |klass|
  require "Checked/#{klass}"
}
  

module Checked
  module DSL
    include Ask::DSL
    include Clean::DSL
    include Demand::DSL
  end # === module DSL
end
