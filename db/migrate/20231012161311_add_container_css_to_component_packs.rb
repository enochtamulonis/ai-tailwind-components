class AddContainerCssToComponentPacks < ActiveRecord::Migration[7.0]
  def change
    add_column :component_packs, :container_css, :text
  end
end
