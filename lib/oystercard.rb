class Oystercard
  attr_reader :balance

  BALANCE_CAP = 90
  MINIMUM_FARE = 1
  
  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if exceed_balance_cap?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficient funds!" if insufficient_funds?
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def exceed_balance_cap?(amount)
    @balance + amount > BALANCE_CAP
  end

end
