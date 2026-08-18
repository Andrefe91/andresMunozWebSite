class MessageMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.message_mailer.new_message.subject
  #
  def new_message
    @message = params[:communication]

    mail(to: Rails.application.credentials.personal.email, subject: "New message through the webpage - Id: #{@message.id}")
  end
end
