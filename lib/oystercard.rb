class Oystercard
  attr_reader :balance, :journeys, :journey


  BALANCE_CAP = 90
  MINIMUM_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journeys = []
    @journey = journey
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if exceed_balance_cap?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds!" if insufficient_funds?
    @journey.entry_station = station
    # @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey.exit_station = exit_station
    @journeys << @journey
    @journey = nil
  end

  def in_journey?
    # !!@entry_station
    !!@journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_balance_cap?(amount)
    @balance + amount > BALANCE_CAP
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

end
