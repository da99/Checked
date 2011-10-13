
describe "demand :symbols!" do
  
  before {
    @fail = Checked::Demand::Failed
    @d = lambda { |val|
      d=Checked::Demand.new(val)
      d << :symbols!
      d.target
    }
  }

  it 'must require Array' do
    m = should.raise(NoMethodError) {
      @d.call :sym
    }.message
    m.should.include "Symbol, :sym, can not demand symbols!, which is found in"
    m.should.include "in: Arrays"
  end

  it 'must require Array be non-empty.' do
    should.raise(@fail) {
      @d.call( [] )
    }.message.should.be == "Array, [], can't be empty."
  end
  
  it 'must pass for Array of single Symbol instance' do
    @d.call([:sym]).should.be == [:sym]
  end
  
end # === describe Demand for Arrays
