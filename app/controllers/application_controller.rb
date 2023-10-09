class ApplicationController < ActionController::Base
  def authenticate_user_free_trys
    return if current_user&.active_subscription
    case session[:free_trys]
    when nil
      session[:free_trys] = 1
    when 0
      redirect_to new_user_session_path, alert: "Sign up to continue"
    when 1
      # okay keep going
    end
  end

  def ensure_subscription
    return if current_user.active_subscription
    redirect_to new_subscription_path
  end
end
