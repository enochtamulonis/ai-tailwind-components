class DashboardController < ApplicationController
  def show
    @uniq_id = Date.today.to_s + SecureRandom.hex(6)
  end
end
