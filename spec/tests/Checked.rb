
describe "Checked::DSL" do
  
  %w{ Ask Demand Clean }.each { |name|
    klass = Checked.const_get(name)
    
    it "includes #{name}::DSL" do
      Checked::DSL.included_modules.should.include klass::DSL
    end
    
  }
  
end # === describe


describe "Checked.demand!" do
  
  before {
    @perf = Class.new { include Checked::DSL }.new
  }
  
  it 'must be equivalent to: Demand.new(target)' do
    should.raise(Checked::Demand::Failed) {
      @perf.demand! [], :not_empty!
    }.message.should == "Array, [], can't be empty."
    
  end
  
end # === describe Checked.demand!

describe "Checked.named_demand!" do
  
  before {
    @perf = Class.new { include Checked::DSL }.new
  }
  
  it 'must be equivalent to: Demand.new(target) { |d| d.* name; d << args}' do
    should.raise(Checked::Demand::Failed) {
      @perf.named_demand! "Test Val", [:a, 'c'], :symbols!
    }.message.should == "Test Val, [:a, \"c\"], contains a non-symbol."
  end
  
end # === describe Checked.named_demand!
