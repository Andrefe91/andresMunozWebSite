class CommunicationsController < ApplicationController
  def index
    @communications = Communication.all
  end

  def new
    @communication = Communication.new
  end

  def create
    @communication = Communication.new(communication_params)

    respond_to do |format|
      if @communication.save
        # Successful form submission
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "communication_form",
            partial: "pages/communications/successMessage"
          )
        end

        format.html do
          # fallback for non-Turbo requests
          redirect_to root_path, notice: "Communication was successfully created."
        end
      else
        # Form failed validation
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "communication_form",
            partial: "pages/communications/form",
            locals: { communication: @communication }
          )
        end

        format.html do
          if request.headers["Accept"]&.include?("text/vnd.turbo-stream.html")
            head :unprocessable_entity
          else
            render "pages/contact", status: :unprocessable_entity
          end
        end
      end
    end
  end

  private

  def communication_params
    params.require(:communication).permit(:email, :message)
  end
end
