# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview
  def send_welcome_email
    WelcomeMailer.send_welcome_email(User.new(full_name: 'Maurício Ackermann', email: 'eu@mauricioackermann.com.br'))
  end
end
