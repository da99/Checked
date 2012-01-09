
describe "String!" do
  
  it 'returns a string' do
    BOX.String!('str').should.be == 'str'
  end
  
  it 'raise Demand::Failed if not a string' do
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
  
  it 'raise Demand::Failed if not an Array' do
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
  
  it 'raise Demand::Failed if not a string' do
    lambda {
      BOX.File_Path!(:something)
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :something, must be a String!
  end
  
end # === describe String!
