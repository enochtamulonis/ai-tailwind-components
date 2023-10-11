class AdminsController < ApplicationController
  before_action :authorize_admin
  def index

  end

  private

  def authorize_admin
    if !current_user || !current_user.admin?
      redirect_to root_path, alert: "Sorry. you do not have access to this page"
      end
  end
end