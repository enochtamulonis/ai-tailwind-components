class AddDailyTrysToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :daily_trys, :integer, default: 5
  end
end
