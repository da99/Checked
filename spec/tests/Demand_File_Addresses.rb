describe "Demand file_address!" do
  
  it 'must fail if string has control characters' do
    lambda { 
      d = Checked::Demand.new(File.expand_path "~/\tbashee")
      d.<< :file_address!
    }.should.raise(Checked::Demand::Failed)
    .message.should.match %r!has invalid characters: !
  end
  
end # === describe Demand file_address!


describe "Demand not_dir!" do
  
  it 'must fail for an existing dir' do
    lambda { 
      d = Checked::Demand.new(File.expand_path "~/")
      d.<< :not_dir!
    }.should.raise(Checked::Demand::Failed)
  end
  
end # === describe Demand not_dir!



describe "Demand not_file!" do
  
  it 'must fail for an existing file' do
    lambda { 
      d = Checked::Demand.new(File.expand_path "~/.bashrc")
      d.<< :not_file!
    }.should.raise(Checked::Demand::Failed)
  end
  
end # === describe Demand not_file!


describe "Demand :file_content!" do
  
  it 'must fail for an empty string' do
    lambda { 
      d = Checked::Demand.new('')
      d.<< :file_content!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == "String, \"\", can't be empty."
  end
  
end # === describe Demand :file_content!

describe "Demand :hostname!" do
  
  it 'must not contain whitespace' do
    lambda {
      d = Checked::Demand.new('some name')
      d.<< :hostname!
    }.should.raise(Checked::Demand::Failed)
    .message.should.be == 'String, "some name", has invalid characters: " "'
  end
  
end # === describe Demand :hostname!
