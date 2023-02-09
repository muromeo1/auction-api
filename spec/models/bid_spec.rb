require 'rails_helper'

RSpec.describe Bid do
  subject(:model) { described_class.new }

  let(:errors) { model.errors.messages }
  let(:bid) { create(:bid) }

  describe 'validation' do
    context 'when adds a bid with blank data' do
      before { model.valid? }

      it { expect(errors[:user].first).to eq('must exist') }
      it { expect(errors[:amount].first).to eq('must be greater than 0') }
    end
  end
end
