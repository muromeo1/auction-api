module Api
  module V1
    class ItemsController < ApplicationController
      def show
        render_json(item: item)
      end

      def create
        result = Items::Create.call(items_params)

        if result.success?
          render_json(success: true, item: result.item, status: 201)
        else
          render_json(error: result.error, status: 422)
        end
      end

      def buy
        result = Items::Buy.call(items_params)

        if result.success?
          render_json(success: true, item: result.item, status: 201)
        else
          render_json(error: result.error, status: 422)
        end
      end

      private

      def item
        @item ||= Item.find_by(id: items_params[:id])
      end

      def items_params
        params.permit(
          :id,
          :name,
          :instant_buy_price
        ).merge!(user: current_user)
      end
    end
  end
end
