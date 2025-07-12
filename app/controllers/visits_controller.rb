class VisitsController < ApplicationController

  def create
    @visit = Visit.new(visit_params)

    if @visit.save
      redirect_to root_path, notice: 'Visit was successfully created.'
    else
      redirect_to root_path, alert: 'Error creating visit.'
    end
  end

  private

  def visit_params
    # Params assignment to prevent other attributes from being set
    {destination: params[:destination], ip: request.remote_ip}
  end
end
