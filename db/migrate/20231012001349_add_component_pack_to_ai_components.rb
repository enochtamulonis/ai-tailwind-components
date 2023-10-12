class AddComponentPackToAiComponents < ActiveRecord::Migration[7.0]
  def change
    add_reference :ai_components, :component_pack, null: true, foreign_key: true
  end
end
