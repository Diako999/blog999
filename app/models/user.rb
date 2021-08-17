class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  before_save {self.email = email.downcase}
  validates :username, presence: true,
    uniqueness: { case_sensitive: false },
    length: {minimum:3, maximum:65}
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true,
    uniqueness: { case_sensitive: false },
    format: {with: VALID_EMAIL_REGEX}

  has_secure_password
end
