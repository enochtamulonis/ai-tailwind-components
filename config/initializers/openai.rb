OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(:open_ai, :access_token)
  config.organization_id = Rails.application.credentials.dig(:open_ai, :organization_id)
end