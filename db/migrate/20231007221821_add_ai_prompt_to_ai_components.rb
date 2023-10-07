class AddAiPromptToAiComponents < ActiveRecord::Migration[7.0]
  def change
    add_column :ai_components, :ai_prompt, :string
  end
end
