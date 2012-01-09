
shared "Clean" do
  
  extend Checked::DSL

end # === shared 

describe "Clean :chop_ext" do
  
  behaves_like 'Clean'
  
  it "should chop off the extension of a file string: /etc/something.txt" do
    clean("/etc/something.txt", :chop_ext).should == '/etc/something'
  end
  
  it "should chop off the extension of a file string: /etc/something.rb" do
    clean("/etc/something.rb", :chop_rb).should == '/etc/something'
  end
  
  it "should not chop off a non-.rb extension for :chop_rb" do
    clean("/etc/something.rbs", :chop_rb).should == '/etc/something.rbs'
  end
  
  it "should not chop off an extension if it has not" do
    clean("/etc/something", :chop_rb).should == '/etc/something'
  end
  
  it "should not chop off an extension if it includes '.' in a dir: /etc/rc.d/x-something" do
    clean("/etc/rc.d/x-something", :chop_rb).should == '/etc/rc.d/x-something'
  end
  
end # === describe

describe "Clean :ruby_name" do
  
  behaves_like 'Clean'
  
  it 'should return the basename without .rb' do
    clean("/dir/some.path/String.rb", :ruby_name).should.be == 'String'
  end
  
  it 'should be the equivalent to :chop_rb if it is just a filename without a dir' do
    clean("String.rb", :ruby_name).should.be == 'String'
  end
  
end # === describe :ruby_name

describe "Clean :chop_slash_r" do
  
  behaves_like 'Clean'
  
  it "should remove all instances of \\r" do
    string = %@ 
      Hi\r\n
      Ok\r\n
    @
    clean(string, :chop_slash_r).should.be == string.gsub("\r", '')
  end
  
  
end # === describe :chop_slash_r


describe "Clean :os_stardard" do
  
  behaves_like 'Clean'
  
  it "should remove all \\r and strip" do
    string = %@ 
      Hi\r\n
      Ok\r\n
    @
    clean(string, :os_stardard).should.be == string.strip.gsub("\r", '')
  end
  
end # === describe

