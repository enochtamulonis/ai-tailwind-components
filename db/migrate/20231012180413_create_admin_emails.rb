class CreateAdminEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_emails do |t|
      t.string :subject
      t.string :body
      t.text :to_user_ids

      t.timestamps
    end
  end
end
