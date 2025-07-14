class VisitsController < ApplicationController
  def create
    @visit = Visit.new(visit_params)

    if @visit.save
      # Send the visit information via email
      VisitMailer.with(visit: @visit).qr_visit.deliver_now

      # Redirect to the destination URL
      case @visit.destination
      when "linkedin"
            redirect_to "https://www.linkedin.com/in/andres-felipe-m/?locale=en_US", allow_other_host: true
      when "youtube"
            redirect_to "https://www.youtube.com/", allow_other_host: true
      else
            redirect_to root_path, alert: "Invalid destination."
      end
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
