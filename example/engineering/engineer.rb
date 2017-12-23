JobSpec::Role.definition 'Engineer' do
  include CoreEngineerExpectations, as: 'Core Expectations'

  expected 'to be cool', 'Because it that is good'
end
