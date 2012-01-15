

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


# ============================
# ============================ VARS
# ============================

describe "Var! :respond_to_all?" do
  
  behaves_like :racked_dsl
  
  it 'returns true if it responds to methods' do
    Var!( [] ).respond_to_all?(:[], :to_s, :pop)
    .should == true
  end
  
  it 'returns false if it does not to at least one method' do
    Var!( [] ).respond_to_all?(:[], :to_s, :keys)
    .should == false
  end
  
  it 'returns false if arg list is empty' do
    Var!( [] ).respond_to_all?
    .should == false
  end
  
end # === describe var! :respond_to?


describe "Var! :respond_to_any?" do
  
  behaves_like :racked_dsl
  
  it 'returns true if it responds to any methods' do
    Var!( [] ).respond_to_any?(:[], :jetsons, :jump_it)
    .should == true
  end
  
  it 'returns false if it does not respond to all methods' do
    Var!( [] ).respond_to_any?(:jetson, :to_flintstones, :thundar)
    .should == false
  end
  
  it 'returns false if arg list is empty' do
    Var!( [] ).respond_to_any?
    .should == false
  end
  
end # === describe var! :respond_to?
