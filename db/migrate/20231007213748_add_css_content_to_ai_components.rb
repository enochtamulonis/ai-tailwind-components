class AddCssContentToAiComponents < ActiveRecord::Migration[7.0]
  def change
    add_column :ai_components, :css_content, :text
  end
end
