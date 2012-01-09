

# ============================
# ============================ ARRAYS
# ============================

describe "array! :include?" do
  
  it "returns true if array contains element." do
    BOX.array!([:a]).include?(:a)
    .should.be == true
  end
  
  it "returns false if array does not contain element" do
    BOX.array!([:a]).include?(:b)
    .should.be == false
  end
  
end # === describe Ask :includes

describe "array! :exclude?" do
  
  it "returns true if array excludes element." do
    BOX.array!([:a]).exclude?(:b)
    .should.be == true
  end
  
  it "returns false if array does contains element" do
    BOX.array!([:a]).exclude?(:a)
    .should.be == false
  end
  
end # === describe Ask :exclude

describe "array! symbols?" do
  
  it 'returns true if all elements are symbols' do
    BOX.array!([:a, :b]).symbols?
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

# describe "string! :includes?" do
#   
#   it "returns true if string contains regexp." do
#     BOX.array!(": a").includes?(/: a/)
#     .should.be == true
#   end
#   
#   it "returns false if string excludes element" do
#     Checked::Ask.new(" :a ") { |a|
#       a.< :includes?, / :b /
#     }.true?.should.be == false
#   end
#   
# end # === describe Ask :includes


# describe "ask empty?" do
#   
#   behaves_like 'Ask'
# 
#   it "returns true if string is :empty? after applying :strip" do
#     ask?(" \\n ", :empty?).should.be === true
#   end
#   
#   it "returns false if string is not :empty? after applying :strip" do
#     ask?(" n ", :empty?).should.be === false
#   end
#   
#   
# end # === describe Ask Strings
