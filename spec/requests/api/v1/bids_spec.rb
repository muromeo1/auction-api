require 'rails_helper'

RSpec.describe 'Api::V1::BidsController' do
  subject(:controller) do
    request, route = self.class.description.split

    send(request, route, params: params, headers: headers)
  end

  let(:user) { create(:user) }
  let(:authentication) { Users::Authenticate.call(email: user.email, password: user.password) }
  let(:parsed_response) { JSON.parse(response.body) }

  let(:params) { {} }
  let(:headers) { { 'Authorization' => authentication.token } }

  before { controller }

  describe 'post /api/v1/bids' do
    let(:params) { { amount: 1.25 } }

    it { expect(response).to have_http_status(:created) }
    it { expect(parsed_response).to include({ 'success' => true }) }
    it { expect(user.reload.bids.first.amount).to eq(1.25) }
  end
end
