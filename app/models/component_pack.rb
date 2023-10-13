class ComponentPack < ApplicationRecord
  has_rich_text :description
  has_many :ai_components, dependent: :destroy
  has_one_attached :image
end
