class AddRecieveEmailNotificationsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :recieve_email_notifications, :boolean, default: true
  end
end
