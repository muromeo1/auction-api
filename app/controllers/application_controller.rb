class ApplicationController < ActionController::API
  before_action :authorize

  def current_user
    @current_user ||= authorize_token.user
  end

  def highest_bid
    @highest_bid ||= Bid.last
  end

  def render_json(hash)
    status = hash.extract!(:status)[:status] || 200

    render json: hash, status: status
  end

  private

  def authorize
    authorize_token.success? ? current_user : render_json(error: authorize_token.error)
  end

  def authorize_token
    @authorize_token ||= Sessions::AuthorizeToken.call(token: request.headers['Authorization'])
  end
end
