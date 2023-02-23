module Api
  module V1
    class BidsController < ApplicationController
      skip_before_action :authorize, only: %i[index]

      def index
        render_json(payload)
      end

      def create
        result = Bids::Create.call(bids_params)

        if result.success?
          render_json(success: true, status: 201)
        else
          render_json(error: result.error, status: 422)
        end
      end

      private

      def payload
        if current_user.present?
          current_bid_payload.merge!(highest_bid_payload)
        else
          highest_bid_payload
        end
      end

      def current_bid_payload
        {
          current_bid: {
            amount: current_user&.bids&.last&.amount
          }
        }
      end

      def highest_bid_payload
        {
          highest_bid: {
            amount: highest_bid&.amount,
            owner: from_current_user?
          }
        }
      end

      def from_current_user?
        return false if current_user.blank?

        highest_bid&.user_id == current_user.id
      end

      def bids_params
        new_params = params.permit(:amount, :item_id)
        new_params.merge({ current_user: current_user })
      end
    end
  end
end
