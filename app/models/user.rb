class User < ApplicationRecord
  has_secure_password

  has_many :bids, dependent: :destroy

  validates :name, :password, :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
end
