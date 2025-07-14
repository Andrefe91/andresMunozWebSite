class VisitMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.visit_mailer.qr_visit.subject
  #
  def qr_visit
    @visit = params[:visit]

    mail(to: Rails.application.credentials.personal.email, subject: "New visit through the QR card") 
  end
end
