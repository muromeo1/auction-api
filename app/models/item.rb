class Item < ApplicationRecord
  has_many :bids, dependent: :delete_all

  validates :name, presence: true

  def buy(user_id:)
    update!(bought_by: user_id)
  end
end
