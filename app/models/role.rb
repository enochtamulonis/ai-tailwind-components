class Role < ApplicationRecord
  def self.admin_role
    where(name: "admin").first
  end
end
