class User < ApplicationRecord

  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    user && user.authenticate(password)
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 5}
  validates :password_confirmation, presence: true
  validates :password, confirmation: true
  validates :email, presence: true, uniqueness: true, format: { without: /\s/ }
  
end
