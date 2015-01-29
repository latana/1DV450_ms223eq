class User < ActiveRecord::Base
  before_save {self.email = email.downcase}
  validates :password_digest, length:{maximum: 255}, presence: true
  validates :key, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
end
