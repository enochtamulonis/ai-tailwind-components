class AddUserToAiComponents < ActiveRecord::Migration[7.0]
  def change
    add_reference :ai_components, :user, null: true, foreign_key: true
  end
end
