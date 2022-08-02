class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 5}
  validates :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :email, presence: true, uniqueness: true
  
end
