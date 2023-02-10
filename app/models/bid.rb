class Bid < ApplicationRecord
  belongs_to :user

  validates :amount, numericality: { greater_than: 0.0 }

  validate :previous, unless: -> { Bid.last.blank? }

  private

  def previous
    errors.add(:bid, "can't be from same user consecutively") if from_same_user?
    errors.add(:amount, "can't be lower than the highest bid") if lower_than_highest?
    errors.add(:amount, "can't be equal the highest bid") if equal_than_highest?
  end

  def from_same_user?
    user_id == Bid.last&.user_id
  end

  def lower_than_highest?
    amount < Bid.last&.amount
  end

  def equal_than_highest?
    amount == Bid.last&.amount
  end
end
