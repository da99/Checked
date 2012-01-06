
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
