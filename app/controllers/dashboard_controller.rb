class DashboardController < ApplicationController
  before_action :ensure_subscription, if: :current_user

  def show
    @uniq_id = Date.today.to_s + SecureRandom.hex(6)
  end

  private

  def ensure_subscription
    return if current_user.active_subscription
    redirect_to new_subscription_path
  end
end
