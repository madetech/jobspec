
describe JobSpec::Role do
  context 'when defining role' do
    subject { described_class.new('Engineer') }

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
      expect(subject.to_a).to include('to be cool')
    end

    it 'should allow you to include shared expectations' do
      subject.include SharedExpectationsExample
      expect(subject.to_a).to include('to shared these')
    end
  end

  context 'when collecting definitions' do
    before do
      described_class.definition 'Engineer' do
        expected 'to be cool'
      end
    end

    it 'should add role to definitions list' do
      expect(described_class.definitions.first.to_a).to include('to be cool')
    end
  end
end
