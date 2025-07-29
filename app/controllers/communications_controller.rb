class CommunicationsController < ApplicationController

  def index
    @communications = Communication.all
  end

  def new
    @communication = Communication.new
  end

  def create
    # Check if communication parameters are present
    if params[:communication].nil?
      render plain: "Missing communication parameters", status: :unprocessable_entity
      return
    end

    @communication = Communication.new(communication_params)

    if @communication.save
      redirect_to root_path, notice: 'Communication was successfully created.'
    else
      render "pages/contact", status: :unprocessable_entity, notice: 'Error creating communication.'
    end
  end

  private

  def communication_params
    params.require(:communication).permit(:email, :message)
  end
end
