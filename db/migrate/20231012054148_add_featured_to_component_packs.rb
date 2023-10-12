class AddFeaturedToComponentPacks < ActiveRecord::Migration[7.0]
  def change
    add_column :component_packs, :featured, :boolean, default: false
  end
end
