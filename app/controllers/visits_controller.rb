class VisitsController < ApplicationController
  def create
    @visit = Visit.new(visit_params)

    if @visit.save
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
    { destination: params[:destination], ip: request.remote_ip }
  end
end
