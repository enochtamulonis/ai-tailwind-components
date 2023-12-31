class AdminEmailJob < ApplicationJob
  queue_as :default

  def perform(email_id)
    @email = Admin::Email.find(email_id)
    @users = if @email.send_to_all?
      User.all
    elsif @email.send_to_subscribed?
      User.paid_users
    elsif @email.send_to_free_users?
      User.free_users
    else
      User.where(email: ["enochtamulonis@gmail.com", "rastaboys420@gmail.com", "veganforager@gmail.com", "kurtamulonis@gmail.com"])
    end
    @users.each do |user|
      AdminEmailMailer.send_email(@email, user).deliver
    end
  end
end
