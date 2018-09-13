require 'journey'

describe Journey do
  let(:mockStation) {double('awiuhfawor')}

  describe '#start' do
    it 'sets a start point station' do
      subject.start(mockStation)
      expect(subject.entry_station).to eq mockStation
    end
  end

  describe '#end' do
    it 'sets an end point station' do
      subject.end(mockStation)
      expect(subject.exit_station).to eq mockStation
    end
  end

  describe '#is_complete?' do
    it 'returns false if the entry_station has been set and exit_station has not' do
      subject.start(mockStation)
      expect(subject.in_journey?).to eq true
    end

    it 'return true if entry_station and exit_station are both set' do
      subject.start(mockStation)
      subject.end(mockStation)
      expect(subject.in_journey?).to eq false
    end

    it 'returns true if neither entry_station or exit_station are set' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#fare' do
    it 'returns the penalty fare of 6 when is complete is false' do
      subject.start(mockStation)
      expect(subject.fare).to eq 6
    end
    it 'returns the minimum fare of 1 when is_complete is true' do
      subject.start(mockStation)
      subject.end(mockStation)
      expect(subject.fare).to eq 1
    end
  end
end
