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

    it 'should display expectation as a h2' do
      role.expected 'to be a great person'
      expect(subject.render).to include('## To be a great person')

      role.expected 'to be very awesome'
      expect(subject.render).to include('## To be a great person')
      expect(subject.render).to include('## To be very awesome')
    end

    it 'should display expectation as a h2 and description underneath' do
      role.expected 'to be a great person', 'Because its great to be great.'
      expect(subject.render).to include(
        "## To be a great person\n\nBecause its great to be great."
      )

      role.expected 'to be very awesome', 'Very awesome.'
      expect(subject.render).to include(
        "## To be a great person\n\nBecause its great to be great.\n\n## To be very awesome\n\nVery awesome."
      )
    end
  end
end
