module Items
  class Buy
    include Interactor
    include BaseInteractor

    requires :id, :user

    validate :item

    def call
      check_availability
      buy_item
      return_item
    rescue StandardError => error
      context.fail!(error: error.message)
    end

    private

    def item
      @item ||= Item.find_by(id: id)
    end

    def check_availability
      raise 'Item has already been bought' if item.bought_by.present?
    end

    def buy_item
      item.buy(user_id: user.id)
    end

    def return_item
      context.item = item.reload
    end
  end
end
