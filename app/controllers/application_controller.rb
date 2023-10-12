class ApplicationController < ActionController::Base
  before_action :set_guest_token

  private

  def set_guest_token
    if !session[:guest_token].present?
      session[:guest_token] = Date.today.to_s + SecureRandom.hex(6)
    end
    @guest_token = session[:guest_token]
  end
end
