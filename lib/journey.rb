class Journey

  attr_reader :journey_history, :entry_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journey_history = []
    @entry_station = nil
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(exit_station)
    @journey_history << { entry_station: @entry_station, exit_station: exit_station }
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def fare
    return PENALTY_FARE if penalty?
    MINIMUM_FARE
  end

  private

  def penalty?
    journey_history_empty? || 
    last_journey_missing_entry_station? || 
    last_journey_missing_exit_station?
  end

  def journey_history_empty?
    @journey_history.empty?
  end

  def last_journey_missing_entry_station?
    !@journey_history.last[:entry_station]
  end

  def last_journey_missing_exit_station?
    !@journey_history.last[:exit_station]
  end

end
