class Journey
  attr_reader :entry_station, :exit_station

  # def initialize
  # end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def in_journey?
    !!entry_station && !exit_station
  end

  def fare
    in_journey? ? 6 : 1
  end

end
