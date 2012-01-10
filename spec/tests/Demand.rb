# ============================
# ============================ ARRAYS
# ============================

describe "array! check!" do
  
  it 'must return array' do
    BOX.array!([:a, :b]).check!.should == [:a, :b]
  end
  
end # === describe array! check!

describe "array! :symbols!" do

  it 'must require Array be non-empty.' do
    should.raise(Checked::Demand::Failed) {
      BOX.array!( [] ).symbols!
    }.message.should.be == "Array, [], can't be empty."
  end
  
  it 'must positively validate an Array of single Symbol instance' do
    lambda { BOX.array!([:sym]).symbols! }.should.not.raise
  end
  
end # === describe Demand for Arrays

# ============================ 
# ============================ BOOLS
# ============================

describe "demand :bool!" do
  
  it 'must raise Demand::Failed if not a boolean' do
    should.raise(Checked::Demand::Failed) {
      BOX.bool!( "Answer", :false ).check!
    }.message.should.be == "Answer, :false, must be either of TrueClass or FalseClass."
  end
  
end # === describe demand :bool!

describe "demand :bool! :true!" do
  
  it 'must pass validation if true' do
    should.not.raise(Checked::Demand::Failed) {
      BOX.bool!( "Answer", 1 === 1 ).true!
    }
  end
  
  it 'must raise Demand::Failed if not true' do
    should.raise(Checked::Demand::Failed) {
      BOX.bool!( "ANSW", false ).true!
    }.message.should.be == "ANSW, false, must be true (TrueClass)."
  end
  
end # === describe demand :bool!

describe "demand :bool! :false!" do
  
  it 'must pass validation if false' do
    should.not.raise(Checked::Demand::Failed) {
      BOX.bool!( "Comparison", 1 === 2 ).false!
    }
  end
  
  it 'must raise Demand::Failed if not false' do
    should.raise(Checked::Demand::Failed) {
      BOX.bool!( "ANSW", 1 == 1 ).false!
    }.message.should.be == "ANSW, true, must be false (FalseClass)."
  end
  
end # === describe demand :bool!

# ============================
# ============================ FILE_PATHS
# ============================


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
    .message.should.match %r!, can't be an existing directory.!
  end
  
end # === describe Demand not_dir!

describe "Demand file_path! not_file!" do
  
  it 'must fail for an existing file' do
    lambda { 
      BOX.file_path!("~/.bashrc").not_file!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!bashrc., can't be a file!
  end

  it 'must return expanded path' do
    path = "~/,RANDOM"
    target = File.expand_path(path)
    BOX.file_path!(path).not_file!.should.be == target
  end
  
end # === describe Demand not_file!


# ============================
# ============================ HASHS
# ============================

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


# ============================
# ============================ STRINGS
# ============================


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

describe "Demand file_path! :hostname!" do
  
  it 'must not contain whitespace' do
    lambda {
      BOX.string!('some name').hostname!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == 'String, "some name", has invalid characters: " "'
  end
  
  it 'validates for a valid hostname' do
    lambda {
      BOX.string!('bdrm').hostname!
    }.should.not.raise(Checked::Demand::Failed)
  end
  
end # === describe Demand :hostname!

# ============================
# ============================ SYMBOLS
# ============================

describe "Demand symbol! check!" do
  
  it 'raises Demand::Failed if not Symbol' do
    lambda {
      BOX.symbol!('Name', []).check!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == "Name, [], must be a Symbol."
  end
  
end # === describe Demand symbol! check!

describe "symbol! :in! array" do
  
  it 'raises Demand::Failed if not in array' do
    lambda { BOX.symbol!(:a).in!([:b, :c]) }
    .should.raise(Checked::Demand::Failed)
    .message.should.be == "Symbol, :a, must be in array: [:b, :c]"
  end

  it 'validates if symbols is in array.' do
    lambda { BOX.symbol!(:a).in!([:a, :b, :c]) }
    .should.not.raise(Checked::Demand::Failed)
  end
  
end # === describe symbol! :in! array

# ============================
# ============================ VARS
# ============================

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

