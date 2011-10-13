

describe "require 'Checked/Ask'" do
  
  it 'must include DSL' do
    ruby_e(%! 
       require 'Checked/Ask'
       puts Checked::Ask::DSL.to_s
    !)
    .should.be == 'Checked::Ask::DSL'
  end
  
end # === describe require 'Checked/Ask'
