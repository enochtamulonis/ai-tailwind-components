class Admin::Email < ApplicationRecord
  serialize :to_user_ids, Array
end
