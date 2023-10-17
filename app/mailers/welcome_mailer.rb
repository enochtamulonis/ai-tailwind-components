class WelcomeMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  def send_welcome_email(user)
    @user = user
    @unsubscribe_url = user_unsubscribe_email_url(user.email_token)
    mail({
      to: user.email,
      subject: 'Welcome to the family! Thanks for joining'
      })
  end
end
