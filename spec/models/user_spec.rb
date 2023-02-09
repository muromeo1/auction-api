require 'rails_helper'

RSpec.describe User do
  subject(:model) { described_class.new }

  let(:errors) { model.errors.messages }
  let(:user) { create(:user) }
  let(:user_with_bid) { create(:user_with_bid) }

  describe 'validation' do
    context 'when adds an user with blank data' do
      before { model.valid? }

      it { expect(errors[:name].first).to eq("can't be blank") }
      it { expect(errors[:email].first).to eq("can't be blank") }
      it { expect(errors[:password].first).to eq("can't be blank") }
      it { expect(errors[:password_confirmation].first).to eq("can't be blank") }
    end

    context 'when tries to add new user with existing email' do
      before do
        model.email = user.email

        model.valid?
      end

      it { expect(errors[:email].first).to eq('has already been taken') }
    end
  end

  describe 'associations' do
    context 'when deletes an user with bid' do
      before { user_with_bid.destroy! }

      it { expect(user_with_bid.bids).to be_blank }
    end
  end
end
