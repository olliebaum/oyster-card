class Journey
  attr_reader :entry_station

  def initialize(station)
    @entry_station = station
  end

  def end(station)
    @exit_station
  end

  def is_complete?
    !!exit_station
  end

  def fare
  end

end
