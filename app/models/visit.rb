class Visit < ApplicationRecord

  validates :destination, presence: true

  validate :exact_route

  # Ensure that the destination is either 'linkedin' or 'youtube'
  def exact_route
    unless ['linkedin', 'youtube'].include?(destination)
      errors.add(:destination, "The route must be either 'linkedin' or 'youtube'")
    end
  end
end
