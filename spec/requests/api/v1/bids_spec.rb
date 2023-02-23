require 'rails_helper'

RSpec.describe 'Api::V1::BidsController' do
  subject(:controller) do
    request, route = self.class.description.split

    send(request, route, params: params, headers: headers)
  end

  let(:user) { create(:user) }
  let(:user_with_bid) { create(:user_with_bid) }
  let(:item) { create(:item) }
  let(:authentication) { Users::Authenticate.call(email: user.email, password: user.password) }
  let(:parsed_response) { JSON.parse(response.body) }

  let(:params) { {} }
  let(:headers) { { 'Authorization' => authentication.token } }

  before { user_with_bid && controller }

  describe 'post /api/v1/bids' do
    let(:params) { { amount: 10.25, item_id: item.id } }

    it { expect(response).to have_http_status(:created) }
    it { expect(parsed_response['success']).to be(true) }
    it { expect(user.reload.bids.first.amount).to eq(10.25) }
  end

  describe 'get /api/v1/bids' do
    it { expect(response).to have_http_status(:ok) }
    it { expect(parsed_response['current_bid']['amount']).to be_nil }
    it { expect(parsed_response['highest_bid']['amount']).to eq(5.0) }
    it { expect(parsed_response['highest_bid']['owner']).to be(false) }
  end
end
