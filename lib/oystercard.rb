require 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey

  BALANCE_CAP = 90

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Top-up can't exceed card limit of £#{BALANCE_CAP}" if exceed_balance_cap?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds!" if insufficient_funds?
    journey.touch_in(station)
  end

  def touch_out(exit_station)
    deduct(Journey::MINIMUM_FARE)
    journey.touch_out(exit_station)
  end

  def in_journey?
    journey.in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_balance_cap?(amount)
    @balance + amount > BALANCE_CAP
  end

  def insufficient_funds?
    @balance < Journey::MINIMUM_FARE
  end

end
