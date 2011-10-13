
describe "demand a! (certain class)" do
  
  before do
    @fail = Checked::Demand::Failed
    @d = lambda { |val, k|
      d = Checked::Demand.new(val)
      d.a! k
      d.target
    }
  end

  it 'must fail if invalid class' do
    should.raise(@fail) {
      @d.call('', Symbol)
    }.message.should.include 'can only be of class/module: Symbol'
  end
  
end # === describe demand a! (certain class)
