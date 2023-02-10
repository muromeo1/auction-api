module Api
  module V1
    class BidsController < ApplicationController
      def index
        render_json(
          current_bid: { amount: current_user.bids.last&.amount },
          highest_bid: {
            amount: highest_bid&.amount,
            owner: from_curren_user?
          },
          status: 200
        )
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

      def from_curren_user?
        highest_bid&.user_id == current_user.id
      end

      def bids_params
        new_params = params.permit(:amount)
        new_params.merge({ current_user: current_user })
      end
    end
  end
end
