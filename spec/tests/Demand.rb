
describe ":demand" do
  
  it 'must be equivalent to: Demand.new(target)' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand( [] ).not_empty!
    }.message.should == "Array, [], can't be empty."
    
  end
  
end # === describe :demand

describe "Named :demand" do
  
  it 'must be equivalent to: Demand.new(target) { |d| d.* name; d << args}' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand("Test Val", [:a, 'c'] )
      .symbols!
    }.message.should == "Test Val, [:a, \"c\"], contains a non-symbol."
  end
  
end # === describe Named :demand

describe "Missing method errors in demands:" do
  
  it 'must recommend method if not found in current modules' do
    lambda {
      BOX.demand('').symbols!
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


describe "demand :symbols!" do

  it 'must require Array' do
    m = should.raise(NoMethodError) {
      BOX.demand(:syn).symbols!
    }.message
    
    m.should.include "Symbol, :sym, can not demand symbols!, which is found in"
    m.should.include "in: Arrays"
  end

  it 'must require Array be non-empty.' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand( [] ).symbols!
    }.message.should.be == "Array, [], can't be empty."
  end
  
  it 'must positively validate an Array of single Symbol instance' do
    BOX.demand([:sym]).should.be == [:sym]
  end
  
end # === describe Demand for Arrays
