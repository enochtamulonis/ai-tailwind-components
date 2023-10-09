class AddProcessingErrorsToWebhookEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :webhook_events, :processing_errors, :text
  end
end
