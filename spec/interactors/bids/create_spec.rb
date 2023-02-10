require 'rails_helper'

RSpec.describe Bids::Create, type: :interactor do
  describe '.call' do
    subject(:interactor) { described_class.call(params) }

    let(:params) { {} }
    let(:user) { create(:user) }
    let(:correct_params) do
      {
        current_user: user,
        amount: 3
      }
    end

    let(:user_with_bid) { create(:user_with_bid) }
    let(:repeated_bid_params) do
      {
        current_user: user_with_bid,
        amount: 44
      }
    end

    context 'when params is correct' do
      let(:params) { correct_params }

      it { expect(interactor.bid).to eq(user.reload.bids.first) }
    end

    context 'when bid is from same user consecutively' do
      let(:params) { repeated_bid_params }

      it { expect(interactor.error).to eq("Bid can't be from same user consecutively") }
    end

    context 'when bid is lower than last one' do
      let(:params) { correct_params }

      before { user_with_bid }

      it { expect(interactor.error).to eq("Amount can't be lower than the highest bid") }
    end
  end
end
