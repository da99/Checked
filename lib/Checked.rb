require "Checked/version"

%w{ Args Base Ask Clean Demand }.each { |klass|
  require "Checked/#{klass}"
}
  

module Checked
  module DSL
    include ::Checked::Ask::DSL
    include ::Checked::Clean::DSL
    include ::Checked::Demand::DSL
  end # === module DSL
end
