class CreateWebhookEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :webhook_events do |t|
      t.string :source
      t.text :data
      t.string :external_id

      t.timestamps
    end
  end
end
