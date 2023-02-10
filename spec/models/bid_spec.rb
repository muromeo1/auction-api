require 'rails_helper'

RSpec.describe Bid do
  subject(:model) { described_class.new }

  let(:errors) { model.errors.messages }
  let(:user) { create(:user) }

  let(:bid) { build(:bid, user: user) }
  let(:bid2) { build(:bid, user: user) }

  describe 'validation' do
    context 'when adds a bid with blank data' do
      before { model.valid? }

      it { expect(errors[:user].first).to eq('must exist') }
      it { expect(errors[:amount].first).to eq('must be greater than 0.0') }
    end

    context 'when new bid is from same user' do
      before { bid.save && bid2.save }

      it { expect(bid2.errors.messages[:bid].first).to eq("can't be from same user consecutively") }
    end
  end
end
