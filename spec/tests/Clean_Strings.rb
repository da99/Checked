
shared "Clean" do
  
  extend Checked::Clean::DSL

end # === shared 

describe "Clean :chop_ext" do
  
  behaves_like 'Clean'
  
  it "should chop off the extension of a file string: /etc/something.txt" do
    Clean("/etc/something.txt", :chop_ext).should == '/etc/something'
  end
  
  it "should chop off the extension of a file string: /etc/something.rb" do
    Clean("/etc/something.rb", :chop_rb).should == '/etc/something'
  end
  
  it "should not chop off a non-.rb extension for :chop_rb" do
    Clean("/etc/something.rbs", :chop_rb).should == '/etc/something.rbs'
  end
  
  it "should not chop off an extension if it has not" do
    Clean("/etc/something", :chop_rb).should == '/etc/something'
  end
  
  it "should not chop off an extension if it includes '.' in a dir: /etc/rc.d/x-something" do
    Clean("/etc/rc.d/x-something", :chop_rb).should == '/etc/rc.d/x-something'
  end
  
end # === describe

describe "Clean :ruby_name" do
  
  behaves_like 'Clean'
  
  it 'should return the basename without .rb' do
    Clean("/dir/some.path/String.rb", :ruby_name).should.be == 'String'
  end
  
  it 'should be the equivalent to :chop_rb if it is just a filename without a dir' do
    Clean("String.rb", :ruby_name).should.be == 'String'
  end
  
end # === describe :ruby_name

describe "Clean :chop_slash_r" do
  
  behaves_like 'Clean'
  
  it "should remove all instances of \\r" do
    string = %@ 
      Hi\r\n
      Ok\r\n
    @
    Clean(string, :chop_slash_r).should.be == string.gsub("\r", '')
  end
  
  
end # === describe :chop_slash_r


describe "Clean :os_stardard" do
  
  behaves_like 'Clean'
  
  it "should remove all \\r and strip" do
    string = %@ 
      Hi\r\n
      Ok\r\n
    @
    Clean(string, :os_stardard).should.be == string.strip.gsub("\r", '')
  end
  
end # === describe
