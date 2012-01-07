
describe "DSL :demand" do
  
  it 'must be equivalent to: Demand.new(target)' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand( [] ).not_empty!
    }.message.should == "Array, [], can't be empty."
    
  end
  
end # === describe :demand

describe "demand a!" do
  
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

describe "Named :demand" do
  
  it 'must be equivalent to: Demand.new(name, target)' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand("Test Val", [] )
      .not_empty!
    }.message.should == "Test Val, [], can't be empty."
  end
  
end # === describe Named :demand


describe "demand :symbols!" do

  it 'must require Array be non-empty.' do
    should.raise(Checked::Demand::Failed) {
      BOX.array!( [] ).symbols!
    }.message.should.be == "Array, [], can't be empty."
  end
  
  it 'must positively validate an Array of single Symbol instance' do
    lambda { BOX.array!([:sym]).symbols! }.should.not.raise
  end
  
end # === describe Demand for Arrays


describe "Demand file_path!" do
  
  it 'must fail if string has control characters' do
    lambda { 
      d = Checked::Demand::File_Paths.new(File.expand_path "~/\tbashee")
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!has invalid characters: !
  end
  
end # === describe Demand file_path!


describe "Demand file_path! not_dir!" do
  
  it 'must fail for an existing dir' do
    lambda { 
      Checked::Demand::File_Paths.new(File.expand_path "~/")
      .not_dir!
    }.should.raise(Checked::Demand::Failed)
  end
  
end # === describe Demand not_dir!



describe "Demand file_path! not_file!" do
  
  it 'must fail for an existing file' do
    lambda { 
      Checked::Demand::File_Paths.new(File.expand_path "~/.bashrc")
      .not_file!
    }.should.raise(Checked::Demand::Failed)
  end
  
end # === describe Demand not_file!


describe "Demand file_path! :file_content!" do
  
  it 'must fail for an empty string' do
    lambda { 
      Checked::Demand::File_Paths.new('')
      .file_content!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == "String, \"\", can't be empty."
  end
  
end # === describe Demand :file_content!

describe "Demand file_path! :hostname!" do
  
  it 'must not contain whitespace' do
    lambda {
      Checked::Demand::File_Paths.new('some name')
      .hostname!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == 'String, "some name", has invalid characters: " "'
  end
  
end # === describe Demand :hostname!
