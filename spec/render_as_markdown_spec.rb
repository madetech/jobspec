describe JobSpec::RenderAsMarkdown do
  context 'when rendering role' do
    let(:role) { JobSpec::Role.new('Engineer') }

    subject { described_class.new(role) }

    it 'should render name as h1' do
      expect(subject.render).to eq('# Engineer')
    end

    it 'should display description if it has one' do
      role.description 'A great role'
      expect(subject.render).to include('A great role')
    end

    it 'should not display description if it is nil' do
      role.description nil
      expect(subject.render).to eq('# Engineer')
    end

    it 'should not display expectations heading if no expectations' do
      expect(subject.render).not_to include('## Expectations')
    end

    it 'should display expectations heading in h2' do
      role.expected 'to be a great at TDD'
      expect(subject.render).to include('## Expectations')
    end

    it 'should display expectation as a h3' do
      role.expected 'to be a great at TDD'
      expect(subject.render).to include('### To be a great at TDD')

      role.expected 'to be very awesome'
      expect(subject.render).to include('### To be a great at TDD')
      expect(subject.render).to include('### To be very awesome')
    end

    it 'should display expectation as a h3 and description underneath' do
      role.expected 'to be a great person', 'Because its great to be great.'
      expect(subject.render).to include(
        "### To be a great person\n\nBecause its great to be great."
      )

      role.expected 'to be very awesome', 'Very awesome.'
      expect(subject.render).to include(
        "### To be a great person\n\nBecause its great to be great.\n\n### To be very awesome\n\nVery awesome."
      )
    end

    it 'should display included group as h2' do
      role.include SharedExpectationsExample, as: 'Shared Expectations'
      expect(subject.render).to include('## Shared Expectations')
    end

    it 'should display included group expectations as h3' do
      role.include SharedExpectationsExample, as: 'Shared Expectations'
      expect(subject.render).to include('### To shared these')
    end
  end
end
