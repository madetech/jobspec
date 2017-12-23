
describe JobSpec::Role do
  context 'when defining role' do
    subject { described_class.new('Engineer') }

    it 'should have a name' do
      expect(subject.name).to eq('Engineer')
    end

    it 'should allow you to set a description' do
      subject.description 'Our Engineers are the core of our business.'
      expect(subject.description).to eq('Our Engineers are the core of our business.')
    end

    it 'should allow you to set salary range' do
      subject.salary 30_000..45_000
      expect(subject.salary).to eq(30_000..45_000)
    end

    it 'should allow you to set expectations' do
      subject.expected 'to be cool'
      expect(subject.expectations).to include(
        a_hash_including(
          expectation: 'to be cool'
        )
      )
    end

    it 'should allow you to set expectations with a description' do
      subject.expected 'To be cool',
                       'A description of the expectation.'
      expect(subject.expectations).to include(
        a_hash_including(
          expectation: 'To be cool',
          description: 'A description of the expectation.'
        )
      )
    end

    it 'should allow you to include shared expectations' do
      subject.include SharedExpectationsExample
      expect(subject.expectations).to include(
        a_hash_including(
          expectation: 'to shared these',
          description: 'Nice.'
        )
      )
    end
  end

  context 'when collecting definitions' do
    before do
      described_class.definition 'Engineer' do
        expected 'to be cool'
      end
    end

    it 'should add role to definitions list' do
      expect(described_class.definitions.first.expectations).to include(
        a_hash_including(
          expectation: 'to be cool'
        )
      )
    end
  end
end
