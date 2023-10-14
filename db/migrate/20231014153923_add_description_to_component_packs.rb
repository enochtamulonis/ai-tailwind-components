class AddDescriptionToComponentPacks < ActiveRecord::Migration[7.0]
  def change
    add_column :component_packs, :description, :text
  end
end
