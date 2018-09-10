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
    end
end
