module Api
  module V1
    class BidsController < ApplicationController
      def create
        result = Bids::Create.call(bids_params)

        if result.success?
          render_json(success: true, status: 201)
        else
          render_json(error: result.error, status: 422)
        end
      end

      private

      def bids_params
        new_params = params.permit(:amount)
        new_params.merge({ current_user: current_user })
      end
    end
  end
end
