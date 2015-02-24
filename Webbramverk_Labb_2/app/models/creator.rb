class Creator < ActiveRecord::Base

  has_many :events

  validates :user, presence: true
  validates :password_digest, presence: true
  has_secure_password
end
