class User < ApplicationRecord
  has_secure_password

  validates :name, :password, :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
end
