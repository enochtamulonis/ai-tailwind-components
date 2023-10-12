class AiComponent < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :component_pack, optional: true
end
