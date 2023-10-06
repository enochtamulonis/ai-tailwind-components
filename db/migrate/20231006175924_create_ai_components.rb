class CreateAiComponents < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_components do |t|
      t.text :html_content
      t.string :name

      t.timestamps
    end
  end
end
