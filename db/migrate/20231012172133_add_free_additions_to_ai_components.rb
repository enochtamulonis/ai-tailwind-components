class AddFreeAdditionsToAiComponents < ActiveRecord::Migration[7.0]
  def change
    add_column :ai_components, :free_additions, :integer, default: 5
  end
end
