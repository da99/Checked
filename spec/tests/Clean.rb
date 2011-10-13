

describe "require 'Checked/Clean'" do
  
  it 'must include DSL' do
    ruby_e(%! 
           require 'Checked/Clean'
           puts Checked::Clean::DSL.to_s
           !)
    .should.be == 'Checked::Clean::DSL'
  end
  
end # === describe require 'Checked/Clean'
