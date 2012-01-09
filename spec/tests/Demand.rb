
describe "Named :demand!" do
  
  it 'must use name in errors' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand!("Test Val", :a ).nil!
    }.message.should == "Test Val, :a, must be nil."
  end
  
end # === describe Named :demand

describe "DSL :demand!" do
  
  it 'must raise error when demand fails.' do
    should.raise(Checked::Demand::Failed) {
      BOX.demand!( [] ).nil!
    }.message.should == "Array, [], must be nil."
    
  end
  
end # === describe :demand

describe "demand be!" do
  
  before do
    @fail = Checked::Demand::Failed
  end

  it 'must fail if invalid class' do
    should.raise(@fail) {
      BOX.demand!([]).one_of!(Symbol)
    }.message.should == "Array, [], can only be of class/module: Symbol"
  end
  
end # === describe demand a! (certain class)


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
      BOX.file_path!("~/\tbashee").check!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!has invalid characters: !
  end
  
end # === describe Demand file_path!


describe "Demand file_path! not_dir!" do
  
  it 'must fail for an existing dir' do
    lambda { 
      BOX.file_path!("~/").not_dir!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!~/", can't be an existing directory.!
  end
  
end # === describe Demand not_dir!



describe "Demand string! :file_read!" do
  
  it 'returns a string with right carriage returns erased.' do
    BOX.string!("test\r\ntest\r\n").file_content!.should == "test\ntest\n"
  end
  
end # === describe Demand string! :file_read!

describe "Demand string! :file_content!" do
  
  it 'must fail for an empty string' do
    lambda { 
      BOX.string!('').file_content!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == "String, \"\", can't be empty."
  end
  
end # === describe Demand :file_content!

describe "Demand file_path! not_file!" do
  
  it 'must fail for an existing file' do
    lambda { 
      BOX.file_path!("~/.bashrc").not_file!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!bashrc", can't be a file!
  end

  it 'must return expand path' do
    path = "~/,RANDOM"
    target = File.expand_path(path)
    BOX.file_path!(path).not_file!.should.be == target
  end
  
end # === describe Demand not_file!

describe "Demand file_path! :hostname!" do
  
  it 'must not contain whitespace' do
    lambda {
      BOX.file_path!('some name').hostname!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == 'String, "some name", has invalid characters: " "'
  end
  
end # === describe Demand :hostname!

describe "Demand hash! :symbol_keys!" do
  
  it 'must raise Fail if keys are not all symbols' do
    lambda {
      BOX.hash!( :hello=>'by', 'hi'=>'hiya' ).symbol_keys!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!must have all symbol keys!
  end
  
  it 'must not raise Fail if keys are all symbols' do
    lambda {
      BOX.hash!( :helo=>'be', :hi=>'hi' ).symbol_keys!
    }.should.not.raise(Checked::Demand::Failed)
  end
  
  
end # === describe Demand hash! :symbol_keys!
