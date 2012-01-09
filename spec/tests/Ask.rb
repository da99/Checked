
shared 'Ask' do
  before {
    extend Checked::DSL
  }
end

describe "ask empty?" do
  
  behaves_like 'Ask'

  it "returns true if string is :empty? after applying :strip" do
    ask?(" \n ", :empty?).should.be === true
  end
  
  it "returns false if string is not :empty? after applying :strip" do
    ask?(" n ", :empty?).should.be === false
  end
  
  
end # === describe Ask Strings

describe "Ask :includes" do
  
  behaves_like 'Ask'
  
  it "returns true if string contains a Regexp matcher" do
    Checked::Ask.new(" :a ") { |a|
      a.< :includes?, / :a /
    }.true?.should.be == true
  end
  
  it "returns false if string excludes a Regexp matcher" do
    Checked::Ask.new(" :a ") { |a|
      a.< :includes?, / :b /
    }.true?.should.be == false
  end
  
end # === describe Ask :includes

describe "Ask :excludes" do
  
  behaves_like 'Ask'
  
  it "returns true if string excludes a Regexp matcher" do
    Checked::Ask.new(" :a ") { |a|
      a.< :excludes?, / :b /
    }.true?.should.be == true
  end
  
  it 'returns false if string includes a Regexp matcher' do
    Checked::Ask.new(" :a ") { |a|
      a.< :excludes?, / :a /
    }.true?.should.be == false
  end
  
end # === describe Ask :excludes

