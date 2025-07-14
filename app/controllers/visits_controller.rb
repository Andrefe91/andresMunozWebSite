class VisitsController < ApplicationController
  def create
    # Ensure the destination is one of the allowed values
    unless %w[linkedin youtube].include?(params[:destination])
      redirect_to root_path, alert: "Invalid destination." and return
    end

    @visit = Visit.new(visit_params)

    if @visit.save
      VisitMailer.with(visit: @visit).qr_visit.deliver_now

      redirect_to case @visit.destination
      when "linkedin"
        "https://www.linkedin.com/in/andres-felipe-m/?locale=en_US"
      when "youtube"
        "https://www.youtube.com/"
      end, allow_other_host: true
    else
      redirect_to root_path, alert: "Error creating visit."
    end
  end

  private

  def visit_params
    # Params assignment to prevent other attributes from being set
    # Remeber, the location can be spoofed modifying the parameter in the URL, this is just for reference only.
    # So far, this is the URL used to distribute the QR code: /qr?destination=foo&location=bar
    { destination: params[:destination], ip: request.remote_ip, location: params[:location] }
  end
end
