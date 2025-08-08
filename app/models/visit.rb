class Visit < ApplicationRecord
  validates :destination, presence: true, length: { maximum: 25 }
  validate :exact_route
  after_create :send_qr_visit_email

  # Ensure that the destination is either 'linkedin' or 'youtube'
  def exact_route
    unless [ "linkedin", "youtube" ].include?(destination)
      errors.add(:destination, "The route must be either 'linkedin' or 'youtube'")
    end
  end

  private

  def send_qr_visit_email
    VisitMailer.with(visit: @visit).qr_visit.deliver_now
  rescue StandardError => e
    Rails.logger.error "Failed to send QR visit email"
  end
end
