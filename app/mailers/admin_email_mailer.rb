class AdminEmailMailer < ApplicationMailer
  def send_email(email, user)
    @email = email
    @user = user
    name = @user.full_name || "User"
    @body = @email.body.gsub("<name>", name)
    mail({
      to: @user.email,
      subject: @email.subject
    })
  end
end
