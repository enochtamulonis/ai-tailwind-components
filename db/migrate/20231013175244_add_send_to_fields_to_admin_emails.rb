class AddSendToFieldsToAdminEmails < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_emails, :send_to_free_users, :boolean, default: false
    add_column :admin_emails, :send_to_subscribed, :boolean, default: false
  end
end
