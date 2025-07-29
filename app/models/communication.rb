class Communication < ApplicationRecord
  validates :email, allow_blank: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { maximum: 1000 }
end
