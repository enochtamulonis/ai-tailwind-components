# Preview all emails at http://localhost:3000/rails/mailers/admin_email_mailer
class AdminEmailMailerPreview < ActionMailer::Preview
  def send_email
    subject = "Exciting News for Tailwind Genius! Now Offering a Free Trial!"
    body = "
    Dear <name>,
    I'm thrilled to share some exciting news with you – Tailwind Genius is now offering a free trial! We've listened to your feedback and understand that you'd like the opportunity to try out the app more extensively before deciding on a membership. In response, I'm excited to let you know that a free version is now available.
    As a valued user who has already signed up, I wanted to personally reach out to you and share this fantastic opportunity. You can now experience the full range of Tailwind Genius features at no cost for a limited time.
    Take advantage of this free trial to explore the benefits of Tailwind Genius and discover how it can elevate your social media management experience. Your feedback is invaluable to us, and we believe that this trial will help you make an informed decision about the membership.
    Ready to get started? Simply visit our website Tailwind Genius and enjoy the free trial period.
    Thank you for being part of the Tailwind Genius community. We're excited to continue this journey with you!
    Best regards,
    
    Enoch Tamulonis
    Founder
    Tailwind Genius
    @TailwindGenius on twitter"
    email = Admin::Email.new(subject: subject, body: body, send_to_all: true)
    user = User.create(full_name: 'Maurício Ackermann', email: 'eu@mauricioackermann.com.br', password: Devise.friendly_token.first(6))
    AdminEmailMailer.send_email(email, user)
  end
end
