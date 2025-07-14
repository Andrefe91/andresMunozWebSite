# Preview all emails at http://localhost:3000/rails/mailers/visit_mailer
class VisitMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/visit_mailer/qr_visit
  def qr_visit
    VisitMailer.qr_visit
  end
end
