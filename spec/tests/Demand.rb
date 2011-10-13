
describe "require 'Checked/Demand'" do
  
  it 'must include DSL' do
    ruby_e(%! 
        require 'Checked/Demand'
        puts Checked::Demand::DSL.to_s
    !)
    .should.be == 'Checked::Demand::DSL'
  end
  
end # === describe require 'Checked/Demand'

describe "Demand errors" do
  
  it 'must recommend method if not found in current modules' do
    lambda {
      d = Checked::Demand.new('') 
      d.<< :symbols!
    }.should.raise(NoMethodError)
    .message.should.be === "String, \"\", can not demand symbols!, which is found in: Arrays"
  end
  
  it 'must raise a NoMethodError when a missing method is used within a valid demand! method.' do
    Missing_Meth = Module.new do
      def file_content!
        something()
      end
    end
    
    d = Checked::Demand.new('')
    d.extend Missing_Meth
    lambda { d.<< :file_content! }
    .should.raise(NoMethodError)
    .message.should.match %r!undefined method `something' for!
    
  end
  
end # === describe Demand errors
