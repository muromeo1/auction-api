module Bids
  class Create
    include Interactor
    include BaseInteractor

    requires :current_user,
             :amount,
             :item_id

    def call
      bid.valid? ? create_bid : raise_error
    rescue StandardError => error
      context.fail!(error: error.message)
    end

    private

    def bid
      @bid ||= current_user.bids.new(
        item_id: item_id,
        amount: amount
      )
    end

    def create_bid
      context.bid = bid.save! && bid
    end

    def raise_error
      raise bid.errors.first.full_message
    end
  end
end
