class WebhookEvent < ApplicationRecord
  serialize :data, JSON
  enum state: {pending: 0, processing: 1, processed: 2, failed: 3}
end
