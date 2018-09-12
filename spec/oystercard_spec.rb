require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  # before(:each) do
  #   expect(entry_station).to have_attributes(:name => "Hammersmith", :zone => 1)
  # end

  describe 'Initialise' do
    it 'has balance of 0 when initialised' do
      expect(subject::balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases the balance by top up amount' do
      subject.top_up(5)
      expect(subject::balance).to be 5
    end

    it 'raises error when top_up would make balance over the balance cap' do
      expect{subject.top_up(Oystercard::BALANCE_CAP + 1)}.to raise_error(
        "Top-up can't exceed card limit of £#{Oystercard::BALANCE_CAP}")
    end
  end

  describe '#touch_in' do
    context 'has no funds' do
      it 'raises error if balance below minimum fare' do
        expect{subject.touch_in(entry_station)}.to raise_error("Insufficient funds!")
      end
    end
  end

  describe '#touch_out' do
    before(:each) do
      @fare = 1 # Oystercard::MINIMUM_FARE
      subject.top_up(@fare)
      subject.touch_in(entry_station)
    end

    it 'charges minimum fare' do
      expect{ subject.touch_out("Hammersmith") }.to change{ subject.balance }.by(-@fare)
    end
  end

end
