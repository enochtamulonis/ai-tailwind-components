class Subscription < ApplicationRecord
  belongs_to :user
  enum status: [:inactive, :active]
end
