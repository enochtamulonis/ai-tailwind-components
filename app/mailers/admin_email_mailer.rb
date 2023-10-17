class AdminEmailMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  def send_email(email, user)
    @email = email
    @user = user
    @unsubscribe_url = user_unsubscribe_email_url(user.email_token)
    name = @user.full_name || "User"
    @body = @email.body.gsub("<name>", name)
    mail({
      to: @user.email,
      subject: @email.subject
    })
  end
end
