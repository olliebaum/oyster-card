require 'oystercard'
describe Oystercard do
  let(:station) { double :station }
  let(:station2) { double :station2 }
  let(:journeymock) {double :soaisdjf }

  describe 'Initialise' do
    it 'has balance of 0 when initialised' do
      expect(subject::balance).to eq 0
    end

    it 'has no journeys recorded when initialised' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#top_up' do
    it 'increases the balance by top up amount' do
      subject.top_up(5)
      expect(subject::balance).to be 5
    end

    it 'raises error when top_up would make balance over the balance cap' do
      expect{subject.top_up(Oystercard::BALANCE_CAP + 1)}.to raise_error(
        "Top-up can't exceed card limit of £#{Oystercard::BALANCE_CAP}")
    end
  end

  describe '#touch_in' do
    context 'has enough funds for minimum fare' do
      before(:each) do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in(station)
      end
      it 'starts a journey' do
        expect(subject).to be_in_journey
      end

      it 'remembers the entry station' do
        station_name = "Aldgate East"
        allow(station).to receive(:name).and_return(station_name)
        expect(subject.current_journey.entry_station.name).to eq station_name
      end
    end

    context 'has no funds' do
      it 'raises error if balance below minimum fare' do
        expect{subject.touch_in(station)}.to raise_error("Insufficient funds!")
      end
    end

  end

  describe '#touch_out' do
    # before(:each) do
    #   @fare = Oystercard::MINIMUM_FARE
    #   subject.top_up(@fare)
    #   subject.touch_in(station)
    # end

    before do
      allow(journeymock).to receive(:fare) {3}
      allow(journeymock).to receive(:in_journey?) {false}
      allow(journeymock).to receive(:start)
      allow(journeymock).to receive(:end)
    end

    it 'resets the current_journey to a new journey class' do
      subject.touch_out(station2)
      expect(subject.current_journey).to be_an_instance_of(Journey)
    end

    subject(:hello) {described_class.new(journeymock)}
    it 'charges minimum fare' do
      # binding.pry
      hello.top_up(50)
      hello.touch_in(station)
      expect{ hello.touch_out(station2) }.to change{ hello.balance }.by(-3)
    end

    it 'checks current journey object responds to end method' do
      expect(subject.current_journey).to respond_to(:end)
    end

    it 'adds completed journey to journey history' do
      subject.touch_out(station2)
      expect(subject.journey_history).to include{subject.current_journey}
    end
  end
end
