class Communication < ApplicationRecord
  validates :email, allow_blank: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { maximum: 1000 }

  after_create :send_message_email

  private

  def send_message_email
    MessageMailer.with(communication: self).new_message.deliver_later
  rescue StandardError => e
    Rails.logger.error "Failed to send message email: #{e.message}"
  end
end
