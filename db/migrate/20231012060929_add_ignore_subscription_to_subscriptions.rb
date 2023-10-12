class AddIgnoreSubscriptionToSubscriptions < ActiveRecord::Migration[7.0]
  def change
    add_column :subscriptions, :ignore_subscription, :boolean, default: false
  end
end
