class ComponentPack < ApplicationRecord
  has_rich_text :description
  has_many :ai_components
end
