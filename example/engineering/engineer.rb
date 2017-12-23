JobSpec::Role.definition "Engineer" do
  include CoreEngineerExpectations

  expected "to be cool"
end
