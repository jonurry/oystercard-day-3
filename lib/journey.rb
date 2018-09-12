class Journey

  attr_reader :journey_history, :entry_station

  def initialize
    @journey_history = []
    @entry_station = nil
  end

  def touch_in(station)
    @entry_station = station
  end

  def touch_out(exit_station)
    journey_history << { entry_station: @entry_station, exit_station: exit_station }
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

end
