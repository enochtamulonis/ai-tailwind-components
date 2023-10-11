class WelcomeMailer < ApplicationMailer
  def send_welcome_email(user)
    @user = user
    mail({
      to: user.email,
      subject: 'Welcome to the family! Thanks for joining'
      })
  end
end
