require 'oystercard'
describe Oystercard do
    it 'has balance of 0 when initialised' do
      expect(subject::balance).to eq 0
    end

    context '#top_up' do

      it 'increases the balance by top up amount' do
        subject.top_up(5)
        expect(subject::balance).to be 5
      end

      it 'raises error when top_up would make balance > 90' do
        expect{subject.top_up(Oystercard::BALANCE_CAP + 1)}.to raise_error(
          "Top-up can't exceed card limit of £#{Oystercard::BALANCE_CAP}")
      end
    end
end
