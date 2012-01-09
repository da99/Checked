
describe "String!" do
  
  it 'returns a string' do
    BOX.String!('str').should.be == 'str'
  end
  
  it 'raises Demand::Failed if not a string' do
    lambda {
      BOX.String!([])
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Array, \[\], must be a String!
  end
  
end # === describe String!


describe "Array!" do
  
  it 'returns an array' do
    BOX.Array!([:arr]).should.be == [:arr]
  end
  
  it 'raises Demand::Failed if not an Array' do
    lambda {
      BOX.Array!(:a)
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :a, is not an Array.!
  end
  
end # === describe Array!


describe "File_Path!" do
  
  it 'returns a stripped string' do
    BOX.File_Path!(" ~/ ").should.be == File.expand_path("~/")
  end
  
  it 'raises Demand::Failed if not a string' do
    lambda {
      BOX.File_Path!(:something)
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :something, must be a String!
  end
  
end # === describe String!


describe "Bool!" do
  
  it 'returns original value' do
    BOX.Bool!(true).should.be === true
    BOX.Bool!(false).should.be === false
  end
  
  it 'raises Demand::Failed if not a boolean' do
    lambda { BOX.Bool!(:true) }
    .should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :true, must be either of TrueClass or FalseClass!
  end
  
end # === describe Bool!


describe "True!" do
  
  it 'returns original value' do
    BOX.True!(true).should.be === true
  end
  
  it 'raises Demand::Failed if not true' do
    lambda { BOX.True!(false) }
    .should.raise(Checked::Demand::Failed)
    .message.should.match %r!FalseClass, false, must be true!
  end
  
end # === describe True!


describe "False!" do
  
  it 'returns original value' do
    BOX.False!(false).should.be === false
  end
  
  it 'raises Demand::Failed if not false' do
    lambda { BOX.False!(true) }
    .should.raise(Checked::Demand::Failed)
    .message.should.match %r!TrueClass, true, must be false!
  end
  
end # === describe False!
