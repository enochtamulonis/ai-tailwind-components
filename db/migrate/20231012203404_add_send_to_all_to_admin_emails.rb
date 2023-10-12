class AddSendToAllToAdminEmails < ActiveRecord::Migration[7.0]
  def change
    add_column :admin_emails, :send_to_all, :boolean, default: false
  end
end
