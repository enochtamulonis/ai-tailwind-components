class AddPurchasedLifetimeMembershipToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :purchased_lifetime_membership, :boolean, default: false
  end
end
