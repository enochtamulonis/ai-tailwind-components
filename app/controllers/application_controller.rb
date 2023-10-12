class ApplicationController < ActionController::Base
  def authenticate_user_free_trys
    return if current_user&.active_subscription
    case session[:free_trys]
    when nil
      session[:free_trys] = 1
    when 0
      session[:ai_component_id] = params[:id]
      redirect_to new_user_session_path(more_info: true), alert: "Create an account to continue using Tailwind Genius"
    when 1
      # okay keep going
    end
  end

  def ensure_subscription
    return if !current_user || current_user.active_subscription
    redirect_to new_subscription_path
  end
end
