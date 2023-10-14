class ApplicationController < ActionController::Base
  before_action :set_guest_token, unless: :current_user

  def set_guest_token
    if !session[:guest_token].present?
      session[:guest_token] = SecureRandom.hex(6)
    end
    @guest_token ||= session[:guest_token]
  end
end
