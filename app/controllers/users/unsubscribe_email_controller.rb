module Users
  class UnsubscribeEmailController < ApplicationController
    before_action :set_user
    def create
      @user.update(recieve_email_notifications: false)
      redirect_to user_unsubscribe_email_path(@user)
    end
    
    def show; end

    private

    def set_user
      @user = User.find_by_email_token(params[:user_id])
    end
  end
end