# ============================
# ============================ Ruby
# ============================

describe "array! " do
  
  behaves_like :ruby_dsl

  it 'returns the array' do
    array!([:a, :b]).should == [:a, :b]
  end
  
  it 'raises Demand::Failed if not an array' do
    lambda { array!(:a) }
    .should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :a, is not an array.!i
  end
  
end # === describe array! check!

describe "hash! " do
  
  behaves_like :ruby_dsl

  it 'returns the hash' do
    h = {:name=>:a, :val=>:b}
    hash!(h).should == h
  end
  
  it 'raises Demand::Failed if not a hash' do
    lambda { hash!(:a) }
    .should.raise(Checked::Demand::Failed)
    .message.should == "Symbol, :a, must be a hash."
  end
  
end # === describe array! check!

describe "Size!" do
  
  behaves_like :racked_dsl
  
  it 'raises ArgumentError if size of array is not within range' do
    target = [:a, :b, :c]
    r      = 1..2
    lambda { Size!(target, r) }
    .should.raise(ArgumentError)
    .message.should == "Array, #{target.inspect}, can only contain #{r.to_a.join ' or '} items."
  end
  
  it 'raises ArgumentError if size is not a Fixnum or Range' do
    lambda { Size!([], [0]) }
    .should.raise(ArgumentError)
    .message.should == "Wrong class for size: #{[0].inspect}"
  end
  
  it 'raises ArgumentError if missing size' do
    lambda { Size!([:a, :b, :c]) }
    .should.raise(ArgumentError)
  end
  
  it 'returns array' do
    t = [:a, :b]
    Size!( t, 1..2).object_id.should == t.object_id
  end
  
end # === describe Sizes_0_1!

describe "get_or_set :@var" do
  
  behaves_like :racked_dsl
  
  it 'raises ArgumentError if instance variable has not been initialized.' do
    lambda { get_or_set :@something }
    .should.raise(ArgumentError)
    .message.should.match %r!@something has not been defined!
  end
  
  it 'gets instance variable if array is empty.' do
    @server = :hi
    get_or_set( :@server ).should == @server
  end
  
end # === describe get_or_set

describe "get_or_set :@var, var" do
  
  behaves_like :racked_dsl
  
  it 'raises ArgumentError if instance variable has not been initialized.' do
    lambda { get_or_set :@someg, :hi}
    .should.raise(ArgumentError)
    .message.should.match %r!@someg has not been defined!
  end
  
  it 'sets instance variable.' do
    @server = :hi
    get_or_set( :@server, :bye)
    @server.should == :bye
  end
  
  it 'returns last value' do
    @server = :hi
    get_or_set( :@server, :bye ).should == :bye
  end
  
end # === describe get_or_set

describe "string! " do
  
  behaves_like :ruby_dsl

  it 'returns the string' do
    s = 'str'
    string!(s).should == s
  end
  
  it 'raises Demand::Failed if not a string' do
    lambda { string!(:a) }
    .should.raise(Checked::Demand::Failed)
    .message.should == "Symbol, :a, must be a string."
  end
  
end # === describe array! check!

describe "bool! " do
  
  behaves_like :ruby_dsl

  it 'returns the boolean' do
    b = false
    bool!(b).should == b
  end
  
end # === describe array! check!

describe "true! " do
  
  behaves_like :ruby_dsl

  it 'returns true' do
    true!(true).should == true
  end
  
end # === describe array! check!

describe "false! " do
  
  behaves_like :ruby_dsl

  it 'returns false' do
    false!(false).should == false
  end
  
end # === describe array! check!



# ============================
# ============================ Racked
# ============================

describe "Stripped!" do
  
  behaves_like :racked_dsl
  
  it "returns true if string is :empty? after applying :strip" do
    Stripped!(" \n ").empty?.should.be === true
  end
  
  it "returns false if string is not :empty? after applying :strip" do
    Stripped!(" n ").empty?.should.be === false
  end
  
  it 'returns string with original name' do
    Stripped!("Test String", 'test').Checked.target_name.should == 'Test String'
  end
  
end # === describe Stripped!

describe "String!" do
  
  behaves_like :racked_dsl
  
  it 'returns the string with same name' do
    s = 'str'
    String!( 'Tester', s ).Checked.target_name.should.be == 'Tester'
  end
  
  it 'raises Demand::Failed if not a string' do
    lambda {
      String!([])
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Array, \[\], must be a String!i
  end
  
end # === describe String!


describe "Array!" do
  
  behaves_like :racked_dsl
  
  it 'returns the array' do
    t = [:arr]
    Array!( t ).object_id.should.be == t.object_id
  end
  
  it 'raises Demand::Failed if not an Array' do
    lambda {
      Array!(:a)
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :a, is not an array.!i
  end
  
end # === describe Array!


describe "File_Path!" do
  
  behaves_like :racked_dsl
  
  it 'returns a stripped string' do
    File_Path!(" ~/ ").should.be == File.expand_path("~/")
  end
  
  it 'raises Demand::Failed if not a string' do
    lambda {
      File_Path!(:something)
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!Symbol, :something, must be a String!i
  end
  
end # === describe String!


describe "Bool!" do
  
  behaves_like :ruby_dsl
  
  it 'returns original value' do
    bool!(true).should.be === true
    bool!(false).should.be === false
  end
  
  it 'raises Demand::Failed if not a boolean' do
    lambda { bool!(:true) }
    .should.raise(Checked::Demand::Failed)
    .message.should == "Symbol, :true, must be either true (TrueClass) or false (FalseClass)."
  end
  
end # === describe Bool!


describe "True!" do
  
  behaves_like :ruby_dsl
  
  it 'returns original value' do
    true!(true).should.be === true
  end
  
  it 'raises Demand::Failed if not true' do
    lambda { true!(false) }
    .should.raise(Checked::Demand::Failed)
    .message.should.match %r!FalseClass, false, must be true!
  end
  
end # === describe True!


describe "False!" do
  
  behaves_like :ruby_dsl
  
  it 'returns original value' do
    false!(false).should.be === false
  end
  
  it 'raises Demand::Failed if not false' do
    lambda { false!(true) }
    .should.raise(Checked::Demand::Failed)
    .message.should.match %r!TrueClass, true, must be false!
  end
  
end # === describe False!
