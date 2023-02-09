require 'rails_helper'

RSpec.describe Users::Create, type: :interactor do
  describe '.call' do
    subject(:interactor) { described_class.call(params) }

    let(:params) { {} }
    let(:random_pass) { Faker::Internet.password }
    let(:user) { create(:user) }
    let(:correct_params) do
      {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: random_pass,
        password_confirmation: random_pass
      }
    end

    context 'when pass correct params' do
      let(:params) { correct_params }

      it { expect(interactor.user.email).to eq(correct_params[:email]) }
      it { expect(interactor.token).to be_present }
    end

    context 'when email is already registered' do
      let(:params) { correct_params.merge({ email: user.email }) }

      it { expect(interactor.error).to match(/registered/) }
    end

    context 'when email has especial characters' do
      let(:params) { correct_params.merge({ email: 'Émaäíl@asldk.com' }) }

      it { expect(interactor.user.email).to eq('emaail@asldk.com') }
      it { expect(interactor.token).to be_present }
    end

    context 'when name is empty' do
      let(:params) { correct_params.merge!(name: '') }

      it { expect(interactor.error).to eq("name can't be nil") }
    end

    context 'when email is empty' do
      let(:params) { correct_params.merge!(email: '') }

      it { expect(interactor.error).to eq("email can't be nil") }
    end

    context 'when password is empty' do
      let(:params) { correct_params.merge!(password: '') }

      it { expect(interactor.error).to eq("password can't be nil") }
    end

    context 'when password_confirmation is empty' do
      let(:params) { correct_params.merge!(password_confirmation: '') }

      it { expect(interactor.error).to eq("password_confirmation can't be nil") }
    end
  end
end
