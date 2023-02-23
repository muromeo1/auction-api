class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :amount, numericality: { greater_than: 0.0 }

  validate :item_bought?
  validate :previous, unless: -> { item&.bids&.last.blank? }

  private

  def item_bought?
    errors.add(:item, 'has already been bought') if item&.bought_by.present?
  end

  def previous
    errors.add(:bid, "can't be from same user consecutively") if from_same_user?
    errors.add(:amount, "can't be lower than the highest bid") if lower_than_highest?
    errors.add(:amount, "can't be equal the highest bid") if equal_than_highest?
  end

  def from_same_user?
    user_id == item.bids.last&.user_id
  end

  def lower_than_highest?
    amount < item.bids.last&.amount
  end

  def equal_than_highest?
    amount == item.bids.last&.amount
  end
end
