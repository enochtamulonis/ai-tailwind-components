class AddStateToWebhookEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :webhook_events, :state, :integer, default: 0
  end
end
