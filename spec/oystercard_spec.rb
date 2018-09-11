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

      it 'raises error when top_up would make balance over the balance cap' do
        expect{subject.top_up(Oystercard::BALANCE_CAP + 1)}.to raise_error(
          "Top-up can't exceed card limit of £#{Oystercard::BALANCE_CAP}")
      end
    end

    context '#deduct' do
      it 'decreases the balance by given amount' do
        subject.top_up(20)
        subject.deduct(5)
        expect(subject.balance).to eq 15
      end
    end

    context '#touch_in' do
      it 'starts a journey' do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in
        expect(subject).to be_in_journey
      end
      it 'raises error if balance below minimum fare' do
        expect{subject.touch_in}.to raise_error("Insufficient funds!")
      end
    end

    context '#touch_out' do
      it 'ends a journey' do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
end
