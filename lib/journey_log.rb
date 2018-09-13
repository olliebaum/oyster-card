require_relative 'journey'

class JourneyLog
  attr_reader :journey, :journey_history
  def initialize(journey = Journey.new)
    @journey = journey
    @journey_history = []
  end
  def start(station)
    @journey.start(station)
  end
  def finish(station)
    @journey.end(station)
    @journey_history << @journey
    @journey = Journey.new
  end
end
