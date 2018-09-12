require 'journey'

describe Journey do
  let(:entry_station) { double :station }

  describe 'Initialise' do
    it 'has no journeys recorded when initialised' do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#touch_in' do
    context 'has enough funds for minimum fare' do
      before(:each) do
        subject.touch_in(entry_station)
      end
      it 'starts a journey' do
        expect(subject).to be_in_journey
      end

      it 'remembers the entry station' do
        station_name = "Aldgate East"
        allow(entry_station).to receive(:name) {station_name}
        expect(subject.entry_station.name).to eq station_name
      end
    end

  end

  describe '#touch_out' do
    before(:each) do
      subject.touch_in(entry_station)
      @exit_station = "Hammersmith"
    end

    it 'ends a journey' do
      subject.touch_out(@exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'forgets the entry station' do
      expect{ subject.touch_out(@exit_station) }.to change{ subject.entry_station }.to be_nil
    end

    it 'records the entry and exit stations in the journey history' do
      subject.touch_out(@exit_station)
      expect(subject.journey_history).to eq [{ entry_station: entry_station, exit_station: @exit_station}]
    end
  end

end
