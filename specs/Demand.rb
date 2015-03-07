# ============================
# ============================ ARRAYS
# ============================

describe "Array! :symbols!" do

  behaves_like :racked_dsl

  it 'must require Array be non-empty.' do
    should.raise(Checked::Demand::Failed) {
      Array!( [] ).symbols!
    }.message.should.be == "Array, [], can't be empty."
  end
  
  it 'must positively validate an Array of single Symbol instance' do
    lambda { Array!([:sym]).symbols! }.should.not.raise
  end
  
end # === describe Demand for Arrays

# ============================ 
# ============================ BOOLS
# ============================

describe "Bool!" do

  behaves_like :racked_dsl
  
  it 'must raise Demand::Failed if not a boolean' do
    should.raise(Checked::Demand::Failed) {
      Bool!( "Answer", :false ).check!
    }.message.should.be == "Answer, :false, must be either of TrueClass or FalseClass."
  end
  
end # === describe demand :bool!

describe "Bool! :true!" do

  behaves_like :racked_dsl
  
  it 'must pass validation if true' do
    should.not.raise(Checked::Demand::Failed) {
      Bool!( "Answer", 1 === 1 ).true!
    }
  end
  
  it 'must raise Demand::Failed if not true' do
    should.raise(Checked::Demand::Failed) {
      Bool!( "ANSW", false ).true!
    }.message.should.be == "ANSW, false, must be true (TrueClass)."
  end
  
end # === describe demand :bool!

describe "demand :bool! :false!" do

  behaves_like :racked_dsl
  
  it 'must pass validation if false' do
    should.not.raise(Checked::Demand::Failed) {
      Bool!( "Comparison", 1 === 2 ).false!
    }
  end
  
  it 'must raise Demand::Failed if not false' do
    should.raise(Checked::Demand::Failed) {
      Bool!( "ANSW", 1 == 1 ).false!
    }.message.should.be == "ANSW, true, must be false (FalseClass)."
  end
  
end # === describe demand :bool!

# ============================
# ============================ FILE_PATHS
# ============================


describe "File_Path!" do

  behaves_like :racked_dsl
  
  it 'must fail if string has control characters' do
    lambda { 
      File_Path!("~/\tbashee").check!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!has invalid characters: !
  end
  
end # === describe Demand file_path!


describe "File_Path! not_dir!" do

  behaves_like :racked_dsl
  
  it 'must fail for an existing dir' do
    lambda { 
      File_Path!("~/").not_dir!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!, can't be an existing directory.!
  end
  
end # === describe Demand not_dir!

describe "File_Path! not_file!" do

  behaves_like :racked_dsl
  
  it 'fails for an existing file' do
    lambda { 
      File_Path!("~/.bashrc").not_file!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!bashrc., can't be a file!
  end

  it 'does not expand path if file does not exist' do
    path = "~/,RANDOM"
    File_Path!(path).not_file!.should.be == path
  end
  
end # === describe Demand not_file!


# ============================
# ============================ HASHS
# ============================

describe "Demand hash! :symbol_keys!" do

  behaves_like :racked_dsl
  
  it 'must raise Fail if keys are not all symbols' do
    lambda {
      Hash!( :hello=>'by', 'hi'=>'hiya' ).symbol_keys!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!must have all symbol keys!
  end
  
  it 'must not raise Fail if keys are all symbols' do
    lambda {
      Hash!( :helo=>'be', :hi=>'hi' ).symbol_keys!
    }.should.not.raise(Checked::Demand::Failed)
  end
  
  
end # === describe Demand hash! :symbol_keys!


# ============================
# ============================ STRINGS
# ============================


describe "Demand string! :file_read!" do

  behaves_like :racked_dsl
  
  it 'returns a string with right carriage returns erased.' do
    String!("test\r\ntest\r\n").file_content!.should == "test\ntest"
  end
  
end # === describe Demand string! :file_read!

describe "Demand string! :file_content!" do

  behaves_like :racked_dsl
  
  it 'must fail for an empty string' do
    lambda { 
      String!('').file_content!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == "String, \"\", can't be empty."
  end
  
end # === describe Demand :file_content!

describe "Demand file_path! :hostname!" do

  behaves_like :racked_dsl
  
  it 'must not contain whitespace' do
    lambda {
      String!('some name').hostname!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == 'String, "some name", has invalid characters: " "'
  end
  
  it 'validates for a valid hostname' do
    lambda {
      String!('bdrm').hostname!
    }.should.not.raise(Checked::Demand::Failed)
  end
  
end # === describe Demand :hostname!

# ============================
# ============================ SYMBOLS
# ============================

describe "Demand symbol! check!" do

  behaves_like :racked_dsl
  
  it 'raises Demand::Failed if not Symbol' do
    lambda {
      Symbol!('Name', []).check!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == "Name, [], must be a symbol."
  end
  
end # === describe Demand symbol! check!

describe "symbol! :in! array" do

  behaves_like :racked_dsl
  
  it 'raises Demand::Failed if not in array' do
    lambda { Symbol!(:a).in!([:b, :c]) }
    .should.raise(Checked::Demand::Failed)
    .message.should.be == "Symbol, :a, must be in array: [:b, :c]"
  end

  it 'validates if symbols is in array.' do
    lambda { Symbol!(:a).in!([:a, :b, :c]) }
    .should.not.raise(Checked::Demand::Failed)
  end
  
end # === describe symbol! :in! array

# ============================
# ============================ VARS
# ============================

describe "Named :demand!" do

  behaves_like :racked_dsl
  
  it 'must use name in errors' do
    should.raise(Checked::Demand::Failed) {
      Var!("Test Val", :a ).nil!
    }.message.should == "Test Val, :a, must be nil."
  end
  
end # === describe Named :demand

describe "DSL :demand!" do

  behaves_like :racked_dsl
  
  it 'must raise error when demand fails.' do
    should.raise(Checked::Demand::Failed) {
      Var!( [] ).nil!
    }.message.should == "Array, [], must be nil."
    
  end
  
end # === describe :demand

describe "demand be!" do

  behaves_like :racked_dsl
  
  before do
    @fail = Checked::Demand::Failed
  end

  it 'must fail if invalid class' do
    should.raise(@fail) {
      Var!([]).one_of!(Symbol)
    }.message.should.match %r!Array, \[\], can only be of class/module: Symbol!i
  end
  
end # === describe demand a! (certain class)

