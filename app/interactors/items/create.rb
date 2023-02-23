module Items
  class Create
    include Interactor
    include BaseInteractor

    requires :name

    def call
      item.save! ? return_item : raise_error
    rescue StandardError => error
      context.fail!(error: error.message)
    end

    private

    def item
      @item ||= Item.new(
        name: name,
        instant_buy_price: context.instant_buy_price
      )
    end

    def return_item
      context.item = item
    end

    def raise_error
      raise item.errors.messages
    end
  end
end
