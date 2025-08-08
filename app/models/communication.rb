class Communication < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper

  validates :email, allow_blank: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { maximum: 1000 }

  before_validation :sanitize_message
  after_create :send_message_email

  private

  def send_message_email
    MessageMailer.with(communication: self).new_message.deliver_later
  rescue StandardError => e
    Rails.logger.error "Failed to send message email: #{e.message}"
  end

  # Sanitize the message to allow only specific HTML tags
  def sanitize_message
    self.message = sanitize(self.message, tags: %w[p br strong em ul ol li])
  rescue StandardError => e
    Rails.logger.error "Failed to sanitize message: #{e.message}"
    self.message = "Invalid message content - Error during sanitization"
  end
end
