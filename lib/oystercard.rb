class Oystercard
  attr_reader :balance
  BALANCE_CAP = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if @balance + amount > BALANCE_CAP
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
