JobSpec::Role.definition 'Engineer' do
  include CoreEngineerExpectations

  expected 'to be cool', 'Because it that is good'
end
