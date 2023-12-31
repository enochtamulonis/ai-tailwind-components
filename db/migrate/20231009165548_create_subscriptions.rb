class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :stripe_subscription_id

      t.timestamps
    end
  end
end
