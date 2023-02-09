require 'rails_helper'

RSpec.describe User do
  subject(:model) { described_class.new }

  let(:errors) { model.errors.messages }
  let(:user) { create(:user) }

  describe 'validation' do
    context 'when adds an user with blank data' do
      before { model.valid? }

      it 'returns error on name' do
        expect(errors[:name].first).to eq("can't be blank")
      end

      it 'returns error on email' do
        expect(errors[:email].first).to eq("can't be blank")
      end

      it 'returns error on password' do
        expect(errors[:password].first).to eq("can't be blank")
      end

      it 'returns error on password_confirmation' do
        expect(errors[:password_confirmation].first).to eq("can't be blank")
      end
    end

    context 'when tries to add new user with existing email' do
      before do
        model.email = user.email

        model.valid?
      end

      it 'returns error on email' do
        expect(errors[:email].first).to eq('has already been taken')
      end
    end
  end
end
