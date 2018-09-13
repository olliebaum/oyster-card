require 'journey_log'

describe JourneyLog do
  let(:stationmock) { double('station')}
  let(:journeymock) { double('journeymock', start: nil, end:nil) }
  subject(:journey_log) {described_class.new(journeymock)}
  describe '#start' do
    it 'checks the journey object responds to start' do
      expect(subject.journey).to respond_to(:start)
    end
  end
  describe '#finish' do
    it 'checks the journey object responds to end' do
      expect(subject.journey).to respond_to(:end)
    end
    it 'adds a journey to the journey history array' do
      journey_log.start(stationmock)
      journey_log.finish(stationmock)
      expect(journey_log.journey_history).to eq [journeymock]
    end
    it 'leaves the journey variable as a journey instance' do
      journey_log.start(stationmock)
      journey_log.finish(stationmock)
      expect(journey_log.journey).to be_an_instance_of(Journey)
    end
    it 'checks the journey variable is a new instance' do
      journey_log.start(stationmock)
      journey_log.finish(stationmock)
      expect(journey_log.journey).to_not eq journeymock
    end
  end
  describe '#journeys' do
    it '' do

    end
  end
end
