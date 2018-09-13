require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_history, :current_journey, :journey_class


  BALANCE_CAP = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey.new)
    @balance = 0
    @journey_history = []
    @current_journey = journey_class
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if exceed_balance_cap?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds!" if insufficient_funds?
    touch_out(Station.new('penalty station',0)) if @current_journey.in_journey?
    @current_journey.start(station)
  end

  def touch_out(exit_station)
    @current_journey.end(exit_station)
    deduct(@current_journey.fare)
    @journey_history << @current_journey
    @current_journey = Journey.new
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
