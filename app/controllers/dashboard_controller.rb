class DashboardController < ApplicationController
  before_action :ensure_subscription, if: :current_user

  def show
    @uniq_id = Date.today.to_s + SecureRandom.hex(6)
  end
end
