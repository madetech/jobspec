describe JobSpec::AdhocExpectations do
  before do
    described_class.clear!
  end

  it 'can combine one expectation into two roles (example 1)' do
    described_class.define 'to be awesome!' do
      description 'awesomeness'
      roles 'Engineer', 'Senior Engineer'
    end

    expect(described_class.roles).to(
      eq(
        [
          {
            name: 'Engineer',
            expectations: [
              {
                expectation: 'to be awesome!',
                description: 'awesomeness'
              }
            ]
          },
          {
            name: 'Senior Engineer',
            expectations: [
              {
                expectation: 'to be awesome!',
                description: 'awesomeness'
              }
            ]
          }
        ]
      )
    )
  end

  it 'can combine one expectation into two roles (example 2)' do
    described_class.define 'to be cool!' do
      description 'coolness'
      roles 'Reliability Engineer', 'Senior Reliability Engineer'
    end

    expect(described_class.roles).to(
      eq(
        [
          {
            name: 'Reliability Engineer',
            expectations: [
              {
                expectation: 'to be cool!',
                description: 'coolness'
              }
            ]
          },
          {
            name: 'Senior Reliability Engineer',
            expectations: [
              {
                expectation: 'to be cool!',
                description: 'coolness'
              }
            ]
          }
        ]
      )
    )
  end

  it 'can combine two expectations into 4 roles' do
    described_class.define 'to be cool!' do
      description 'coolness'
      roles 'Reliability Engineer', 'Senior Reliability Engineer', 'Engineer'
    end

    described_class.define 'to be really awesome!' do
      description 'really awesome'
      roles 'Engineer'
    end

    expect(described_class.roles).to(
      eq(
        [
          {
            name: 'Reliability Engineer',
            expectations: [
              {
                expectation: 'to be cool!',
                description: 'coolness'
              }
            ]
          },
          {
            name: 'Senior Reliability Engineer',
            expectations: [
              {
                expectation: 'to be cool!',
                description: 'coolness'
              }
            ]
          },
          {
            name: 'Engineer',
            expectations: [
              {
                expectation: 'to be cool!',
                description: 'coolness'
              },
              {
                expectation: 'to be really awesome!',
                description: 'really awesome'
              }
            ]
          }
        ]
      )
    )
  end
end
