

# ============================
# ============================ ARRAYS
# ============================

describe "array! :include?" do
  
  behaves_like :racked_dsl

  it "returns true if array contains element." do
    Array!([:a]).include?(:a)
    .should.be == true
  end
  
  it "returns false if array does not contain element" do
    Array!([:a]).include?(:b)
    .should.be == false
  end
  
end # === describe Ask :includes

describe "array! :exclude?" do
  
  behaves_like :racked_dsl

  it "returns true if array excludes element." do
    Array!([:a]).exclude?(:b)
    .should.be == true
  end
  
  it "returns false if array does contains element" do
    Array!([:a]).exclude?(:a)
    .should.be == false
  end
  
end # === describe Ask :exclude

describe "array! symbols?" do
  
  behaves_like :racked_dsl

  it 'returns true if all elements are symbols' do
    Array!([:a, :b]).symbols?
    .should.be == true
  end
  
end # === describe array! symbols?
# 
# describe "Ask :excludes" do
#   
#   behaves_like 'Ask'
#   
#   it "returns true if string excludes a Regexp matcher" do
#     Checked::Ask.new(" :a ") { |a|
#       a.< :excludes?, / :b /
#     }.true?.should.be == true
#   end
#   
#   it 'returns false if string includes a Regexp matcher' do
#     Checked::Ask.new(" :a ") { |a|
#       a.< :excludes?, / :a /
#     }.true?.should.be == false
#   end
#   
# end # === describe Ask :excludes



# ============================
# ============================ STRINGS
# ============================

describe "string! :include?" do
  
  behaves_like :racked_dsl

  it "returns true if string contains regexp." do
    String!(": a").include?(/: a/)
    .should.be == true
  end
  
  it "returns false if string does not element" do
    String!(" :a ").include?(/ :b /) 
    .should.be == false
  end
  
end # === describe Ask :includes

describe "string! :exclude?" do
  
  behaves_like :racked_dsl
  
  it "returns true if string excludes regexp." do
    String!(": a").exclude?(/: b/)
    .should.be == true
  end
  
  it "returns false if string does not excludes element" do
    String!(" :a ").exclude?(/ :a /) 
    .should.be == false
  end
  
end # === describe Ask :excludes


describe "ask empty?" do
  
  behaves_like :racked_dsl
  
  it "returns true if string is :empty? after applying :strip" do
    String!(" \n ").empty?.should.be === true
  end
  
  it "returns false if string is not :empty? after applying :strip" do
    String!(" n ").empty?.should.be === false
  end
  
  
end # === describe Ask Strings

# ============================
# ============================ VARS
# ============================

describe "var! :respond_to?" do
  
  behaves_like :racked_dsl
  
  it 'returns true if it responds to methods' do
    Var!( [] ).respond_to?(:[], :to_s, :pop)
    .should == true
  end
  
  it 'returns false if it does not to at least one method' do
    Var!( [] ).respond_to?(:[], :to_s, :keys)
    .should == false
  end
  
  it 'returns false if arg list is empty' do
    Var!( [] ).respond_to?
    .should == false
  end
  
end # === describe var! :respond_to?
